import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class LinePointChart extends StatelessWidget {
  List<charts.Series> seriesList;
  // final bool animate;

  // LinePointChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  // factory PointsLineChart.withSampleData() {
  //   return new PointsLineChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  buildChart() {
    return new charts.LineChart(
      seriesList,
      animate: false,
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    seriesList = _createSampleData();
    return Container(
      constraints: BoxConstraints(maxHeight: 200),
      child: buildChart(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];
    final datas = [
      new LinearSales(0, 10),
      new LinearSales(1, 20),
      new LinearSales(2, 80),
      new LinearSales(3, 63),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Ordinal',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: datas,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
