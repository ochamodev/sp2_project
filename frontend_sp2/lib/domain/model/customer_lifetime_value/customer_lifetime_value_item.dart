
import 'package:frontend_sp2/domain/model/customer_lifetime_value/customer_lifetime_value_report_model_elements.dart';

class CustomerLifetimeValueItem {
  final List<double> customerValues;
  final List<int> months;
  final int year;
  final List<CustomerLifetimeValueReportModelElements> elements;

  CustomerLifetimeValueItem({
    required this.customerValues,
    required this.months,
    required this.elements,
    required this.year
});

}