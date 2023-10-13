
import 'package:json_annotation/json_annotation.dart';

part 'monthly_sales_per_year.g.dart';

@JsonSerializable()
class MonthlySalesPerYear {
  @JsonKey(name: "amount")
  final String amount;
  @JsonKey(name: "monthT")
  final int month;
  @JsonKey(name: "yearT")
  final int year;
  @JsonKey(name: "quantity")
  final int quantity;

  MonthlySalesPerYear({
    required this.amount,
    required this.month,
    required this.year,
    required this.quantity
  });

  factory MonthlySalesPerYear.fromJson(Map<String, dynamic> json) =>
      _$MonthlySalesPerYearFromJson(json);

}