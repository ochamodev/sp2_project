
import 'package:flutter/material.dart';
import 'package:high_chart/high_chart.dart';


class ChartComponent extends StatelessWidget {
  final String chartData;
  const ChartComponent({
    super.key,
    required this.chartData
  });

  @override
  Widget build(BuildContext context) {
    return HighCharts(
      loader: const SizedBox(
        width: 200,
        child: LinearProgressIndicator(),
      ),
      size: const Size(400, 400),
      data: chartData,
      scripts: const [
        "https://code.highcharts.com/highcharts.js",
        'https://code.highcharts.com/modules/networkgraph.js',
        'https://code.highcharts.com/modules/exporting.js',
      ],
    );
  }

}