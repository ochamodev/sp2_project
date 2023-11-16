import 'package:equatable/equatable.dart';
import 'package:frontend_sp2/domain/model/customer_retention/customer_retention_item.dart';
import 'package:frontend_sp2/domain/model/customer_retention/customer_retention_report_model_elements.dart';
import 'package:frontend_sp2/domain/model/year_filter_model.dart';

class CustomerRetentionReportModel extends Equatable {
// modelar propiedades indepedientes
// modelar años filtro
// modelar graficas

  final List<YearFilterModel> yearFilters;
  final List<CustomerRetentionItem> reportList;

  CustomerRetentionReportModel({
    required this.yearFilters,
    required this.reportList
  });

  @override
  List<Object?> get props => [
    yearFilters,
    reportList
  ];

  CustomerRetentionReportModel copyWith({
    List<YearFilterModel>? yearFilters,
    List<CustomerRetentionItem>? reportList,
  }) {
    return CustomerRetentionReportModel(
        yearFilters: yearFilters ?? this.yearFilters,
        reportList: reportList ?? this.reportList
    );
  }
}