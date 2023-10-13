
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/data/response/base_response.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:logger/logger.dart';

import 'base_model.dart';

class BaseApiCaller {
  final Dio dio;
  final Logger logger;

  BaseApiCaller({
    required this.dio,
    required this.logger
  });

  Future<Either<ResponseCode, BaseResponse>> makePost(String url, BaseModel? request ) async {
    try {
      var result = await dio.post(url, data: request?.toJson());
      logger.d("url: $url");
      logger.d("response: ${result.data}");
      final response = BaseResponse.fromJson(result.data);
      if (response.success) {
        return Either.right(response);
      } else {
        return Either.left(ResponseCode.fromJson(response.data));
      }
    } catch (e) {
      logger.e(e);
      return Either.left(
          ResponseCode(
              respCode: 'App',
              respDescription: "Ha ocurrido un error"
          )
      );
    }
  }

}