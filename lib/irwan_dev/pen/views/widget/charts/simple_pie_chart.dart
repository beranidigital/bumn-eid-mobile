import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimplePieChart extends StatelessWidget {
  List<int> nilai = [10, 20, 30, 40, 50, 60];

  List<charts.Series> seriesList;
  // final bool animate;

  // SimplePieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  // factory SimplePieChart.withSampleData() {
  //   return new SimplePieChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  buildChart() {
    return new charts.PieChart(
      seriesList,
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    seriesList = _createSampleData();
    return Container(
      constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
      child: buildChart(),
    );
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<LinearSales, int>> _createSampleData() {
    List<LinearSales> data = [];
    for (int i = 0; i < nilai.length; i++) {
      new LinearSales(i, nilai[i]);
    }

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
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
