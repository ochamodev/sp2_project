

import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/data/response/sales_performance_elements.dart';

import '../data/sales_performance_caller.dart';

class SalesPerformanceUseCase{

  final SalesPerformanceCaller _salesPerformanceCaller;

  SalesPerformanceUseCase(this._salesPerformanceCaller);

  Future<Either<Exception,SalesPerformanceElements>> call(
      {dynamic json}) async {
    return _salesPerformanceCaller.annualSales(json: json);
  }

}