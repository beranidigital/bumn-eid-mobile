import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bumn_eid/irwan_dev/hc/models/hor_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';

class HorizontalBarChartLabel extends StatelessWidget {
  List<HorBarChart> list;
  HorizontalBarChartLabel({
    Key key,
    this.list,
  }) : super(key: key);

  double sizeBar = 30;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: color_bar_chart,
                borderRadius: BorderRadius.circular(6),
              ),
              width:
                  // 100,
                  (Get.width *
                          (list[index].value * 100) /
                          list[index].totalValue) /
                      100,
              height: sizeBar,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(bottom: 8),
              width: Get.width,
              height: sizeBar,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${list[index].title}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(width: 7),
                  Text(
                    // "${list[index].totalValue} (${(list[index].value * 100) / list[index].totalValue}%)",
                    "${list[index].value} (${((list[index].value * 100) / list[index].totalValue).toInt()}%)",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
