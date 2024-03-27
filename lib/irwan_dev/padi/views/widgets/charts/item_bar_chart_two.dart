import 'dart:math';

import 'package:charts_flutter/flutter.dart' as chart;
import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/padi/models/ordinal_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/padi/resources/const.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/charts/bar_chart_two.dart';

class ItemBarChartTwo extends StatefulWidget {
  List<dynamic> listData;
  final String title;

  ItemBarChartTwo({
    Key key,
    this.listData,
    this.title,
  }) : super(key: key);

  @override
  _ItemBarChartTwoState createState() => _ItemBarChartTwoState();
}

class _ItemBarChartTwoState extends State<ItemBarChartTwo> {
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
        border: new Border.all(color: secondaryColor, width: 1),
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
          new BarChartTwo(
            classOrdinalBarChart: [
              // new OrdinalBarChart("Capex 123", new Random().nextInt(100),
              //     chart.MaterialPalette.red.shadeDefault),
              // new OrdinalBarChart("Capex 12", new Random().nextInt(100),
              //     chart.MaterialPalette.blue.shadeDefault),
            ],
          ),
        ],
      ),
    );
  }
}
