from domain.dto.base_response_dto import BaseResponseDTO
from domain.response_codes import ResponseCodes
from .dto.company_dto import CompanyDTO
from data.models.db_models import PlatformUser, db
from .check_if_user_exists_use_case import check_if_user_exists_use_case
from .get_response_code_use_case import get_response_code_data
from .response_codes import ResponseCodes
from flask import jsonify


def get_companies_use_case(userEmail: str):
    user: PlatformUser = PlatformUser.query.filter_by(
        userEmail=userEmail
    ).first()
    companies = []
    for emitter in user.emittersDTE:
        companyDTO = CompanyDTO(emitter.idEmitterDte,
                                emitter.nit, emitter.nameEmitter)
        companies.append(CompanyDTO.Schema().dump(companyDTO))

    return BaseResponseDTO(success=True, data={'companies': companies})
