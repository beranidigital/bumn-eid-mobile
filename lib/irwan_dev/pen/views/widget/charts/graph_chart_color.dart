import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GraphChartColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 0.0;
    const yearTextStyle = TextStyle(
        fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold);

    return Container(
      width: Get.width,
      height: 120,
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(
            border: Border(
              top: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
              right: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
              bottom: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            ),
          ),
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 0),
                FlSpot(1, 10),
                FlSpot(2, 20),
                FlSpot(3, 30),
                FlSpot(4, 10),
                FlSpot(5, 20),
                FlSpot(6, 30),
                FlSpot(7, 10),
                FlSpot(8, 20),
                FlSpot(9, 20),
              ],
              isCurved: false,
              barWidth: 1,
              colors: [
                Colors.blue,
              ],
              belowBarData: BarAreaData(
                show: true,
                // gradientFrom: Offset(1, 1),
                gradientTo: Offset(0, 2),
                colors: [
                  Colors.lightBlue,
                  Colors.lightBlue.withOpacity(0.1),
                ],
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              // aboveBarData: BarAreaData(
              //   show: true,
              //   colors: [
              //     Colors.red.withOpacity(0.6),
              //   ],
              //   cutOffY: cutOffYValue,
              //   applyCutOffY: true,
              // ),
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
          minY: 0,
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
                showTitles: true,
                rotateAngle: 310,
                reservedSize: 6,
                // textStyle: yearTextStyle,
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'Jun 20';
                    case 1:
                      return 'Feb 20';
                    case 2:
                      return 'Mar 20';
                    case 3:
                      return 'Apr 20';
                    case 4:
                      return 'Mei 20';
                    case 5:
                      return 'Jun 20';
                    case 6:
                      return 'Jul 20';
                    case 7:
                      return 'Aug 20';
                    case 8:
                      return 'Sep 20';
                    case 9:
                      return 'Aug 20';
                    default:
                      return '';
                  }
                }),
            leftTitles: SideTitles(
              showTitles: true,
              interval: 10,
              getTitles: (value) {
                return '${value.toInt()} Rb';
              },
            ),
          ),
          // axisTitleData: FlAxisTitleData(
          // leftTitle:
          //     AxisTitle(showTitle: true, titleText: 'Value', margin: 10),
          // bottomTitle: AxisTitle(
          //     showTitle: true,
          //     margin: 10,
          //     titleText: 'Year',
          //     textStyle: yearTextStyle,
          //     textAlign: TextAlign.right)),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 10,
            // checkToShowHorizontalLine: (double value) {
            //   return value == 1 ||
            //       value == 2 ||
            //       value == 3 ||
            //       value == 4 ||
            //       value == 5;
            // },
          ),
        ),
      ),
    );
  }
}
