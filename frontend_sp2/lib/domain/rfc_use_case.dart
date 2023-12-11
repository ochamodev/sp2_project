import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/core/formatting.dart';
import 'package:frontend_sp2/data/rfc_caller.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:frontend_sp2/data/response/year_filters_response.dart';
import 'package:frontend_sp2/data/response/year_filters_response_parent.dart';
import 'package:frontend_sp2/data/year_filter_api_caller.dart';
import 'package:frontend_sp2/domain/model/rfc/rfc_item.dart';
import 'package:frontend_sp2/domain/model/rfc/rfc_report_model.dart';
import 'package:frontend_sp2/domain/model/rfc/rfc_report_model_elements.dart';
import 'package:frontend_sp2/domain/model/rfc/rfc_summary_card_model.dart';
import 'package:frontend_sp2/domain/model/year_filter_model.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:frontend_sp2/data/model/current_company_request.dart';
import 'package:frontend_sp2/domain/get_companies_use_case.dart';
import 'package:frontend_sp2/domain/get_current_company_use_case.dart';

class RFCUseCase {
  final Logger _logger;
  final RFCCaller _rfcCaller;
  final YearFilterApiCaller _yearFilterApiCaller;
  final GetCurrentCompanyUseCase _getCurrentCompanyUseCase;
  RFCUseCase(this._logger, this._rfcCaller,
      this._yearFilterApiCaller, this._getCurrentCompanyUseCase);

  Future<Either<ResponseCode, RFCReportModel>> call() async {
    var company = await _getCurrentCompanyUseCase();
    var currentCompanyRequest = CurrentCompanyRequest(currentCompany: company);
    var callResult = await _rfcCaller.getRFC(
        currentCompanyRequest
    );
    // var yearFilterResult = await _yearFilterApiCaller.getYearFilters();
    Either<ResponseCode, RFCReportModel> response =
    callResult.match((error) {
      return Either.left(error);
    }, (result) {

      List<RFCItem> plotElements = [];
      Set<String> uniqueClusterSet = <String>{};

      for (var key in result.customerClusters.keys) {
        var items = result.customerClusters[key]!;
        List<String> clusterNames = items.map((e) => e.clusterName).toList();
        uniqueClusterSet.addAll(clusterNames);
        List<String> uniqueClusterNames = uniqueClusterSet.toList();
        List<double> recencyValues = items.map((e) => e.recency).toList();
        List<double> frequencyValues = items.map((e) => e.frequency).toList();
        List<double> monetaryValues = items.map((e) => e.monetary).toList();
        List<double> rfmScoreValues = items.map((e) => e.rfmScore).toList();

        List<RFCReportModelElements> elements = [];
        for (var item in items) {
          elements.add(RFCReportModelElements(
              idReceptor: item.idReceptor,
              name: item.name,
              rfmScore: item.rfmScore,
              recency: item.recency,
              frequency: item.frequency,
              monetary: item.monetary,
              cluster: item.cluster,
              clusterName: item.clusterName));
        }
        var model = RFCItem(
            recencyValues: recencyValues, frequencyValues: frequencyValues, monetaryValues: monetaryValues,
            rfmScoreValues: rfmScoreValues, clusterNames: clusterNames, uniqueClusterNames: uniqueClusterNames,
            elements: elements
        );
        plotElements.add(model);
      }

      List<SummaryCardModel> summaryModels = [
        SummaryCardModel(
            title: "Promedio Frecuencia de compra", information: result.avgFrequency.toStringAsFixed(1)
        ),
        SummaryCardModel(
            title: "Promedio Monto de compra", information: CurrencyFormat.usCurrency(value: result.avgMonetary)
        ),
        SummaryCardModel(
            title: "Promedio días desde última compra", information: result.avgRecency.toStringAsFixed(1)
        ),
      ];
      return Either.right(RFCReportModel(
          generalSummary: summaryModels,
          reportList: plotElements.reversed.toList()));
    });
    return response;
  }
}


class CurrencyFormat {
  static final _usCurrencyFormatter = NumberFormat("#,##0.00", "en_US");
  static final _decFormatter = NumberFormat("#,##0.00", "en_US");

  static String usCurrency({required num value}) =>
      "Q. ${_usCurrencyFormatter.format(value)}";

  static String decFormat({required num value}) =>
      _decFormatter.format(value);
}
