import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/core/network_call_methods.dart';
import 'package:frontend_sp2/data/base_api_caller.dart';
import 'package:frontend_sp2/data/model/register_user_request.dart';
import 'package:frontend_sp2/data/response/base_response.dart';
import 'package:frontend_sp2/data/response/response_code.dart';

class RegisterUserUseCase {
  final BaseApiCaller _baseApiCaller;

  RegisterUserUseCase(this._baseApiCaller);

  Future<Either<ResponseCode, BaseResponse>> call(RegisterUserRequest request) {
    return _baseApiCaller.makePost(NetworkCallMethods.registerUser, request);

  }
}