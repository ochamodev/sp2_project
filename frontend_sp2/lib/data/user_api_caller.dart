
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/data/model/login_request.dart';
import 'package:frontend_sp2/data/response/login_response.dart';
import 'package:logger/logger.dart';

class UserApiCaller {
  final Dio dio;
  final Logger logger;

  UserApiCaller({
    required this.dio,
    required this.logger
  });

  Either<Exception, LoginResponse> doLogin(LoginRequest request) {
    try {
      //var result = dio.post(NetworkCallMethods.login, data: request.toJson())
      return Either.right(LoginResponse(token: ''));
    } catch (e) {
      logger.e(e);
      return Either.left(e as Exception);
    }
  }

}
