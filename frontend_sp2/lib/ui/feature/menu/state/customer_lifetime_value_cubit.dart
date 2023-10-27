import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_sp2/domain/customer_lifetime_value_use_case.dart';
import 'package:frontend_sp2/domain/model/customer_lifetime_value/customer_lifetime_value_item.dart';
import 'package:frontend_sp2/domain/model/customer_lifetime_value/customer_lifetime_value_report_model.dart';
import 'package:frontend_sp2/domain/model/customer_lifetime_value/customer_lifetime_value_report_model_elements.dart';
import 'package:frontend_sp2/domain/model/year_filter_model.dart';
import 'package:logger/logger.dart';

part 'customer_lifetime_value_cubit.freezed.dart';

class CustomerLifetimeValueCubit
    extends Cubit<CustomerLifetimeValueScreenState> {
  final CustomerLifetimeValueUseCase _customerLifetimeValueUseCase;
  final List<CustomerLifetimeValueItem> allElements = [];
  final Logger _logger;

  CustomerLifetimeValueCubit(this._customerLifetimeValueUseCase, this._logger)
      : super(Loading());

  void getCustomerLifetimeValue() async {
    var result = await _customerLifetimeValueUseCase();

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
class CustomerLifetimeValueScreenState with _$CustomerLifetimeValueScreenState {
  factory CustomerLifetimeValueScreenState.current(
      {required CustomerLifetimeValueReportModel model}) = Current;

  factory CustomerLifetimeValueScreenState.loading() = Loading;

}
