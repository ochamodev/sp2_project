from .dto.login_dto import LoginDTO
from data.models.db_models import PlatformUser

def checkIfUserExists(logindto: LoginDTO):
    userExists = PlatformUser.query.filter_by(userEmail = logindto.email, userPassword = logindto.password).first()
    return userExists is None