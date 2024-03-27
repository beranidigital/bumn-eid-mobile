import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

import 'custom_pie_chart.dart';

class SmallPieChartMenu extends StatelessWidget {

  final ColorPalette colorPalette;
  final String title;
  final Map<String, int> chartData;
  final VoidCallback onTap;
  final double legendTextSize;
  final int maxItemToShow;
  final double textSize;
  final double radius;
  final double centerSpaceRadius;
  final bool withTitle;
  final Map<String, Color> colorMap;
  final bool sortKeys;

  SmallPieChartMenu({
    @required
    this.colorPalette,
    @required
    this.title,
    @required
    this.chartData,
    @required
    this.onTap,
    this.legendTextSize = 6,
    this.maxItemToShow = 4,
    this.textSize = 8,
    this.radius = 16,
    this.centerSpaceRadius = 12,
    this.withTitle = true,
    this.colorMap,
    this.sortKeys = true
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
        ),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: EdgeInsets.only(top: 16, left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            !withTitle ? Container() : Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: CustomPieChart(
                colorPalette: colorPalette,
                tableData: chartData.map((k,v) => MapEntry(k.toString(), [v])),
                customTotalCount: chartData.values.fold(0, (a,b) => a+b),
                customCountFunction: (data) => data?.first ?? 0,
                textSize: textSize,
                radius: radius,
                centerSpaceRadius: centerSpaceRadius,
                chartFlex: 1,
                maxItemToShowLabel: maxItemToShow,
                legendItemPadding: 6,
                legendTextSize: legendTextSize,
                colorMap: colorMap,
                sortKeys: sortKeys,
              ),
            )
          ],
        ),
      ),
    );
  }
}
