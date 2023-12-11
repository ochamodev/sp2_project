

from domain.dto.base_response_dto import BaseResponseDTO
from domain.dto.delete_user_from_company_dto import DeleteUserFromCompanyDTO
from data.models.db_models import db


def delete_user_from_company_use_case(deleteUserFromCompanyDTO: DeleteUserFromCompanyDTO):
    try:
        db.session.execute('CALL DeleteUserFromCompany(:emitterId, :userId)', {
                           'emitterId': deleteUserFromCompanyDTO.companyId,
                           'userId': deleteUserFromCompanyDTO.userId
                           })
        db.session.commit()
        return BaseResponseDTO(
            success=True,
            data={'message': 'Usuario eliminado exitosamente'}
        )
    finally:
        print("No paso nada?")
