
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/core/network_call_methods.dart';
import 'package:frontend_sp2/data/base_model.dart';
import 'package:frontend_sp2/data/response/base_response.dart';
import 'package:frontend_sp2/data/response/rfc_response.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:logger/logger.dart';


class RFCCaller {
  final Dio dio;
  final Logger logger;

  RFCCaller({
    required this.dio,
    required this.logger,
  });

  Future<Either<ResponseCode, RFCResponse>> getRFC(BaseModel model) async {
    try {
      var url = NetworkCallMethods.rfmAnalysis;
      var result = await dio.post(url);
      logger.d("url: $url");
      logger.d("response: ${result.data}");
      final response = BaseResponse.fromJson(result.data);
      if (response.success) {
        logger.d("json: ${response.data}");
        logger.d("json: ${response.data.runtimeType}");
        return Either.right(RFCResponse.fromJson(response.data));
      } else {
        return Either.left(ResponseCode.fromJson(response.data));
      }
    } catch (e) {
      logger.e(e);
      return Either.left(
        ResponseCode(
          respCode: 'App',
          respDescription: "Ha ocurrido un error",
        ),
      );
    }
  }
}
