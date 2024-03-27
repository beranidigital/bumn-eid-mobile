import 'package:bumn_eid/ui/components/custom_list_bar_chart.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

class SmallBarChartListMenu extends StatelessWidget {

  final ColorPalette colorPalette;
  final String title;
  final Map<String, Color> keyToColor;
  final Map<String, List<ListBarChartDataType>> data;
  final VoidCallback onTap;
  final double legendTextSize;
  final int maxItemToShow;

  SmallBarChartListMenu({
    @required
    this.colorPalette,
    @required
    this.title,
    @required
    this.keyToColor,
    @required
    this.data,
    @required
    this.onTap,
    this.legendTextSize = 6,
    this.maxItemToShow = 4
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: colorPalette.white,
            borderRadius: BorderRadius.circular(8)
        ),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: EdgeInsets.only(top: 16, left: 8, right: 16, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: CustomListBarChart(
                colorPalette: colorPalette,
                keyToColor: keyToColor,
                intervalY: 20,
                data: data,
                chartHeight: 50,
                legendSize: 4,
                legendFontSize: 4,
                chartFontSize: 4,
                chartPadding: 8,
                withBackground: false,
                legendToChartPadding: 4,
                bottomTitlePadding: 4,
                width: 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
