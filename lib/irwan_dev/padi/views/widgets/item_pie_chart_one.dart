import 'dart:math';

import 'package:charts_flutter/flutter.dart' as chart;
import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/padi/models/linear_pie_chart.dart';
import 'package:bumn_eid/irwan_dev/padi/resources/const.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/charts/pie_chart_one.dart';

class ItemPieChartOne extends StatefulWidget {
  List<dynamic> list_data;
  final String title;

  ItemPieChartOne({
    Key key,
    this.list_data,
    this.title,
  }) : super(key: key);
  @override
  _ItemPieChartOneState createState() => _ItemPieChartOneState();
}

class _ItemPieChartOneState extends State<ItemPieChartOne> {
  int touchedIndex;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return new Container(
      width: mediaQueryData.size.width,
      height: 270,
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
          new SizedBox(
            height: 10.0,
          ),
          new PieChartOne(
            classLinearSales: [
              new LinearPieChart(
                  "${widget.list_data[0]['type_project_value']}",
                  int.parse(widget.list_data[0]['total'].toString()),
                  chart.MaterialPalette.red.shadeDefault),
              new LinearPieChart(
                  "${widget.list_data[1]['type_project_value']}",
                  int.parse(widget.list_data[1]['total'].toString()),
                  chart.MaterialPalette.blue.shadeDefault),
            ],
          ),
        ],
      ),
    );
  }
}
