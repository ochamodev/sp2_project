import 'package:fpdart/fpdart.dart';

class SalesPerformanceModel {
  final int year;
  final Map<int, Map<String, num>> data;

  const SalesPerformanceModel({required this.year, required this.data});

  List<int> get months => data.keys.toList();
  List<double?> get monthlySales =>
      data.values.map((value) => value["amount"] as double?).toList();
  List<int?> get monthlySalesQuantity =>
      data.values.map((value) => value["quantity"] as int?).toList();
  List<double> get monthlyFilteredSales =>
      monthlySales.filter((t) => t != null).toList().cast<double>();
  List<int> get monthlyFilteredSalesQuantity =>
      monthlySalesQuantity.filter((t) => t != null).toList().cast<int>();

  double get totalAnnualSales =>
      monthlyFilteredSales.reduce((value, element) => value + element);
  double get averageSales => totalAnnualSales / monthlyFilteredSales.length;

  double get recentMonthSales {
    for (int i = monthlySales.length - 1; i >= 0; i--) {
      final double? amount = data[i]!["amount"] as double?;

      if (amount != null) {
        return amount;
      } else {
        continue;
      }
    }

    return 0;
  }
}
