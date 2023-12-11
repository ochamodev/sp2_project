
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/core/network_call_methods.dart';
import 'package:frontend_sp2/data/base_model.dart';
import 'package:frontend_sp2/data/response/base_response.dart';
import 'package:logger/logger.dart';

import 'data/response/response_code.dart';

class UserOperationsCaller {
  final Dio dio;
  final Logger logger;

  UserOperationsCaller({
    required this.dio,
    required this.logger
});

  Future<Either<ResponseCode, BaseResponse>> makeRequest(String url, BaseModel request) async {
    try {
      var result = await dio.post(url, data: request.toJson());
      return Either.right(BaseResponse.fromJson(result.data));
    } catch(e) {
      logger.e(e);
      return Either.left(
        ResponseCode(respCode: "XX", respDescription: "Ha ocurrido un error")
      );
    }
  }

}