import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/data/model/current_company_request.dart';
import 'package:frontend_sp2/data/response/monthly_sales_per_year.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:frontend_sp2/data/response/sales_performance_report_response.dart';
import 'package:frontend_sp2/domain/get_current_company_use_case.dart';
import 'package:frontend_sp2/domain/model/sales_performance_elements_model.dart';
import 'package:frontend_sp2/domain/model/sales_performance_report_model.dart';
import 'package:frontend_sp2/domain/model/year_filter_model.dart';

import '../data/sales_performance_caller.dart';

class SalesPerformanceUseCase {
  final SalesPerformanceCaller _salesPerformanceCaller;
  final GetCurrentCompanyUseCase _getCurrentCompanyUseCase;

  SalesPerformanceUseCase(this._salesPerformanceCaller, this._getCurrentCompanyUseCase);

  Future<Either<ResponseCode, SalesPerformanceReportModel>> call() async {
    var company = await _getCurrentCompanyUseCase();
    var currentCompanyRequest = CurrentCompanyRequest(currentCompany: company);

    var callResult = await _salesPerformanceCaller.getSalesPerformance(
      currentCompanyRequest
    );
    Either<ResponseCode, SalesPerformanceReportModel> response =
        callResult.match((l) {
      return Either.left(l);
    }, (data) {
      List<YearFilterModel> yearFilters = [];
      YearFilterModel yearFilterModel =
          YearFilterModel(year: "Todos", selected: true);
      yearFilters.add(yearFilterModel);
      yearFilters.addAll(data.yearFilters.map(
          (e) => YearFilterModel(year: e.year.toString(), selected: false)));

      List<SalesPerformanceElementsModel> elements =
          data.salesPerformanceElements.map((e) {
        List<MonthlySalesPerYear> monthlySales =
            data.monthlySalesPerYear[e.year.toString()]!;

        double total = 0.0;
        for (var element in monthlySales) {
          total += double.parse(element.amount);
        }
        double avg = total / monthlySales.length;
        double totalCurrentMonth = double.parse(monthlySales.last.amount);

        List<int> months = monthlySales.map((e) {
          return e.month;
        }).toList();

        List<double> amounts = monthlySales.map((e) {
          return double.parse(e.amount);
        }).toList();

        List<int> quantities = monthlySales.map((e) {
          return e.quantity;
        }).toList();

        var it = SalesPerformanceElementsModel(
            amount: e.amount,
            yearlyQuantity: e.quantity,
            year: e.year,
            yearAvg: avg,
            totalFinalMonth: totalCurrentMonth,
            amounts: amounts,
            months: months,
            monthlyQuantity: quantities
        );
        return it;
      }).toList();

      return Either.right(SalesPerformanceReportModel(
          monthlySalesPerYear: {},
          yearFilters: yearFilters,
          salesPerformanceElements: elements));
    });
    return response;
  }
}
