
import 'package:json_annotation/json_annotation.dart';

part 'sales_performance_elements.g.dart';

@JsonSerializable()
class SalesPerformanceElements {
  final double amount;
  @JsonKey(name: "monthT")
  final int year;
  final int quantity;

  SalesPerformanceElements({
    required this.amount,
    required this.year,
    required this.quantity
  });

  factory SalesPerformanceElements.fromJson(Map<String, dynamic> json) =>
      _$SalesPerformanceElementsFromJson(json);

}