
import 'package:frontend_sp2/data/response/monthly_sales_per_year.dart';
import 'package:frontend_sp2/data/response/sales_performance_elements.dart';
import 'package:frontend_sp2/data/response/year_filters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sales_performance_report_response.g.dart';

@JsonSerializable()
class SalesPerformanceReportResponse {
  @JsonKey(name: 'monthlySalesPerYear')
  final Map<String, List<MonthlySalesPerYear>> monthlySalesPerYear;
  final List<YearFilters> yearFilters;
  final List<SalesPerformanceElements> salesPerformanceElements;

  SalesPerformanceReportResponse({
    required this.monthlySalesPerYear,
    required this.yearFilters,
    required this.salesPerformanceElements
  });

  factory SalesPerformanceReportResponse.fromJson(Map<String, dynamic> json) =>
      _$SalesPerformanceReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SalesPerformanceReportResponseToJson(this);

}