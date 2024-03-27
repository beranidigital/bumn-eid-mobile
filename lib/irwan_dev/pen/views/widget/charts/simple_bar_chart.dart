import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  List<charts.Series> seriesList;
  // final bool animate;

  // SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  // factory SimpleBarChart.withSampleData() {
  //   return new SimpleBarChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
      // barGroupingType: charts.BarGroupingType.groupedStacked,
      // defaultRenderer: charts.BarRendererConfig(
      //   groupingType: charts.BarGroupingType.groupedStacked,
      //   strokeWidthPx: 2.0,
      // ),
      primaryMeasureAxis: new charts.NumericAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
        // showAxisLine: true,
      ),
      secondaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
        // showAxisLine: true,
        // tickFormatterSpec: charts.NumericTickFormatterSpec(),
      ),
      // new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
      // domainAxis: new charts.OrdinalAxisSpec(
      //   showAxisLine: true,
      //   renderSpec: new charts.NoneRenderSpec(),
      // ),
      // flipVerticalAxis: true,
      domainAxis: charts.OrdinalAxisSpec(
        // viewport: charts.OrdinalViewport(startingDomain, dataSize),
        showAxisLine: true,
        // renderSpec: charts.NoneRenderSpec(),
      ),
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

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('Jan 2014', 5),
      new OrdinalSales('Feb 2015', 25),
      new OrdinalSales('Mar 2016', 100),
      new OrdinalSales('Apr 2018', 75),
      new OrdinalSales('May 2019', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
