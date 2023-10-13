
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_sp2/domain/sales_performance_use_case.dart';
import 'package:logger/logger.dart';

part 'sales_performance_cubit.freezed.dart';

class SalesPerformanceCubit extends Cubit<SalesPerformanceScreenState> {
  final SalesPerformanceUseCase _salesPerformanceUseCase;
  final Logger _logger;

  SalesPerformanceCubit(this._salesPerformanceUseCase, this._logger): super(_Initial());

  void resetView() {
    emit(_Initial());
  }

  Future void<> newQuery(int year) async {
    _logger.d("actualizar tablero");
    emit(
        _Loading()
    );

    final result = await _salesPerformanceUseCase.;

  }

}

@freezed
class SalesPerformanceScreenState with _$SalesPerformanceScreenState {
  factory SalesPerformanceScreenState.initial() = _Initial;

  factory SalesPerformanceScreenState.loading() = _Loading;

  factory SalesPerformanceScreenState.error() = _Error;

  factory SalesPerformanceScreenState.success() = _Success;
}

