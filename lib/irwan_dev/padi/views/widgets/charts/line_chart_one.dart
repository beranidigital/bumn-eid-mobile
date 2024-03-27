import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as chart;

class LineChartOne extends StatefulWidget {
  @override
  _LineChartOneState createState() => _LineChartOneState();
}

class _LineChartOneState extends State<LineChartOne> {
  List<chart.Series> serialLineData;

  final customTickFormatter = chart.BasicNumericTickFormatterSpec((num value) {
    String result = "";
    if (value == 0) {
      result = "Jan 20";
    } else if (value == 1) {
      result = "Feb 20";
    } else if (value == 2) {
      result = "Mar 20";
    } else if (value == 3) {
      result = "Apr 20";
    } else if (value == 4) {
      result = "Mei 20";
    } else if (value == 5) {
      result = "Jun 20";
    } else if (value == 6) {
      result = "Jul 20";
    } else if (value == 7) {
      result = "Agt 20";
    } else if (value == 8) {
      result = "Sep 20";
    } else if (value == 9) {
      result = "Okt 20";
    } else if (value == 10) {
      result = "Nov 20";
    } else if (value == 11) {
      result = "Des 20";
    }
    return result;
  });

  @override
  Widget build(BuildContext context) {
    return chart.LineChart(
      _createSampleData(),
      animate: false,
      primaryMeasureAxis: new chart.NumericAxisSpec(
        tickProviderSpec: new chart.BasicNumericTickProviderSpec(
          dataIsInWholeNumbers: true,
          desiredTickCount: 5,
        ),
      ),
      domainAxis: chart.NumericAxisSpec(
        tickProviderSpec:
            chart.BasicNumericTickProviderSpec(desiredTickCount: 12),
        tickFormatterSpec: customTickFormatter,
        renderSpec: chart.SmallTickRendererSpec(
          tickLengthPx: 10,
          labelRotation: 45,
          labelStyle: new chart.TextStyleSpec(
            fontSize: 8, // size in Pts.
            color: chart.MaterialPalette.black,
          ),
        ),
      ),
    );
  }

  static List<chart.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 10000),
      new LinearSales(1, 8000),
      new LinearSales(2, 3000),
      new LinearSales(3, 30000),
      new LinearSales(4, 8000),
      new LinearSales(5, 24000),
      new LinearSales(6, 12000),
      new LinearSales(7, 14000),
      new LinearSales(8, 13500),
      new LinearSales(9, 12300),
      new LinearSales(10, 9000),
      new LinearSales(11, 8000),
    ];

    return [
      new chart.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => chart.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.time,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class LinearSales{
  final int time;
  final int sales;

  LinearSales(this.time, this.sales);
}



