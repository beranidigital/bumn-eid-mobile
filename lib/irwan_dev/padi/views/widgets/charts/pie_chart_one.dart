import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:bumn_eid/irwan_dev/padi/models/linear_pie_chart.dart';

class PieChartOne extends StatelessWidget {
  final List<LinearPieChart> classLinearSales;
  final int width;

  PieChartOne({this.classLinearSales, this.width});

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: chart.PieChart(
        _createSampleData(classLinearSales),
        animate: false,
        defaultRenderer: new chart.ArcRendererConfig(arcWidth: width),
        behaviors: [
          new chart.DatumLegend(
            position: chart.BehaviorPosition.start,
            entryTextStyle: new chart.TextStyleSpec(fontSize: 10),
            legendDefaultMeasure: chart.LegendDefaultMeasure.firstValue,
            showMeasures: true,
            measureFormatter: (num value) {
              return value == null ? '-' : ': $value';
            },
          ),
        ],
      ),
    );
  }

  static List<chart.Series<LinearPieChart, String>> _createSampleData(
      List<LinearPieChart> classLinearSales) {
    dynamic data = [for (var item in classLinearSales) item];

    return [
      new chart.Series<LinearPieChart, String>(
        id: 'Pie Chart One',
        colorFn: (LinearPieChart sales, __) => sales.color,
        domainFn: (LinearPieChart sales, _) => sales.status,
        measureFn: (LinearPieChart sales, _) => sales.value,
        data: data,
      )
    ];
  }
}
