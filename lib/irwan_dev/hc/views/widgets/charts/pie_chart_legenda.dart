import 'package:bumn_eid/irwan_dev/resources/list_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/charts/simple_pie_chart.dart';

enum ModePieChart {
  modeOutline,
  modeBackground,
  modePeriodeOutline,
  modePeriodeBackground
}

class PieChartLegenda extends StatelessWidget {
  List<String> variabel;
  List<int> nilai;
  ModePieChart modePieChart;
  String title;
  Widget listView;
  PieChartLegenda({
    Key key,
    this.variabel,
    this.nilai,
    this.modePieChart,
    this.title,
    this.listView,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (modePieChart) {
      case ModePieChart.modeOutline:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: color_blue, width: 1.5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Text(
                "$title",
                style: font_poppins(15, FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 15),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: variabel.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              color: colorList[index],
                            ),
                            SizedBox(width: 7),
                            Text(
                              "${variabel[index]} : ${nilai[index]}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: SimplePieChart(
                      nilai: nilai,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        break;
      case ModePieChart.modeBackground:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 12),
          decoration: decorBackContainer,
          child: Column(
            children: [
              Text(
                title,
                style: font_poppins(15, FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 15),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: variabel.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 13,
                              height: 13,
                              color: colorList[index],
                            ),
                            SizedBox(width: 7),
                            Text(
                              variabel[index],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SimplePieChart(
                    nilai: nilai,
                  ),
                ],
              ),
            ],
          ),
        );
        break;
      case ModePieChart.modePeriodeOutline:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: color_blue, width: 1.5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Text(
                "$title",
                style: font_poppins(15, FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: listView,
                  ),
                  Expanded(
                    child: SimplePieChart(
                      nilai: nilai,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        break;
      case ModePieChart.modePeriodeBackground:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 12),
          decoration: decorBackContainer,
          child: Column(
            children: [
              Text(
                "$title",
                style: font_poppins(15, FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: listView,
                  ),
                  Expanded(
                    child: SimplePieChart(
                      nilai: nilai,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        break;
    }
  }
}
