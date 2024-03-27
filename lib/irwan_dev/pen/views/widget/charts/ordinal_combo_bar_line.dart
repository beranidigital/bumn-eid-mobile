import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class OrdinalComboBarLineChart extends StatelessWidget {
  List<charts.Series> seriesList;
  // final bool animate;

  // OrdinalComboBarLineChart(this.seriesList, {this.animate});

  // factory OrdinalComboBarLineChart.withSampleData() {
  //   return new OrdinalComboBarLineChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  buildChart() {
    return new charts.OrdinalComboChart(seriesList,
        animate: false,
        // primaryMeasureAxis: new charts.NumericAxisSpec(
        //   renderSpec: charts.SmallTickRendererSpec(),
        //   // showAxisLine: true,
        // ),
        // Configure the default renderer as a bar renderer.
        defaultRenderer: new charts.BarRendererConfig(
            groupingType: charts.BarGroupingType.grouped),
        // Custom renderer configuration for the line series. This will be used for
        // any series that does not define a rendererIdKey.
        customSeriesRenderers: [
          new charts.LineRendererConfig(
              // ID used to link series to this renderer.
              customRendererId: 'customLine')
        ]);
  }

  @override
  Widget build(BuildContext context) {
    seriesList = _createSampleData();
    return Container(
      constraints: BoxConstraints(maxHeight: 200),
      child: buildChart(),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
      new OrdinalSales('2018', 100),
      new OrdinalSales('2019', 75),
      new OrdinalSales('2020', 100),
      new OrdinalSales('2021', 75),
    ];

    // final tableSalesData = [
    //   new OrdinalSales('2014', 5),
    //   new OrdinalSales('2015', 25),
    //   new OrdinalSales('2016', 100),
    //   new OrdinalSales('2017', 75),
    // ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 200),
      new OrdinalSales('2017', 150),
      new OrdinalSales('2018', 100),
      new OrdinalSales('2019', 75),
      new OrdinalSales('2020', 100),
      new OrdinalSales('2021', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
          id: 'Desktop',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: desktopSalesData),
      // new charts.Series<OrdinalSales, String>(
      //     id: 'Tablet',
      //     colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      //     domainFn: (OrdinalSales sales, _) => sales.year,
      //     measureFn: (OrdinalSales sales, _) => sales.sales,
      //     data: tableSalesData),
      new charts.Series<OrdinalSales, String>(
          id: 'Mobile ',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: mobileSalesData)
        // Configure our custom line renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
