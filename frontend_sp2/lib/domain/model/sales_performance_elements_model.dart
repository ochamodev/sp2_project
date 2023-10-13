
import 'package:equatable/equatable.dart';

class SalesPerformanceElementsModel extends Equatable {
  final String amount;
  final int year;
  final int yearlyQuantity;
  final double yearAvg;
  final double totalFinalMonth;
  final List<int> months;
  final List<double> amounts;
  final List<int> monthlyQuantity;

  SalesPerformanceElementsModel({
    required this.amount,
    required this.year,
    required this.yearlyQuantity,
    required this.yearAvg,
    required this.totalFinalMonth,
    required this.amounts,
    required this.months,
    required this.monthlyQuantity
  });

  @override
  // TODO: implement props
  List<Object?> get props => [amount, year, yearlyQuantity];

}