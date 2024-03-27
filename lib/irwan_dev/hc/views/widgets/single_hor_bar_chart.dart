import 'package:bumn_eid/irwan_dev/hc/models/hor_bar_chart.dart';
import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/horizontal_bar_chart_label.dart';

class SingleHorBarChart extends StatelessWidget {
  final String title;
  final List<HorBarChart> listData;
  const SingleHorBarChart({
    Key key,
    this.title,
    this.listData,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 12),
      decoration: decorBackContainer,
      child: Column(
        children: [
          Text(
            "$title",
            style: font_poppins(15, FontWeight.w600),
          ),
          SizedBox(height: 15),
          HorizontalBarChartLabel(
            list: listData,
          ),
        ],
      ),
    );
  }
}
