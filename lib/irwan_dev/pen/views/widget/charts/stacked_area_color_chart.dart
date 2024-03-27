import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class StackedAreaColorChart extends StatelessWidget {
  List<charts.Series> seriesList;
  // final bool animate;

  // StackedAreaCustomColorLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  // factory StackedAreaCustomColorLineChart.withSampleData() {
  //   return new StackedAreaCustomColorLineChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  buildChart() {
    return new charts.LineChart(
      seriesList,
      defaultRenderer:
          new charts.LineRendererConfig(includeArea: true, stacked: true),
      animate: false,
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
    final myFakeDesktopData = [
      new LinearSales(0, 50),
      new LinearSales(1, 25),
      new LinearSales(2, 30),
      new LinearSales(3, 75),
    ];

    var myFakeTabletData = [
      new LinearSales(0, 90),
      new LinearSales(1, 50),
      new LinearSales(2, 50),
      new LinearSales(3, 150),
    ];

    var myFakeMobileData = [
      new LinearSales(0, 15),
      new LinearSales(1, 75),
      new LinearSales(2, 100),
      new LinearSales(3, 225),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Desktop',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.darker
            .lighter.lighter.lighter.lighter,
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.darker
            .lighter.lighter.lighter.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeDesktopData,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Tablet',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) =>
            charts.MaterialPalette.green.shadeDefault.lighter.lighter,
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
            charts.MaterialPalette.green.shadeDefault.lighter.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeTabletData,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Mobile',
        // colorFn specifies that the line will be green.
        colorFn: (_, __) => charts
            .MaterialPalette.blue.shadeDefault.darker.lighter.lighter.lighter,
        // areaColorFn specifies that the area skirt will be light green.
        areaColorFn: (_, __) => charts
            .MaterialPalette.blue.shadeDefault.darker.lighter.lighter.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeMobileData,
      ),
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
