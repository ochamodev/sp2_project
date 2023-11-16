import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/core/network_call_methods.dart';
import 'package:frontend_sp2/data/response/customer_retention_response.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:frontend_sp2/domain/model/sales_performance_report_model.dart';
import 'package:logger/logger.dart';

import 'response/base_response.dart';

class CustomerRetentionCaller {
  final Dio dio;
  final Logger logger;

  CustomerRetentionCaller({
    required this.dio,
    required this.logger
  });

  Future<Either<ResponseCode, CustomerRetentionResponse>> getCustomerRetention() async {
    try {
      var url = NetworkCallMethods.customerRetention;
      var result = await dio.post(url);
      logger.d("url: $url");
      logger.d("response: ${result.data}");
      final response = BaseResponse.fromJson(result.data);
      if (response.success) {
        logger.d("json: ${response.data}");
        logger.d("json: ${response.data.runtimeType}");
        return Either.right(CustomerRetentionResponse.fromJson(response.data));
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