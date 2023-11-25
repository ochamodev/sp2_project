import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/utils/formatting.dart';

class AccountRetentionBarChart extends StatelessWidget {
  final List<int> months;
  final List<int> cancelledClients, newClients, retainedClients;
  final Color colorCancelledClients, colorNewClients, colorRetainedClients;
  const AccountRetentionBarChart(
      {required this.months,
      required this.cancelledClients,
      required this.newClients,
      required this.retainedClients,
      this.colorCancelledClients = Colors.red,
      this.colorNewClients = Colors.green,
      this.colorRetainedClients = Colors.yellow,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CNRStackedBarChart(
      months: months,
      cancelledQuantity: cancelledClients.cast<double>(),
      newQuantity: newClients.cast<double>(),
      retainedQuantity: retainedClients.cast<double>(),
      colorCancelled: colorCancelledClients,
      colorNew: colorNewClients,
      colorRetained: colorRetainedClients,
      showAsCurrency: false,
    );
  }
}

class CNRStackedBarChart extends StatefulWidget {
  final List<int> months;
  final List<double> cancelledQuantity, newQuantity, retainedQuantity;
  final Color colorCancelled, colorNew, colorRetained;
  final double barWidth, barRadius;
  final bool showAsCurrency;
  const CNRStackedBarChart(
      {required this.months,
        required this.cancelledQuantity,
        required this.newQuantity,
        required this.retainedQuantity,
        required this.showAsCurrency,
        this.colorCancelled = Colors.red,
        this.colorNew = Colors.green,
        this.colorRetained = Colors.yellow,
        this.barWidth = 35,
        this.barRadius = 8.0,
        super.key});

  @override
  State<StatefulWidget> createState() => _CNRStackedBarChartState();
}

class _CNRStackedBarChartState extends State<CNRStackedBarChart> {
  late int _defaultStackItemIndex, _touchedStackItemIndex;

  @override
  void initState() {
    super.initState();
    _defaultStackItemIndex = 2;
    _touchedStackItemIndex = _defaultStackItemIndex;
  }

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
            MonthFormat.numberToAbbreviation(
                value: widget.months[value.toInt()]),
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
      List<BarChartGroupData>.generate(widget.months.length, (index) {
        final double maxValue = (widget.cancelledQuantity[index] +
            widget.newQuantity[index] +
            widget.retainedQuantity[index])
            .toDouble();

        return BarChartGroupData(
          barsSpace: 4,
          x: index,
          showingTooltipIndicators: [],
          barRods: [
            BarChartRodData(
              toY: maxValue,
              width: widget.barWidth,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.barRadius),
                topRight: Radius.circular(widget.barRadius),
              ),
              rodStackItems: [
                BarChartRodStackItem(
                    0,
                    widget.cancelledQuantity[index].toDouble(),
                    widget.colorCancelled),
                BarChartRodStackItem(
                    widget.cancelledQuantity[index].toDouble(),
                    maxValue - widget.newQuantity[index].toDouble(),
                    widget.colorRetained),
                BarChartRodStackItem(
                    maxValue - widget.newQuantity[index].toDouble(),
                    maxValue,
                    widget.colorNew),
              ],
            )
          ],
          //showingTooltipIndicators: [0],
        );
      });

  BarTouchData get barTouchData => BarTouchData(
    enabled: true,
    touchCallback: (event, barTouchResponse) => setState(() =>
    _touchedStackItemIndex =
    barTouchResponse != null && barTouchResponse.spot != null
        ? barTouchResponse.spot!.touchedStackItemIndex
        : _defaultStackItemIndex),
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
        final double groupQuantity =
            rod.rodStackItems[_touchedStackItemIndex].toY -
                rod.rodStackItems[_touchedStackItemIndex].fromY;
        return BarTooltipItem(
          widget.showAsCurrency
              ? CurrencyFormat.usCurrency(value: groupQuantity)
              : groupQuantity.toInt().toString(),
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
      ),
    );
  }
}

