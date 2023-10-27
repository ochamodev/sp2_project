from flask import jsonify
from flask_restx import Namespace, Resource, fields
from flask_jwt_extended import jwt_required, get_jwt
from domain.dto.base_response_dto import BaseResponseDTO
from domain.reports.get_customer_lifetime_value_use_case import get_customer_lifetime_value_use_case
from domain.response_codes import ResponseCodes
from domain.reports.get_sales_performance_use_case import get_sales_performance_use_case
from domain.reports.get_billing_year_use_case import get_billing_years_use_case

api = Namespace('reports', 'Report operations')

salesPerformanceRequest = api.model('SalesPerformanceRequest', {
    'establishmentId': 'int'
})


@api.route('/salesPerformance')
class SalesPerformance(Resource):
    @api.doc('SalesPerformance')
    @jwt_required()
    def post(self):
        claims = get_jwt()
        result = get_sales_performance_use_case(claims['e'])
        return jsonify(result)


@api.route('/customerLifetimeValue')
class CustomerLifetimeValue(Resource):
    @api.doc('CustomerLifetimeValue')
    @jwt_required()
    def post(self):
        claims = get_jwt()
        result = get_customer_lifetime_value_use_case(claims['e'])
        return jsonify(result)


@api.route('/yearFilters')
class YearFiltersCompany(Resource):
    @api.doc('YearFilters')
    @jwt_required()
    def post(self):
        claims = get_jwt()
        result = get_billing_years_use_case(claims['e'])
        return jsonify(result)
