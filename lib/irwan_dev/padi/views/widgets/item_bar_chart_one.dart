import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/padi/resources/const.dart';
import 'package:bumn_eid/irwan_dev/padi/models/ordinal_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/charts/bar_chart_one.dart';

import 'package:charts_flutter/flutter.dart' as chart;

class ItemBarChartOne extends StatefulWidget {
  final String title;

  ItemBarChartOne({this.title});
  @override
  _ItemBarChartOneState createState() => _ItemBarChartOneState();
}

class _ItemBarChartOneState extends State<ItemBarChartOne> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return new DefaultTabController(
      length: 2,
      child: new Container(
        width: mediaQueryData.size.width,
        height: 250,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(top: 10.0, left: 12, right: 12),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: new Border.all(color: secondaryColor, width: 1.5),
        ),
        child: new Column(
          children: [
            new Text(
              widget.title,
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
            new Align(
              alignment: Alignment.centerLeft,
              child: new TabBar(
                labelStyle: new TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
                isScrollable: true,
                unselectedLabelColor: Colors.black,
                labelPadding: EdgeInsets.symmetric(horizontal: 3.0),
                labelColor: secondaryColor,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                tabs: [
                  Tab(text: "Nominal Transaksi"),
                  Tab(text: "Jumlah Transaksi"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  BarChartOne(
                    classOrdinalBarChart: [
                      new OrdinalBarChart(
                          "Mikro", 4, chart.MaterialPalette.red.shadeDefault),
                      new OrdinalBarChart(
                          "Kecil", 10, chart.MaterialPalette.blue.shadeDefault),
                      new OrdinalBarChart("Menengah", 20,
                          chart.MaterialPalette.yellow.shadeDefault)
                    ],
                  ),
                  BarChartOne(
                    classOrdinalBarChart: [
                      new OrdinalBarChart(
                          "Mikro", 4, chart.MaterialPalette.red.shadeDefault),
                      new OrdinalBarChart(
                          "Kecil", 10, chart.MaterialPalette.blue.shadeDefault),
                      new OrdinalBarChart("Menengah", 20,
                          chart.MaterialPalette.yellow.shadeDefault)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
