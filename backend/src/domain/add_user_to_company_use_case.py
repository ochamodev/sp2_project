
import bcrypt
from domain.check_if_user_exists_use_case import check_if_user_exists_use_case
from domain.dto.add_user_to_company_dto import AddUserToCompanyDTO
from domain.dto.base_response_dto import BaseResponseDTO
from domain.get_response_code_use_case import get_response_code_data
from domain.response_codes import ResponseCodes
from sqlalchemy import exc, text
from data.models.db_models import PlatformUser, EmitterDTE, db, emitterPlatformUser


def add_user_to_company_use_case(addUserToCompanyDTO: AddUserToCompanyDTO):
    connection = db.engine.raw_connection()
    try:
        userExists = check_if_user_exists_use_case(
            addUserToCompanyDTO.userEmail)
        emitterDte: EmitterDTE = EmitterDTE.query.get(
            addUserToCompanyDTO.companyId)
        if userExists:
            userAlreadyAssigned = check_user_assigned_to_company(
                addUserToCompanyDTO.userEmail)
            if userAlreadyAssigned:
                return BaseResponseDTO(success=False, data=get_response_code_data(ResponseCodes.user_already_exists))
            else:
                user = PlatformUser.query.filter_by(
                    userEmail=addUserToCompanyDTO.userEmail).first()
                emitterDte.platformUsers.append(user)
                db.session.commit()
        else:
            if addUserToCompanyDTO.searchByUser:
                return BaseResponseDTO(data=get_response_code_data(ResponseCodes.user_not_exists), success=False)
            else:
                cursor = connection.cursor()
                db.session.execute(
                    text('CALL AddUserToCompany({emId}, "{un}", "{ln}", "{uem}", "{up}")'.format(emId=addUserToCompanyDTO.companyId,
                                                                                                 un=addUserToCompanyDTO.userName,
                                                                                                 ln=addUserToCompanyDTO.userLastName,
                                                                                                 uem=addUserToCompanyDTO.userEmail,
                                                                                                 up=bcrypt.hashpw(
                                                                                                     addUserToCompanyDTO.userPassword.encode(
                                                                                                         'utf-8'), bcrypt.gensalt()
                                                                                                 )
                                                                                                 )))
                return BaseResponseDTO(success=True, data=get_response_code_data(ResponseCodes.user_created))
    except exc.SQLAlchemyError as e:
        db.session.rollback()
        print(e)
        return BaseResponseDTO(data=get_response_code_data(ResponseCodes.user_not_created), success=False)
    finally:
        connection.close()


def check_user_assigned_to_company(userEmail: str):
    userAssigned = EmitterDTE.query.join(emitterPlatformUser).join(
        PlatformUser).filter(PlatformUser.userEmail == userEmail).first()
    if userAssigned is None:
        return False
    else:
        return True
