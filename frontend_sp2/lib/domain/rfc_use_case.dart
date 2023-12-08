import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/core/formatting.dart';
import 'package:frontend_sp2/data/rfc_caller.dart';
import 'package:frontend_sp2/data/model/current_company_request.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:frontend_sp2/data/response/year_filters_response.dart';
import 'package:frontend_sp2/data/response/year_filters_response_parent.dart';
import 'package:frontend_sp2/data/year_filter_api_caller.dart';
import 'package:frontend_sp2/domain/get_current_company_use_case.dart';

import 'package:frontend_sp2/domain/model/rfc/rfc_item.dart';
import 'package:frontend_sp2/domain/model/rfc/rfc_report_model.dart';
import 'package:frontend_sp2/domain/model/rfc/rfc_report_model_elements.dart';

import 'package:frontend_sp2/domain/model/year_filter_model.dart';
import 'package:logger/logger.dart';

class RFCUseCase {
  final Logger _logger;
  final RFCCaller _rfcCaller;
  final GetCurrentCompanyUseCase _getCurrentCompanyUseCase;

  RFCUseCase(
      this._logger,
      this._rfcCaller,
      this._getCurrentCompanyUseCase,
      );

  Future<Either<ResponseCode, RFCReportModel>> call() async {
    var company = await _getCurrentCompanyUseCase();
    var currentCompanyRequest = CurrentCompanyRequest(currentCompany: company);
    var callResult = await _rfcCaller.getRFC(currentCompanyRequest);

    Either<ResponseCode, RFCReportModel> response =
      callResult.match((error) {
        return Either.left(error);
      }, (result) {

        List<RFCItem> premiumElements = [];
        List<RFCItem> potentialElements = [];
        List<RFCItem> sporadicElements = [];

        for (var key in result.keys) {
          var items = result[key]!;
          List<int> idClients = items.map((e) => e.idClient).toList();
          List<String> names = items.map((e) => e.name).toList();
          List<double> amounts = items.map((e) => e.amount).toList();
          List<double> rfmScores = items.map((e) => e.rfmScore).toList();
          List<double> recencies = items.map((e) => e.recency).toList();
          List<double> frequencies = items.map((e) => e.frequency).toList();
          List<double> monetaries = items.map((e) => e.monetary).toList();
          List<int> clusterIds = items.map((e) => e.clusterId).toList();
          List<String> clusterNames = items.map((e) => e.clusterName).toList();

          List<RFCReportModelElements> elements = [];
          for (var item in items) {
            elements.add(
              RFCReportModelElements(
                idClient: item.idClient,
                name: item.name,
                amount: item.amount,
                rfmScore: item.rfmScore,
                recency: item.recency,
                frequency: item.frequency,
                monetary: item.monetary,
                clusterId: item.clusterId,
                clusterName: item.clusterName,
              ),
            );
          }

          switch (key) {
            case 'premium':
              premiumElements.addAll(elements);
              break;
            case 'potential':
              potentialElements.addAll(elements);
              break;
            case 'sporadic':
              sporadicElements.addAll(elements);
              break;
          }
        }

        return Either.right(
          RFCReportModel(
            premium: premiumElements,
            potential: potentialElements,
            sporadic: sporadicElements,
          ),
        );
      },
    );
    return response;
  }
}
