
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/core/network_call_methods.dart';
import 'package:frontend_sp2/data/base_model.dart';
import 'package:frontend_sp2/data/response/base_response.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:frontend_sp2/data/response/sales_performance_report_response.dart';
import 'package:frontend_sp2/data/response/year_filters_response.dart';
import 'package:frontend_sp2/data/response/year_filters_response_parent.dart';
import 'package:frontend_sp2/ui/shared/year_filter.dart';
import 'package:logger/logger.dart';

class YearFilterApiCaller {
  final Dio dio;
  final Logger logger;

  YearFilterApiCaller({
    required this.dio,
    required this.logger
  });

  Future<Either<ResponseCode, YearFiltersResponseParent>> getYearFilters(BaseModel model) async {
    try {
      var url = NetworkCallMethods.yearFilters;
      var result = await dio.post(url, data: model.toJson());
      logger.d("url: $url");
      logger.d("response: ${result.data}");
      final response = BaseResponse.fromJson(result.data);
      if (response.success) {
        logger.d("json: ${response.data}");
        logger.d("json: ${response.data.runtimeType}");
        return Either.right(YearFiltersResponseParent.fromJson(response.data));
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