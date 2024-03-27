import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/padi/resources/const.dart';
import 'package:bumn_eid/irwan_dev/padi/models/linear_pie_chart.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/charts/pie_chart_one.dart';
import 'package:charts_flutter/flutter.dart' as chart;

class ItemPieChartTwo extends StatefulWidget {
  final String title;

  ItemPieChartTwo({this.title});
  @override
  _ItemPieChartTwoState createState() => _ItemPieChartTwoState();
}

class _ItemPieChartTwoState extends State<ItemPieChartTwo> {
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
          border: new Border.all(color: secondaryColor, width: 1),
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
                  Tab(text: "UMKM Handle Project"),
                  Tab(text: "UMKM Register"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  new PieChartOne(
                    classLinearSales: [
                      new LinearPieChart("Mikro", new Random().nextInt(100),
                          chart.MaterialPalette.red.shadeDefault),
                      new LinearPieChart("Kecil", new Random().nextInt(100),
                          chart.MaterialPalette.blue.shadeDefault),
                      new LinearPieChart("Menengah", new Random().nextInt(100),
                          chart.MaterialPalette.yellow.shadeDefault),
                    ],
                    width: 20,
                  ),
                  new PieChartOne(
                    classLinearSales: [
                      new LinearPieChart("Mikro", new Random().nextInt(100),
                          chart.MaterialPalette.red.shadeDefault),
                      new LinearPieChart("Kecil", new Random().nextInt(100),
                          chart.MaterialPalette.blue.shadeDefault),
                      new LinearPieChart("Menengah", new Random().nextInt(100),
                          chart.MaterialPalette.yellow.shadeDefault),
                    ],
                    width: 20,
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
