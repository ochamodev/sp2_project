
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/core/network_call_methods.dart';
import 'package:frontend_sp2/data/model/login_request.dart';
import 'package:frontend_sp2/data/model/register_user_request.dart';
import 'package:frontend_sp2/data/response/base_response.dart';
import 'package:logger/logger.dart';

class UserApiCaller {
  final Dio dio;
  final Logger logger;

  UserApiCaller({
    required this.dio,
    required this.logger
  });

  Future<Either<Exception, BaseResponse>> doLogin(LoginRequest request) async {
    try {
      var result = await dio.post(NetworkCallMethods.login, data: request.toJson());
      return Either.right(BaseResponse.fromJson(result.data));
    } catch (e) {
      logger.e(e);
      return Either.left(e as Exception);
    }
  }

  Future<Either<Exception, BaseResponse>> doRegisterUser(RegisterUserRequest request) async {
    try {
      var result = await dio.post(NetworkCallMethods.login, data: request.toJson());
      return Either.right(BaseResponse.fromJson(result.data));
    } catch (e) {
      logger.e(e);
      return Either.left(e as Exception);
    }
  }

}
