from sqlalchemy import exc
import bcrypt

from domain.dto.base_response_dto import BaseResponseDTO
from domain.response_codes import ResponseCodes
from .dto.register_dto import RegisterDTO
from data.models.db_models import PlatformUser, EmitterDTE, db

def createUserUseCase(registerDTO: RegisterDTO):

    try:
        newUser = PlatformUser()
        newUser.userEmail = registerDTO.userEmail
        newUser.userPassword = bcrypt.hashpw(registerDTO.password.encode('utf-8'), bcrypt.gensalt())
        newUser.userLastName = registerDTO.lastName
        newUser.userName = registerDTO.name
        newEmitter = EmitterDTE()
        newEmitter.nit = registerDTO.nitEmpresa
        newEmitter.nameEmitter = registerDTO.nameEmpresa
        newEmitter.platformUsers.append(newUser)
        db.session.add(newUser)
        db.session.add(newEmitter)
        db.session.commit()

        return BaseResponseDTO(data={'code': ResponseCodes.user_created}, success=True)

    except exc.SQLAlchemyError as e:
        db.session.rollback()
        print(e)
        return BaseResponseDTO(data={'code': ResponseCodes.user_not_created}, success=False)
        #db.session.rollback()


