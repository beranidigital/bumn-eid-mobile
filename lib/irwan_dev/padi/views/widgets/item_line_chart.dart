import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/padi/resources/const.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/charts/line_chart_one.dart';

class ItemLineChart extends StatefulWidget {
  final String title;

  ItemLineChart({this.title});

  @override
  _ItemLineChartState createState() => _ItemLineChartState();
}

class _ItemLineChartState extends State<ItemLineChart> {
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
                  Tab(text: "Jumlah Project"),
                  Tab(text: "Jumlah Value"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  LineChartOne(),
                  LineChartOne(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
