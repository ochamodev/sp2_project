import bcrypt
from domain.dto.base_response_dto import BaseResponseDTO
from domain.response_codes import ResponseCodes
from .dto.login_dto import LoginDTO
from data.models.db_models import PlatformUser


def validate_login_use_case(logindto: LoginDTO):
    user: PlatformUser = PlatformUser.query.filter_by(
        userEmail=logindto.email).first()
    passwordMatches = bcrypt.checkpw(logindto.password.encode(
        'utf-8'), user.userPassword.encode('utf-8'))
    if user and passwordMatches:
        emitters = []
        for emitter in user.emittersDTE:
            print(emitter.idEmitterDte)
            emitters.append(emitter.idEmitterDte)
        return True, emitters
    return False, None


def check_if_user_exists_use_case(email: str):
    userExists = PlatformUser.query.filter_by(userEmail=email).first()
    if userExists is None:
        return False
    else:
        return True
