import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// Forward hatch pattern horizontal bar chart example.
///
/// The second series of bars is rendered with a pattern by defining a
/// fillPatternFn mapping function.
class FourHorizontalBarChart extends StatelessWidget {
  List<charts.Series> seriesList;
  // final bool animate;

  // HorizontalPatternForwardHatchBarChart(this.seriesList, {this.animate});

  // factory HorizontalPatternForwardHatchBarChart.withSampleData() {
  //   return new HorizontalPatternForwardHatchBarChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  barChart() {
    return new charts.BarChart(
      seriesList,
      animate: false,
      barGroupingType: charts.BarGroupingType.grouped,
      vertical: false,
      // primaryMeasureAxis: charts.NumericAxisSpec(
      //   showAxisLine: false,
      // ),

      // domainAxis: new charts.DateTimeAxisSpec(
      // tickProviderSpec: charts.DayTickProviderSpec(increments: [1]),
      // tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
      //   day: new charts.TimeFormatterSpec(
      //       format: 'EEE', transitionFormat: 'EEE', noonFormat: 'EEE'),
      // ),
      // showAxisLine: false,
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    seriesList = _createSampleData();
    return Container(
      constraints: BoxConstraints(maxHeight: 200),
      child: barChart(),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 80),
      new OrdinalSales('2015', 300),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', 205),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 60),
      new OrdinalSales('2017', 70),
    ];

    final mobilePNMData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    final mobilePNM = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
        fillColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
        fillColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'PNM',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobilePNMData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobilePNM,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
