import 'package:equatable/equatable.dart';
import 'package:frontend_sp2/domain/model/monthly_sales_per_year_model.dart';
import 'package:frontend_sp2/domain/model/sales_performance_elements_model.dart';
import 'package:frontend_sp2/domain/model/year_filter_model.dart';

class SalesPerformanceReportModel extends Equatable {
  final Map<String, List<MonthlySalesPerYearModel>> monthlySalesPerYear;
  final List<YearFilterModel> yearFilters;
  final List<SalesPerformanceElementsModel> salesPerformanceElements;

  SalesPerformanceReportModel({
    required this.monthlySalesPerYear,
    required this.yearFilters,
    required this.salesPerformanceElements
  });

  SalesPerformanceReportModel copyWith({
    Map<String, List<MonthlySalesPerYearModel>>? monthlySalesPerYear,
    List<YearFilterModel>? yearFilters,
    List<SalesPerformanceElementsModel>? salesPerformanceElements
  }) {
    return SalesPerformanceReportModel(
        monthlySalesPerYear: monthlySalesPerYear ?? this.monthlySalesPerYear,
        yearFilters: yearFilters ?? this.yearFilters,
        salesPerformanceElements: salesPerformanceElements ?? this.salesPerformanceElements
    );
  }

  @override
  List<Object?> get props => [monthlySalesPerYear, yearFilters, salesPerformanceElements];

}