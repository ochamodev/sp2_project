from flask import jsonify
from flask_restx import Namespace, Resource, fields
from flask_jwt_extended import jwt_required, create_access_token, get_jwt_identity
from domain.add_user_to_company_use_case import add_user_to_company_use_case
from domain.delete_user_from_company_use_case import delete_user_from_company_use_case
from domain.dto.add_user_to_company_dto import AddUserToCompanyDTO
from domain.dto.base_response_dto import BaseResponseDTO
from domain.dto.delete_user_from_company_dto import DeleteUserFromCompanyDTO
from domain.dto.register_dto import RegisterDTO
from domain.dto.login_dto import LoginDTO
from domain.dto.change_password_dto import ChangePasswordDTO
from domain.create_user_use_case import createUserUseCase
from domain.change_password_use_case import change_password_use_case
from domain.check_if_user_exists_use_case import validate_login_use_case
from domain.dto.update_user_dto import UpdateUserDTO
from domain.get_response_code_use_case import get_response_code_data
from domain.get_companies_use_case import get_companies_use_case
from domain.response_codes import ResponseCodes
from domain.update_user_use_case import update_user_use_case


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

changePasswordModel = api.model('ChangePasswordModel', {
    'oldPassword': fields.String(required=True),
    'newPassword': fields.String(required=True),
    'userEmail': fields.String(required=True)
})

updateUserModel = api.model('UpdateUserModel', {
    'userEmail': fields.String(required=True),
    'userName': fields.String(required=True),
    'userLastName': fields.String(required=True)
})

deleteUserFromCompany = api.model('DeleteUserFromCompanyModel', {
    'userId': fields.Integer(required=True),
    'companyId': fields.Integer(required=True)
})

addUserToCompanyModel = api.model('AddUserToCompanyModel', {
    'userEmail': fields.String(required=True),
    'userName': fields.String(required=True),
    'userPassword': fields.String(required=True),
    'userLastName': fields.String(required=True),
    'searchByUser': fields.Boolean(required=True),
    'companyId': fields.Integer(required=True),
})


@api.route('/login')
class UserService(Resource):
    @api.doc('Login')
    @api.expect(loginModel)
    def post(self):
        logindto: LoginDTO = LoginDTO.Schema().load(api.payload)
        result, emitter = validate_login_use_case(logindto=logindto)
        if (result):
            additional_claims = {'e': emitter}
            access_token = create_access_token(
                identity=logindto.email, additional_claims=additional_claims)
            response = BaseResponseDTO(
                data={'access_token': access_token}, success=True)
            return BaseResponseDTO.Schema().dump(response)
        else:
            return BaseResponseDTO.Schema().dump(
                BaseResponseDTO(
                    data=get_response_code_data(
                        ResponseCodes.user_login_failed),
                    success=False
                )
            )


@api.route('/register')
class RegisterService(Resource):
    @api.doc('Register user')
    @api.expect(registerUserModel)
    def post(self):
        print(api.payload)
        registerData = RegisterDTO.Schema().load(api.payload)
        response = createUserUseCase(registerDTO=registerData)
        return BaseResponseDTO.Schema().dump(response)


@api.route('/protected')
class ProtectedResource(Resource):
    @jwt_required()
    def get(self):
        return {'message': 'I am a protected resource'}


@api.route('/changePassword')
class ChangePasswordResource(Resource):
    @jwt_required()
    @api.expect(changePasswordModel)
    def post(self):
        changePasswordDTO = ChangePasswordDTO.Schema().load(api.payload)
        response = change_password_use_case(
            change_password_dto=changePasswordDTO)
        return BaseResponseDTO.Schema().dump(response)
# comparación de años


@api.route('/updateUser')
class UpdateUserResource(Resource):
    @jwt_required()
    @api.expect(updateUserModel)
    def post(self):
        print(api.payload)
        updateUserDTO = UpdateUserDTO.Schema().load(api.payload)
        response = update_user_use_case(
            updateUserDTO=updateUserDTO
        )
        return BaseResponseDTO.Schema().dump(response)


@api.route('/removeUserFromCompany')
class RemoveUserFromCompany(Resource):
    @jwt_required()
    @api.expect(deleteUserFromCompany)
    def post(self):
        deleteUserFromCompanyDTO = DeleteUserFromCompanyDTO.Schema().load(api.payload)
        response = delete_user_from_company_use_case(
            deleteUserFromCompanyDTO=deleteUserFromCompanyDTO
        )
        return BaseResponseDTO.Schema().dump(response)


@api.route('/addUserToCompany')
class AddUserToCompany(Resource):
    @jwt_required()
    @api.expect(addUserToCompanyModel)
    def post(self):
        addUserToCompanyDTO = AddUserToCompanyDTO.Schema().load(api.payload)
        response = add_user_to_company_use_case(
            addUserToCompanyDTO=addUserToCompanyDTO
        )
        return BaseResponseDTO.Schema().dump(response)


@api.route('/getCompanies')
class GetCompaniesResource(Resource):
    @jwt_required()
    def post(self):
        userEmail = get_jwt_identity()
        response = get_companies_use_case(userEmail)
        return BaseResponseDTO.Schema().dump(response)
