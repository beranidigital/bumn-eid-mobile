import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/padi/models/ordinal_bar_chart.dart';
import 'package:charts_flutter/flutter.dart' as chart;

class BarChartTwo extends StatelessWidget {
  final List<OrdinalBarChart> classOrdinalBarChart;

  BarChartTwo({this.classOrdinalBarChart});

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: chart.BarChart(
        _createSampleData(classOrdinalBarChart),
        animate: false,
        vertical: false,
        barGroupingType: chart.BarGroupingType.stacked,
        domainAxis:
            new chart.OrdinalAxisSpec(renderSpec: new chart.NoneRenderSpec()),
        behaviors: [new chart.SeriesLegend()],
      ),
    );
  }

  static List<chart.Series<OrdinalBarChart, String>> _createSampleData(
      List<OrdinalBarChart> classOrdinalBarChart) {
    dynamic dataOne = [
      new OrdinalBarChart('Material Kontruksi ((2.300 UMKM))', 6000,
          chart.MaterialPalette.blue.shadeDefault),
      new OrdinalBarChart('Jasa Kontruksi Dan Renovasi', 3000,
          chart.MaterialPalette.red.shadeDefault),
      new OrdinalBarChart('Jasa Ekspedisi dan Pengepakan', 1000,
          chart.MaterialPalette.red.shadeDefault),
      new OrdinalBarChart('Pengadaan & Sewa Perakatan Medin', 1500,
          chart.MaterialPalette.red.shadeDefault),
      new OrdinalBarChart('Pengadaan & Sewa Perlengkapan Furniture', 4000,
          chart.MaterialPalette.red.shadeDefault),
    ];

    dynamic dataTwo = [
      new OrdinalBarChart('Material Kontruksi ((2.300 UMKM))', 1000,
          chart.MaterialPalette.red.shadeDefault),
      new OrdinalBarChart('Jasa Kontruksi Dan Renovasi', 2000,
          chart.MaterialPalette.red.shadeDefault),
      new OrdinalBarChart('Jasa Ekspedisi dan Pengepakan', 1000,
          chart.MaterialPalette.red.shadeDefault),
      new OrdinalBarChart('Pengadaan & Sewa Perakatan Medin', 3000,
          chart.MaterialPalette.red.shadeDefault),
      new OrdinalBarChart('Pengadaan & Sewa Perlengkapan Furniture', 500,
          chart.MaterialPalette.red.shadeDefault),
    ];

    dynamic dataThree = [
      new OrdinalBarChart('Material Kontruksi ((2.300 UMKM))', 500,
          chart.MaterialPalette.red.shadeDefault),
      new OrdinalBarChart('Jasa Kontruksi Dan Renovasi', 4000,
          chart.MaterialPalette.red.shadeDefault),
      new OrdinalBarChart('Jasa Ekspedisi dan Pengepakan', 1000,
          chart.MaterialPalette.red.shadeDefault),
      new OrdinalBarChart('Pengadaan & Sewa Perakatan Medin', 2000,
          chart.MaterialPalette.red.shadeDefault),
      new OrdinalBarChart('Pengadaan & Sewa Perlengkapan Furniture', 1500,
          chart.MaterialPalette.red.shadeDefault),
    ];

    return [
      new chart.Series<OrdinalBarChart, String>(
        id: 'Mikro',
        domainFn: (OrdinalBarChart value, _) => value.status,
        measureFn: (OrdinalBarChart value, __) => value.value,
        colorFn: (OrdinalBarChart value, __) => value.color,
        data: dataOne,
      ),
      new chart.Series<OrdinalBarChart, String>(
        id: 'Kecil',
        domainFn: (OrdinalBarChart value, _) => value.status,
        measureFn: (OrdinalBarChart value, __) => value.value,
        colorFn: (OrdinalBarChart value, __) => value.color,
        data: dataTwo,
      ),
      new chart.Series<OrdinalBarChart, String>(
        id: 'Menengah',
        domainFn: (OrdinalBarChart value, _) => value.status,
        measureFn: (OrdinalBarChart value, __) => value.value,
        colorFn: (OrdinalBarChart value, __) => value.color,
        data: dataThree,
      ),
    ];
  }
}
