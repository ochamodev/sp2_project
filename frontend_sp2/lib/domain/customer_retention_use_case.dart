import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/core/formatting.dart';
import 'package:frontend_sp2/data/customer_retention_caller.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:frontend_sp2/data/response/year_filters_response.dart';
import 'package:frontend_sp2/data/response/year_filters_response_parent.dart';
import 'package:frontend_sp2/data/year_filter_api_caller.dart';
import 'package:frontend_sp2/domain/model/customer_retention/customer_retention_item.dart';
import 'package:frontend_sp2/domain/model/customer_retention/customer_retention_report_model.dart';
import 'package:frontend_sp2/domain/model/customer_retention/customer_retention_report_model_elements.dart';
import 'package:frontend_sp2/domain/model/year_filter_model.dart';
import 'package:logger/logger.dart';

class CustomerRetentionUseCase {
  final Logger _logger;
  final CustomerRetentionCaller _customerRetentionCaller;
  final YearFilterApiCaller _yearFilterApiCaller;
  CustomerRetentionUseCase(this._logger, this._customerRetentionCaller,
      this._yearFilterApiCaller);

  Future<Either<ResponseCode, CustomerRetentionReportModel>> call() async {
    var callResult = await _customerRetentionCaller.getCustomerRetention();
    var yearFilterResult = await _yearFilterApiCaller.getYearFilters();
    Either<ResponseCode, CustomerRetentionReportModel> response =
    callResult.match((error) {
      return Either.left(error);
    }, (result) {
      Option<YearFiltersResponseParent> filters = yearFilterResult.getRight();
      List<YearFilterModel> yearFilters = [
        YearFilterModel(year: "Todos", selected: true)
      ];

      List<CustomerRetentionItem> plotElements = [];
      filters.match(() => _logger.d("None"), (t) {
        for (var element in t.filters) {
          yearFilters.add(
              YearFilterModel(year: element.year.toString(), selected: false));
        }
      });
      for (var key in result.customerRetentionPerYear.keys) {
        var items = result.customerRetentionPerYear[key]!;
        List<int> months = items.map((e) => e.monthT).toList();

        List<int> newClients = items.map((e) => e.newClients).toList();
        List<double> newAmounts = items.map((e) => double.parse(e.newAmount)).toList();
        List<int> cancelledClients = items.map((e) => e.cancelledClients).toList();
        List<double> cancelledAmounts = items.map((e) => double.parse(e.cancelledAmount)).toList();
        List<int> retainedClients = items.map((e) => e.retainedClients).toList();
        List<double> retainedAmounts = items.map((e) => double.parse(e.retainedAmount)).toList();
        List<double> customerRetentions = items.map((e) => double.parse(e.customerRetention)).toList();

        List<CustomerRetentionReportModelElements> elements = [];
        for (var item in items) {
          elements.add(CustomerRetentionReportModelElements(
            yearT: item.yearT,
            newClients: item.newClients,
            newAmount: item.newAmount,
            cancelledClients: item.cancelledClients,
            cancelledAmount: item.cancelledAmount,
            retainedClients: item.retainedClients,
            retainedAmount: item.retainedAmount,
            customerRetention: item.customerRetention,
          ));
        }
        var model = CustomerRetentionItem(
            newClients: newClients, newAmounts: newAmounts,
            cancelledClients: cancelledClients, cancelledAmounts: cancelledAmounts,
            retainedClients: retainedClients, retainedAmounts: retainedAmounts,
            customerRetentions: customerRetentions,
            months: months, elements: elements, year: int.parse(key)
        );
        plotElements.add(model);
      }

      return Either.right(CustomerRetentionReportModel(
          yearFilters: yearFilters,
          reportList: plotElements.reversed.toList()));
    });
    return response;
  }
}
