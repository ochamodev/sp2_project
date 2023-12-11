import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/data/rfc_caller.dart';
import 'package:frontend_sp2/data/model/current_company_request.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:frontend_sp2/domain/get_current_company_use_case.dart';

import 'package:frontend_sp2/domain/model/rfc/rfc_report_model.dart';

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

  Future<Either<ResponseCode, RFCReportModel>?> call() async {
    var company = await _getCurrentCompanyUseCase();
    var currentCompanyRequest = CurrentCompanyRequest(currentCompany: company);
    var callResult = await _rfcCaller.getRFC(currentCompanyRequest);

    return null;
  }
}
