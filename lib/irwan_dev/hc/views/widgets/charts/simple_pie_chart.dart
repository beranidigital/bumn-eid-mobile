import 'package:bumn_eid/irwan_dev/resources/list_color.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimplePieChart extends StatelessWidget {
  List<int> nilai;
  List<charts.Series> seriesList;
  SimplePieChart({
    Key key,
    this.nilai,
  }) : super(key: key);

  barChart() {
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
      child: barChart(),
    );
    // return new charts.PieChart(seriesList, animate: animate);
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<LinearSales, int>> _createSampleData() {
    List<LinearSales> data = [];
    for (int i = 0; i < nilai.length; i++) {
      data.add(
        new LinearSales(
          i,
          nilai[i],
          colorList[i],
        ),
      );
    }

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        colorFn: (LinearSales sales, _) =>
            charts.ColorUtil.fromDartColor(sales.warna),
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final Color warna;

  LinearSales(this.year, this.sales, this.warna);
}
