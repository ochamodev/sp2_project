
import 'package:equatable/equatable.dart';
import 'package:frontend_sp2/domain/model/customer_lifetime_value/customer_lifetime_value_item.dart';
import 'package:frontend_sp2/domain/model/customer_lifetime_value/customer_lifetime_value_report_model_elements.dart';
import 'package:frontend_sp2/domain/model/customer_lifetime_value/summary_card_model.dart';
import 'package:frontend_sp2/domain/model/year_filter_model.dart';

class CustomerLifetimeValueReportModel extends Equatable {
// modelar propiedades indepedientes
// modelar años filtro
// modelar graficas
  final List<SummaryCardModel> generalSummary;
  final List<YearFilterModel> yearFilters;
  final List<CustomerLifetimeValueItem> reportList;

  CustomerLifetimeValueReportModel({
    required this.generalSummary,
    required this.yearFilters,
    required this.reportList
  });

  @override
  List<Object?> get props => [
    generalSummary,
    yearFilters,
    reportList
  ];

  CustomerLifetimeValueReportModel copyWith({
    List<SummaryCardModel>? generalSummary,
    List<YearFilterModel>? yearFilters,
    List<CustomerLifetimeValueItem>? reportList,
  }) {
    return CustomerLifetimeValueReportModel(
        generalSummary: generalSummary ?? this.generalSummary,
        yearFilters: yearFilters ?? this.yearFilters,
      reportList: reportList ?? this.reportList
    );
  }
}