import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_sp2/domain/rfc_use_case.dart';
import 'package:frontend_sp2/domain/model/rfc/rfc_item.dart';
import 'package:frontend_sp2/domain/model/rfc/rfc_report_model.dart';
import 'package:frontend_sp2/domain/model/rfc/rfc_report_model_elements.dart';
import 'package:frontend_sp2/domain/model/year_filter_model.dart';
import 'package:logger/logger.dart';

part 'rfc_cubit.freezed.dart';

class RFCCubit
    extends Cubit<RFCScreenState> {
  final RFCUseCase _rfcUseCase;
  final List<RFCItem> allElements = [];
  final Logger _logger;

  RFCCubit(this._rfcUseCase, this._logger)
      : super(Loading());

  void getRFC() async {
    var result = await _rfcUseCase();

    result.match((error) {}, (requestResult) {
      emit(Current(model: requestResult));
      allElements.addAll(requestResult.reportList);
    });
  }

}

@freezed
class RFCScreenState with _$RFCScreenState {
  factory RFCScreenState.current(
      {required RFCReportModel model}) = Current;

  factory RFCScreenState.loading() = Loading;

}
