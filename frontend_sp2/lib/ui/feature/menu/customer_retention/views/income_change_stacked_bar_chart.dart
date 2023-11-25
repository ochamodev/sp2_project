import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/utils/formatting.dart';

class IncomeChangeBarChart extends StatelessWidget {
  final List<int> months;
  final List<double> cancelledAmount, newAmount, retainedAmount;
  final Color colorCancelledAmount, colorNewAmount, colorRetainedAmount;
  final double barWidth;
  const IncomeChangeBarChart(
      {required this.months,
      required this.cancelledAmount,
      required this.newAmount,
      required this.retainedAmount,
      this.colorCancelledAmount = Colors.red,
      this.colorNewAmount = Colors.green,
      this.colorRetainedAmount = Colors.yellow,
      this.barWidth = 35,
      super.key});

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
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
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(show: true);

  List<BarChartGroupData> get barGroups =>
      List<BarChartGroupData>.generate(months.length, (index) {
        final double maxValue =
            cancelledAmount[index] + newAmount[index] + retainedAmount[index];

        return BarChartGroupData(
          barsSpace: 4,
          x: months[index],
          barRods: [
            BarChartRodData(
              toY: maxValue,
              width: barWidth,
              rodStackItems: [
                BarChartRodStackItem(
                    0, cancelledAmount[index], colorCancelledAmount),
                BarChartRodStackItem(cancelledAmount[index],
                    maxValue - newAmount[index], colorRetainedAmount),
                BarChartRodStackItem(
                    maxValue - newAmount[index], maxValue, colorNewAmount),
              ],
              borderRadius: BorderRadius.zero,
            )
          ],
          //showingTooltipIndicators: [0],
        );
      });

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              CurrencyFormat.usCurrency(value: rod.toY),
              const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: FlGridData(
          show: true,
          checkToShowHorizontalLine: (value) => value % 10 == 0,
          getDrawingHorizontalLine: (value) => const FlLine(
            color: Colors.black26,
            strokeWidth: 1,
          ),
          drawVerticalLine: false,
        ),
        alignment: BarChartAlignment.spaceAround,
        //maxY: 20,
      ),
    );
  }
}
