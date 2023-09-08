from sqlalchemy import exc
import bcrypt
from domain.check_if_user_exists_use_case import check_if_user_exists_use_case

from domain.dto.base_response_dto import BaseResponseDTO
from domain.get_response_code_use_case import get_response_code_data
from domain.response_codes import ResponseCodes
from .dto.register_dto import RegisterDTO
from data.models.db_models import PlatformUser, EmitterDTE, db


def createUserUseCase(registerDTO: RegisterDTO):

    try:
        # validate company not exists
        companyExists = check_if_company_exists(registerDTO=registerDTO)
        userExists = check_if_user_exists_use_case(email=registerDTO.userEmail)
        if companyExists == False:
            if userExists == False:
                newUser = PlatformUser()
                newUser.userEmail = registerDTO.userEmail
                newUser.userPassword = bcrypt.hashpw(
                    registerDTO.password.encode('utf-8'), bcrypt.gensalt())
                newUser.userLastName = registerDTO.lastName
                newUser.userName = registerDTO.name
                newEmitter = EmitterDTE()
                newEmitter.nit = registerDTO.nitEmpresa
                newEmitter.nameEmitter = registerDTO.nameEmpresa
                newEmitter.platformUsers.append(newUser)
                db.session.add(newUser)
                db.session.add(newEmitter)
                db.session.commit()
                return BaseResponseDTO(data=get_response_code_data(ResponseCodes.user_created), success=True)
            else:
                return BaseResponseDTO(data=get_response_code_data(ResponseCodes.user_already_exists), success=False)
        else:
            return BaseResponseDTO(data=get_response_code_data(ResponseCodes.emitter_dte_already_exists), success=False)

    except exc.SQLAlchemyError as e:
        db.session.rollback()
        print(e)
        return BaseResponseDTO(data=get_response_code_data(ResponseCodes.user_not_created), success=False)


def check_if_company_exists(registerDTO: RegisterDTO):
    try:
        company: EmitterDTE = EmitterDTE.query.filter_by(
            nit=registerDTO.nitEmpresa).first()
        return company is not None
    except exc.SQLAlchemyError as e:
        print(e)
