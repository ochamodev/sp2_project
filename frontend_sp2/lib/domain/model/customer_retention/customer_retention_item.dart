import 'package:frontend_sp2/domain/model/customer_retention/customer_retention_report_model_elements.dart';

class CustomerRetentionItem {
  final List<double> newAmounts;
  final List<double> cancelledAmounts;
  final List<double> retainedAmounts;
  final List<int> newClients;
  final List<int> cancelledClients;
  final List<int> retainedClients;
  final List<double> customerRetentions;
  final List<int> months;
  final int year;
  final List<CustomerRetentionReportModelElements> elements;

  CustomerRetentionItem({
    required this.newAmounts,
    required this.cancelledAmounts,
    required this.retainedAmounts,
    required this.newClients,
    required this.cancelledClients,
    required this.retainedClients,
    required this.customerRetentions,
    required this.months,
    required this.year,
    required this.elements,
  });

}