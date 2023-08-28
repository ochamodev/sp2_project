from sqlalchemy import exc
from .dto.register_dto import RegisterDTO
from data.models.db_models import PlatformUser, EmitterDTE, db

def createUser(registerDTO: RegisterDTO):

    try:
        newUser = PlatformUser()
        newUser.userEmail = registerDTO.userEmail
        newUser.userPassword = registerDTO.password
        newUser.userLastName = registerDTO.lastName
        newUser.userName = registerDTO.name
        newEmitter = EmitterDTE()
        newEmitter.nit = registerDTO.nitEmpresa
        newEmitter.nameEmitter = registerDTO.nameEmpresa
        newEmitter.platformUsers.append(newUser)
        db.session.add(newUser)
        db.session.add(newEmitter)
        db.session.commit()

    except exc.SQLAlchemyError as e:
        db.session.rollback()
        print(e)
        #db.session.rollback()


