
import bcrypt
from domain.dto.base_response_dto import BaseResponseDTO
from domain.response_codes import ResponseCodes
from .dto.change_password_dto import ChangePasswordDTO
from data.models.db_models import PlatformUser, db
from .check_if_user_exists_use_case import check_if_user_exists_use_case
from .get_response_code_use_case import get_response_code_data
from .response_codes import ResponseCodes


def change_password_use_case(change_password_dto: ChangePasswordDTO):
    try:
        userEmail = change_password_dto.userEmail
        userExists = check_if_user_exists_use_case(userEmail)
        if userExists:
            # check old password matches.
            user: PlatformUser = PlatformUser.query.filter_by(
                userEmail=userEmail).first()
            bOldPassword = change_password_dto.oldPassword.encode('utf-8')
            userPassword = user.userPassword.encode('utf-8')
            passwordMatches = bcrypt.checkpw(
                bOldPassword, userPassword)
            if passwordMatches:
                # Change password
                user.userPassword = bcrypt.hashpw(
                    change_password_dto.newPassword.encode('utf-8'), bcrypt.gensalt())
                db.session.add(user)
                db.session.commit()
                return BaseResponseDTO(
                    success=True,
                    data={'message': 'Cambio de contraseña exitoso.'}
                )
            else:
                return BaseResponseDTO(
                    success=False,
                    data=get_response_code_data(
                        ResponseCodes.password_change_failed
                    )
                )
        else:
            return BaseResponseDTO(
                success=False,
                data=get_response_code_data(
                    ResponseCodes.password_change_failed
                )
            )
    except Exception as e:
        return BaseResponseDTO(
            success=False,
            data=get_response_code_data(
                ResponseCodes.password_change_failed
            )
        )
