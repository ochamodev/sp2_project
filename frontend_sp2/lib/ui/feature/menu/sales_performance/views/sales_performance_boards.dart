
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/formatting.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/views/sales_performance_block_info_item.dart';

class SalesPerformanceBoards extends StatelessWidget {
  final double annualSales;
  final double currentMonthTotal;
  final double avgAnnualSales;
  final double monthlyVariance;

  const SalesPerformanceBoards({
    super.key,
    required this.annualSales,
    required this.currentMonthTotal,
    required this.avgAnnualSales,
    required this.monthlyVariance
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 40,
      children: [
        DashboardCardSimple(
            label: 'Total ventas anuales',
            value: CurrencyFormat.usCurrency(value: annualSales),
            icon: Icons.bar_chart 
        ),
        DashboardCardSimple(
            label: 'Total ventas mes actual',
            value: CurrencyFormat.usCurrency(value: currentMonthTotal),
            icon: Icons.bar_chart
        ),
        DashboardCardSimple(
            label: 'Promedio ventas anual',
            value: CurrencyFormat.usCurrency(value: avgAnnualSales),
            icon: Icons.bar_chart
        ),
        /*DashboardCardSimple(
            label: 'Varianza mensual',
            value: CurrencyFormat.usCurrency(value: monthlyVariance),
            icon: Icons.bar_chart
        )*/
      ],
    );
  }

}