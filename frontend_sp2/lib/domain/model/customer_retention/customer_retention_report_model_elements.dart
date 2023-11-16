import 'package:equatable/equatable.dart';

class CustomerRetentionReportModelElements extends Equatable {
  final int yearT;
  final int newClients;
  final String newAmount;
  final int cancelledClients;
  final String cancelledAmount;
  final int retainedClients;
  final String retainedAmount;
  final String customerRetention;


  const CustomerRetentionReportModelElements({
    required this.yearT,
    required this.newClients,
    required this.newAmount,
    required this.cancelledClients,
    required this.cancelledAmount,
    required this.retainedClients,
    required this.retainedAmount,
    required this.customerRetention,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    yearT,
    newClients,
    newAmount,
    cancelledClients,
    cancelledAmount,
    retainedClients,
    retainedAmount,
    customerRetention,
  ];

}