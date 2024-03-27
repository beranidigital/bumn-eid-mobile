import 'package:bumn_eid/irwan_dev/cosmics/controllers/pie_chart_touch.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/summary_jenis_kegiatan.dart';
import 'package:bumn_eid/irwan_dev/cosmics/resources/list_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PieChartTouch extends StatelessWidget {
  List<SummaryJenisKegiatan> dataList;
  PieChartTouch({
    Key key,
    this.dataList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<PieChartTouchController>(
        init: PieChartTouchController(),
        builder: (controller) {
          return Column(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: 1 / 0.55,
                  child: PieChart(
                    PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        if (pieTouchResponse.touchInput is FlLongPressEnd ||
                            pieTouchResponse.touchInput is FlPanEnd) {
                          controller.setTouchIndex(-1);
                        } else {
                          controller.setTouchIndex(
                              pieTouchResponse.touchedSectionIndex);
                        }
                      }),
                      borderData: FlBorderData(show: false),
                      centerSpaceRadius: 40,
                      sectionsSpace: 2,
                      sections: pieChartCustom(controller.touchIndex),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 10,
                    width: 15,
                    color: (controller.touchIndex == null)
                        ? Colors.transparent
                        : (controller.touchIndex == -1)
                            ? Colors.transparent
                            : colorCustom[controller.touchIndex],
                  ),
                  SizedBox(width: 5),
                  Text(
                    (controller.touchIndex == null)
                        ? ""
                        : (controller.touchIndex == -1)
                            ? ""
                            : dataList[controller.touchIndex].jenis_kegiatan,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  List<PieChartSectionData> pieChartCustom(int nil) {
    return List.generate(dataList.length, (index) {
      return PieChartSectionData(
        value: double.parse(dataList[index].total.toString()),
        color: colorCustom[index],
      );
    })
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final isTouched = index == nil;

          final double fontSize = isTouched ? 21 : 15;
          final double radius = isTouched ? 40 : 35;

          final val = PieChartSectionData(
            color: data.color,
            value: data.value,
            radius: radius,
            title: data.value.toString().replaceAll(".0", ""),
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          );
          return MapEntry(index, val);
        })
        .values
        .toList();
  }
}
