
import 'package:equatable/equatable.dart';

class MonthlySalesPerYearModel extends Equatable {
  final double amount;
  final int month;
  final int year;
  final int quantity;

  MonthlySalesPerYearModel({
    required this.amount,
    required this.month,
    required this.year,
    required this.quantity
  });

  @override
  List<Object?> get props => [amount, month, year, quantity];
}