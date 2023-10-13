import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';

import '../../../../../utils/formatting.dart';

class SalesPerformanceLineChart extends StatelessWidget {
  final List<int> months;
  final List<int> salesQuantity;

  const SalesPerformanceLineChart(
      {required this.months, required this.salesQuantity, super.key});

  LineTouchData get lineTouchData => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 1.0,
        reservedSize: 30,
        getTitlesWidget: (double value, TitleMeta meta) => SideTitleWidget(
          axisSide: meta.axisSide,
          space: 4,
          child: Text(
            MonthFormat.numberToAbbreviation(value: value.toInt()),
          ),
        ),
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        getTitlesWidget: (double value, TitleMeta meta) {
          if (value == meta.max) {
            return Container();
          }
          const style = TextStyle(
            fontSize: 10,
          );
          return SideTitleWidget(
            axisSide: meta.axisSide,
            child: Text(
              meta.formattedValue,
              style: style,
            ),
          );
        },
      ),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(show: true);

  List<LineChartBarData> get lineBarsData => [
    LineChartBarData(
      isCurved: false,
      barWidth: 1,
      isStrokeCapRound: true,
      color: AppColors.deepPurple,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      spots: months
          .map(
            (e) => FlSpot(e.toDouble(), salesQuantity[e - 1] as double),
      )
          .toList(),
    ),
  ];

  LineChartData get data => LineChartData(
    lineBarsData: lineBarsData,
    lineTouchData: lineTouchData,
    titlesData: titlesData1,
    borderData: borderData,
    gridData: FlGridData(
      show: true,
      checkToShowHorizontalLine: (value) => value % 10 == 0,
      getDrawingHorizontalLine: (value) => const FlLine(
        color: Colors.black26,
        strokeWidth: 1,
      ),
      drawVerticalLine: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return LineChart(data);
  }
}
