import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/core/formatting.dart';
import 'package:frontend_sp2/data/customer_lifetime_value_caller.dart';
import 'package:frontend_sp2/data/model/current_company_request.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:frontend_sp2/data/response/year_filters_response.dart';
import 'package:frontend_sp2/data/response/year_filters_response_parent.dart';
import 'package:frontend_sp2/data/year_filter_api_caller.dart';
import 'package:frontend_sp2/domain/get_companies_use_case.dart';
import 'package:frontend_sp2/domain/get_current_company_use_case.dart';
import 'package:frontend_sp2/domain/model/customer_lifetime_value/customer_lifetime_value_item.dart';
import 'package:frontend_sp2/domain/model/customer_lifetime_value/customer_lifetime_value_report_model.dart';
import 'package:frontend_sp2/domain/model/customer_lifetime_value/customer_lifetime_value_report_model_elements.dart';
import 'package:frontend_sp2/domain/model/customer_lifetime_value/summary_card_model.dart';
import 'package:frontend_sp2/domain/model/year_filter_model.dart';
import 'package:logger/logger.dart';

class CustomerLifetimeValueUseCase {
  final Logger _logger;
  final CustomerLifetimeValueCaller _customerLifetimeValueCaller;
  final YearFilterApiCaller _yearFilterApiCaller;
  final GetCurrentCompanyUseCase _getCurrentCompanyUseCase;
  CustomerLifetimeValueUseCase(this._logger, this._customerLifetimeValueCaller,
      this._yearFilterApiCaller, this._getCurrentCompanyUseCase);

  Future<Either<ResponseCode, CustomerLifetimeValueReportModel>> call() async {
    var company = await _getCurrentCompanyUseCase();
    var currentCompanyRequest = CurrentCompanyRequest(currentCompany: company);
    var callResult = await _customerLifetimeValueCaller.getCustomerValue(
        currentCompanyRequest
    );
    var yearFilterResult = await _yearFilterApiCaller.getYearFilters(currentCompanyRequest);
    Either<ResponseCode, CustomerLifetimeValueReportModel> response =
        callResult.match((error) {
      return Either.left(error);
    }, (result) {
      Option<YearFiltersResponseParent> filters = yearFilterResult.getRight();
      List<YearFilterModel> yearFilters = [
        YearFilterModel(year: "Todos", selected: true)
      ];

      List<CustomerLifetimeValueItem> plotElements = [];
      filters.match(() => _logger.d("None"), (t) {
        for (var element in t.filters) {
          yearFilters.add(
              YearFilterModel(year: element.year.toString(), selected: false));
        }
      });
      for (var key in result.customerValuePerYear.keys) {
        var items = result.customerValuePerYear[key]!;
        List<int> months = items.map((e) => e.monthT).toList();
        List<double> customerValues =
            items.map((e) => double.parse(e.customerValue)).toList();
        List<double> purchaseValues = items.map((e) => double.parse(e.purchaseValue)).toList();
        List<CustomerLifetimeValueReportModelElements> elements = [];
        for (var item in items) {
          elements.add(CustomerLifetimeValueReportModelElements(
              amount: item.amount,
              clientCount: item.clientCount,
              purchaseRate: item.purchaseRate,
              purchaseValue: item.purchaseValue,
              quantity: item.quantity,
              yearT: item.yearT));
        }
        var model = CustomerLifetimeValueItem(
            customerValues: customerValues, months: months, elements: elements, purchaseValues: purchaseValues, year: int.parse(key)
        );
        plotElements.add(model);
      }

      List<SummaryCardModel> summaryModels = [
        SummaryCardModel(
            title: "Promedio mes activo", information: result.avgMonthActive),
        SummaryCardModel(
            title: "Total clientes",
            information: result.totalClients.toString()),
        SummaryCardModel(
            title: "Promedio compra",
            information: CurrencyFormat.usCurrency(
                value: num.parse(result.avgPurchase))),
        SummaryCardModel(
            title: "Transacciones promedio mensuales",
            information: result.avgFrequencyMonth),
      ];
      return Either.right(CustomerLifetimeValueReportModel(
          generalSummary: summaryModels,
          yearFilters: yearFilters,
          reportList: plotElements.reversed.toList()));
    });
    return response;
  }
}
