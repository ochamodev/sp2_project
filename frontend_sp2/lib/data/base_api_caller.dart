
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/data/response/base_response.dart';
import 'package:logger/logger.dart';

import 'model/base_model.dart';

class BaseApiCaller {
  final Dio dio;
  final Logger logger;

  BaseApiCaller({
    required this.dio,
    required this.logger
  });

  Future<Either<Exception, BaseResponse>> makePost(String url, BaseModel request ) async {
    try {
      var result = await dio.post(url, data: request.toJson());
      logger.d("url: $url");
      logger.d("response: ${result.data}");
      return Either.right(BaseResponse.fromJson(result.data));
    } catch (e) {
      logger.e(e);
      return Either.left(e as Exception);
    }
  }

}