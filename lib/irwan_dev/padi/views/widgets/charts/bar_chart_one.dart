import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:bumn_eid/irwan_dev/padi/models/ordinal_bar_chart.dart';

class BarChartOne extends StatelessWidget {
  final List<OrdinalBarChart> classOrdinalBarChart;

  BarChartOne({this.classOrdinalBarChart});

  @override
  Widget build(BuildContext context) {
    return chart.BarChart(
      _createSampleData(classOrdinalBarChart),
      animate: false,
      vertical: false,
      barRendererDecorator: new chart.BarLabelDecorator<String>(),
      domainAxis:
          new chart.OrdinalAxisSpec(renderSpec: new chart.NoneRenderSpec()),
    );
  }

  static List<chart.Series<OrdinalBarChart, String>> _createSampleData(
      List<OrdinalBarChart> classOrdinalBarChart) {
    dynamic data = [for (var item in classOrdinalBarChart) item];

    return [
      new chart.Series<OrdinalBarChart, String>(
        id: 'Bar Chart One',
        domainFn: (OrdinalBarChart value, _) => value.status,
        measureFn: (OrdinalBarChart value, __) => value.value,
        colorFn: (OrdinalBarChart value, __) => value.color,
        data: data,
      )
    ];
  }
}
