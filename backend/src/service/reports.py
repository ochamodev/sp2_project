from flask import jsonify
from flask_restx import Namespace, Resource, fields
from flask_jwt_extended import jwt_required, get_jwt
from domain.dto.base_response_dto import BaseResponseDTO
from domain.get_response_code_use_case import get_response_code_use_case
from domain.reports.get_customer_lifetime_value_use_case import get_customer_lifetime_value_use_case
from domain.reports.get_users_in_company_use_case import get_users_in_company
from domain.response_codes import ResponseCodes
from domain.reports.get_sales_performance_use_case import get_sales_performance_use_case
from domain.reports.get_billing_year_use_case import get_billing_years_use_case
from domain.reports.get_customer_retention_rate_use_case import get_customer_retention_use_case
from domain.dto.selected_company_dto import SelectedCompanyDTO

api = Namespace('reports', 'Report operations')

salesPerformanceRequest = api.model('SalesPerformanceRequest', {
    'establishmentId': fields.String()
})

currentCompanyModel = api.model('CurrentCompanyRequest', {
    'currentCompany': fields.Integer()
})


def validateIfUserHasAccess(items, currentCompany: SelectedCompanyDTO):
    result = None
    for i in items:
        if i == currentCompany.currentCompany:
            result = None
        else:
            result = BaseResponseDTO(
                data=get_response_code_use_case(
                    ResponseCodes.user_has_no_access),
                success=False
            )
    return result


@api.route('/salesPerformance')
class SalesPerformance(Resource):
    @api.doc('SalesPerformance')
    @api.expect(currentCompanyModel)
    @jwt_required()
    def post(self):
        claims = get_jwt()
        currentCompany: SelectedCompanyDTO = SelectedCompanyDTO.Schema().load(api.payload)
        returnData = validateIfUserHasAccess(
            items=claims, currentCompany=currentCompany)
        if returnData != None:
            result = get_sales_performance_use_case(
                currentCompany.currentCompany)
            return jsonify(result)
        else:
            return returnData


@api.route('/customerLifetimeValue')
class CustomerLifetimeValue(Resource):
    @api.doc('CustomerLifetimeValue')
    @api.expect(currentCompanyModel)
    @jwt_required()
    def post(self):
        claims = get_jwt()
        currentCompany: SelectedCompanyDTO = SelectedCompanyDTO.Schema().load(api.payload)
        returnData = validateIfUserHasAccess(
            items=claims, currentCompany=currentCompany)
        if returnData != None:
            result = get_customer_lifetime_value_use_case(
                currentCompany.currentCompany)
            return jsonify(result)
        else:
            return returnData


@api.route('/customerRetention')
class CustomerRetentionRate(Resource):
    @api.doc('CustomerRetention')
    @api.expect(currentCompanyModel)
    @jwt_required()
    def post(self):
        claims = get_jwt()
        currentCompany: SelectedCompanyDTO = SelectedCompanyDTO.Schema().load(api.payload)
        returnData = validateIfUserHasAccess(
            items=claims, currentCompany=currentCompany)
        if returnData != None:
            result = get_customer_retention_use_case(
                currentCompany.currentCompany)
            return jsonify(result)
        else:
            return returnData


@api.route('/yearFilters')
class YearFiltersCompany(Resource):
    @api.doc('YearFilters')
    @api.expect(currentCompanyModel)
    @jwt_required()
    def post(self):
        claims = get_jwt()
        currentCompany: SelectedCompanyDTO = SelectedCompanyDTO.Schema().load(api.payload)
        returnData = validateIfUserHasAccess(
            items=claims, currentCompany=currentCompany)
        if returnData != None:
            result = get_billing_years_use_case(currentCompany.currentCompany)
            return jsonify(result)
        else:
            return returnData


@api.route('/getUsersInCompany')
class GetUsersInCompany(Resource):
    @api.expect(currentCompanyModel)
    @jwt_required()
    def post(self):
        claims = get_jwt()
        currentCompany: SelectedCompanyDTO = SelectedCompanyDTO.Schema().load(api.payload)
        returnData = validateIfUserHasAccess(
            items=claims, currentCompany=currentCompany)
        if returnData != None:
            result = get_users_in_company(currentCompany.currentCompany)
            return jsonify(result)
        else:
            return returnData
