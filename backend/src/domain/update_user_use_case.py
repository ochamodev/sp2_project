

from domain.dto.update_user_dto import UpdateUserDTO
from domain.dto.base_response_dto import BaseResponseDTO
from domain.response_codes import ResponseCodes
from data.models.db_models import PlatformUser, db
from .check_if_user_exists_use_case import check_if_user_exists_use_case
from .get_response_code_use_case import get_response_code_data
from .response_codes import ResponseCodes


def update_user_use_case(updateUserDTO: UpdateUserDTO):
    try:
        userExists = check_if_user_exists_use_case(updateUserDTO.userEmail)
        if userExists:
            user: PlatformUser = PlatformUser.query.filter_by(
                userEmail=updateUserDTO.userEmail
            ).first()
            user.userName = updateUserDTO.userName
            user.userLastName = updateUserDTO.userLastName
            db.session.add(user)
            db.session.commit()
            return BaseResponseDTO(
                success=True,
                data={'message': 'Usuario actualizado exitosamente'}
            )
    except Exception as e:
        return BaseResponseDTO(
            success=False,
            data=get_response_code_data(
                ResponseCodes.general_error
            )
        )
