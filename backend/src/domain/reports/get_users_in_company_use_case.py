from data.models.db_models import db
from domain.dto.base_response_dto import BaseResponseDTO
from domain.dto.user_dto import UserDTO


def get_users_in_company(companyCode: int):
    connection = db.engine.raw_connection()
    try:
        cursor = connection.cursor()
        cursor.execute(
            "CALL GetUsersInCompany({em})".format(em=companyCode)
        )
        companyUsers = list(cursor.fetchall())
        cursor.close()
        companyUsersModel = []
        for companyUser in companyUsers:
            idUser = companyUser[0]
            userName = companyUser[1]
            userLastName = companyUser[2]
            userEmail = companyUser[3]
            userDto = UserDTO(id=idUser, userName=userName,
                              userLastName=userLastName, userEmail=userEmail)
            companyUsersModel.append(userDto)

        return BaseResponseDTO(success=True, data={'users': companyUsersModel})
    finally:
        connection.close()
