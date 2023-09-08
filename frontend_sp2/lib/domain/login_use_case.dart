
import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/core/network_call_methods.dart';
import 'package:frontend_sp2/data/base_api_caller.dart';
import 'package:frontend_sp2/data/model/login_request.dart';
import 'package:frontend_sp2/data/response/base_response.dart';
import 'package:frontend_sp2/data/user_api_caller.dart';

class LoginUseCase {
  final BaseApiCaller _baseApiCaller;

  LoginUseCase(this._baseApiCaller);

  Future<Either<Exception, BaseResponse>> call(String email, String password) {
    var request = LoginRequest(email: email, password: password);
    return _baseApiCaller.makePost(NetworkCallMethods.login, request);
  }

}