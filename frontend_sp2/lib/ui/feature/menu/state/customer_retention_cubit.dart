import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_sp2/domain/customer_retention_use_case.dart';
import 'package:frontend_sp2/domain/model/customer_retention/customer_retention_item.dart';
import 'package:frontend_sp2/domain/model/customer_retention/customer_retention_report_model.dart';
import 'package:frontend_sp2/domain/model/customer_retention/customer_retention_report_model_elements.dart';
import 'package:frontend_sp2/domain/model/year_filter_model.dart';
import 'package:logger/logger.dart';

part 'customer_retention_cubit.freezed.dart';

class CustomerRetentionCubit
    extends Cubit<CustomerRetentionScreenState> {
  final CustomerRetentionUseCase _customerRetentionUseCase;
  final List<CustomerRetentionItem> allElements = [];
  final Logger _logger;

  CustomerRetentionCubit(this._customerRetentionUseCase, this._logger)
      : super(Loading());

  void getCustomerRetention() async {
    var result = await _customerRetentionUseCase();

    result.match((error) {}, (requestResult) {
      emit(Current(model: requestResult));
      allElements.addAll(requestResult.reportList);
    });
  }

  void updateList(YearFilterModel model, bool selected) {
    var current = state as Current;
    var items = current.model.yearFilters;
    var currentSelected = items.indexWhere((element) => element.selected == true);
    var index = items.indexWhere((element) => element.year == model.year);
    if (index != currentSelected) {
      var yearsToDisplay = allElements.filter((t) => t.year.toString() == model.year).toList();
      var newItems = items.map((e) => YearFilterModel(year: e.year, selected: false)).toList();
      newItems[index].selected = selected;
      emit(current.copyWith(
          model: current.model.copyWith(yearFilters: newItems, reportList: yearsToDisplay)));
    }
    if (index == 0 && index != currentSelected) {
      var newItems = items.map((e) => YearFilterModel(year: e.year, selected: false)).toList();
      newItems[index].selected = selected;
      var all = allElements;
      emit(current.copyWith(model: current.model.copyWith(yearFilters: newItems, reportList: all)));
    }
  }

}

@freezed
class CustomerRetentionScreenState with _$CustomerRetentionScreenState {
  factory CustomerRetentionScreenState.current(
      {required CustomerRetentionReportModel model}) = Current;

  factory CustomerRetentionScreenState.loading() = Loading;

}
