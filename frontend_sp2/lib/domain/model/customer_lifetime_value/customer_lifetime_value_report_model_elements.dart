
import 'package:equatable/equatable.dart';

class CustomerLifetimeValueReportModelElements extends Equatable {
  final String amount;
  final int clientCount;
  final String purchaseRate;
  final String purchaseValue;
  final int quantity;
  final int yearT;


  const CustomerLifetimeValueReportModelElements({
    required this.amount,
    required this.clientCount,
    required this.purchaseRate,
    required this.purchaseValue,
    required this.quantity, required
    this.yearT
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    amount,
    clientCount,
    purchaseRate,

  ];

}