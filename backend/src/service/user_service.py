from flask import jsonify
from flask_restx import Namespace, Resource, fields

api = Namespace('user', 'User operations')

loginModel = api.model('LoginModel', {
    'email': fields.String(required=True),
    'password': fields.String(required=True)
})

registerUserModel = api.model('RegisterUserModel', {
    'userEmail': fields.String(required=True),
    'password': fields.String(required=True),
    'name': fields.String(required=True),
    'lastName': fields.String(required=True),
    'nitEmpresa': fields.String(required=True),
    'nameEmpresa': fields.String(required=True)
})


@api.route('/login')
class UserService(Resource):
    @api.doc('Login')
    @api.expect(loginModel)
    def post(self):
        print(api.payload)
        return jsonify({'hello': 'world'})


@api.route('/register')
class RegisterService(Resource):
    @api.doc('Registro')
    @api.expect(registerUserModel)
    def post(self):
        print(api.payload)
        return jsonify({'hello': 'world'})
