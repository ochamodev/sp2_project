from flask import jsonify
from flask_restx import Namespace, Resource, fields
from flask_jwt_extended import jwt_required, get_jwt
from domain.dto.base_response_dto import BaseResponseDTO
from domain.response_codes import ResponseCodes
from domain.reports.get_sales_performance_use_case import get_sales_performance_use_case, get_sales_performance_use_case2, get_sales_performance_use_case3

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
        result = get_sales_performance_use_case2(claims['e'])
        return jsonify(result)
