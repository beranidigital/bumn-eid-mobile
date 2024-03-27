import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/hc/models/hor_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/horizontal_bar_chart_label.dart';

class ChartTitle extends StatelessWidget {
  String title;
  List<dynamic> listData;
  // int totalValue;
  ChartTitle({
    Key key,
    this.title,
    this.listData,
    // this.totalValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalValue;
    for (int i = 0; i < listData.length; i++) {
      totalValue += listData[i]['total'].toInt();
    }
    List<HorBarChart> dataList = [];
    for (int i = 0; i < listData.length; i++) {
      dataList.add(
        HorBarChart(
          title: listData[i]['nama'],
          value: listData[i]['total'].toInt(),
          totalValue: totalValue,
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: decorBackContainer,
      child: Column(
        children: [
          Text(
            title,
            style: font_poppins(15, FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          // Text(totalValue.toString()),
          // Text(dataList[0].title),
          // Text("${listData.length} -- $totalValue"),
          SizedBox(height: 15),
          HorizontalBarChartLabel(list: dataList),
        ],
      ),
    );
  }
}
