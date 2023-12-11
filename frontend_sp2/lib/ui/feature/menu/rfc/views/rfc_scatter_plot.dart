import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/utils/formatting.dart';

class RFCScatterPlot extends StatelessWidget {
  final List<double> xValues;
  final List<double> yValues;
  final String yTitle;
  final String xTitle;

  const RFCScatterPlot(
      { super.key,
        required this.xValues, required this.yValues,
        required this.yTitle, required this.xTitle
      });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: ScatterChart(
          ScatterChartData(
            scatterSpots: List.generate(
              xValues.length,
                  (index) => ScatterSpot(
                xValues[index],
                yValues[index],
                show: true,
                radius: 8,
                color: AppColors.deepPurple, // Adjust the color as needed
              ),
            ),
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 44,
                  showTitles: true,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 30,
                  showTitles: true,
                ),
              ),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
            scatterTouchData: ScatterTouchData(
              touchTooltipData: ScatterTouchTooltipData(
                tooltipBgColor: AppColors.defaultRedColor,
              ),
            ),
          ),
        ),
      ),
    );
  }


}