from flask import jsonify
from flask_restx import Namespace, Resource, fields
from flask_jwt_extended import jwt_required, create_access_token
from domain.dto.base_response_dto import BaseResponseDTO
from domain.dto.register_dto import RegisterDTO
from domain.dto.login_dto import LoginDTO
from domain.create_user_use_case import createUserUseCase
from domain.check_if_user_exists_use_case import validate_login_use_case


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
        logindto: LoginDTO = LoginDTO.Schema().load(api.payload)
        result = validate_login_use_case(logindto=logindto)
        if (result):
            access_token = create_access_token(identity=logindto.email)
            response = BaseResponseDTO(data={'access_token': access_token}, success=True)
            return BaseResponseDTO.Schema().dump(response)
        else:
            return jsonify({'exists': result})


@api.route('/register')
class RegisterService(Resource):
    @api.doc('Register user')
    @api.expect(registerUserModel)
    def post(self):
        print(api.payload)
        registerData = RegisterDTO.Schema().load(api.payload)
        createUserUseCase(registerDTO=registerData)
        return jsonify(RegisterDTO.Schema().dump(registerData))

@api.route('/protected')
class ProtectedResource(Resource):
    @jwt_required()
    def get(self):
        return {'message': 'I am a protected resource'}