

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/core/network_call_methods.dart';
import 'package:frontend_sp2/data/response/get_companies_response_parent.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:logger/logger.dart';

import 'response/base_response.dart';

class GetCompaniesCaller {
  final Dio dio;
  final Logger logger;

  GetCompaniesCaller({
    required this.dio,
    required this.logger
});

  Future<Either<ResponseCode, GetCompaniesResponseParent>> getCompanies() async {
    try {
      var url = NetworkCallMethods.getCompanies;
      var result = await dio.post(url);
      logger.d("url: $url");
      logger.d("response: ${result.data}");
      final response = BaseResponse.fromJson(result.data);
      if (response.success) {
        logger.d("json: ${response.data}");
        logger.d("json: ${response.data.runtimeType}");
        return Either.right(GetCompaniesResponseParent.fromJson(response.data));
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