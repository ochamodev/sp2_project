import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_sp2/data/response/year_filters.dart';
import 'package:frontend_sp2/domain/model/sales_performance_elements_model.dart';
import 'package:frontend_sp2/domain/model/sales_performance_report_model.dart';
import 'package:frontend_sp2/domain/model/year_filter_model.dart';
import 'package:frontend_sp2/domain/sales_performance_use_case.dart';
import 'package:logger/logger.dart';

part 'sales_performance_cubit.freezed.dart';

class SalesPerformanceCubit extends Cubit<SalesPerformanceScreenState> {
  final SalesPerformanceUseCase _salesPerformanceUseCase;
  final List<SalesPerformanceElementsModel> allElements = [];
  final Logger _logger;

  SalesPerformanceCubit(this._salesPerformanceUseCase, this._logger)
      : super(Current());

  void resetView() {
    emit(Current());
  }

  void updateList(YearFilterModel model, bool selected) {
    var current = state as Current;
    var currentModel = current.salesPerformanceReportModel!;
    var items = current.salesPerformanceReportModel!.yearFilters;
    var currentSelected = items.indexWhere((element) => element.selected == true);
    var index = items.indexWhere((element) => element.year == model.year);
    if (index != currentSelected) {
      var yearsToDisplay = allElements.filter((t) => t.year.toString() == model.year).toList();
      var newItems = items.map((e) => YearFilterModel(year: e.year, selected: false)).toList();
      newItems[index].selected = selected;
      emit(current.copyWith(salesPerformanceReportModel: current.salesPerformanceReportModel!.copyWith(yearFilters: newItems, salesPerformanceElements: yearsToDisplay)));
    }
    if (index == 0 && index != currentSelected) {
      var newItems = items.map((e) => YearFilterModel(year: e.year, selected: false)).toList();
      newItems[index].selected = selected;
      emit(current.copyWith(salesPerformanceReportModel: current.salesPerformanceReportModel!.copyWith(yearFilters: newItems, salesPerformanceElements: allElements)));
    }
  }

  void getSalesPerformance() async {
    var result = await _salesPerformanceUseCase();

    result.match((l) {}, (r) {
      allElements.addAll(r.salesPerformanceElements);
      emit(Current(salesPerformanceReportModel: r));
    });
  }
}

@freezed
sealed class SalesPerformanceScreenState with _$SalesPerformanceScreenState {
  factory SalesPerformanceScreenState.current(
      {SalesPerformanceReportModel? salesPerformanceReportModel}) = Current;

  factory SalesPerformanceScreenState.loading() = Loading;
}
