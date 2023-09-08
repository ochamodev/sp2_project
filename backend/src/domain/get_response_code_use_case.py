
from data.models.db_models import ResponseCodes
from domain.dto.response_code_dto import ResponseCodeDTO


def get_response_code_use_case(code: str):
    responseCode: ResponseCodes = ResponseCodes.query.filter_by(
        respCode=code).first()

    if responseCode is None:
        return ResponseCodeDTO(
            respCode="EX", respDescription="An error has ocurred"
        )
    else:
        responseDto: ResponseCodeDTO = ResponseCodeDTO(
            respCode=responseCode.respCode, respDescription=responseCode.respDescription)
        return responseDto


def get_response_code_data(code: str):
    responseCode: ResponseCodeDTO = get_response_code_use_case(code)
    return ResponseCodeDTO.Schema().dump(responseCode)
