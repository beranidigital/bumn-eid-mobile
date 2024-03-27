import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin BarChartDataType {
  double getY();
  int getX();
  Color getColor();
  String getXString() {}
}

class CustomBarChart<T extends BarChartDataType> extends StatelessWidget {
  final double height;
  final double itemWidth;
  final ColorPalette colorPalette;
  final List<T> items;
  final double intervalY;
  final Color backgroundColor;
  final double topPadding;
  final double bottomRotateAngle;
  final double reservedBottomSize;
  final double leftMargin;
  final double bottomMargin;
  final double bottomTextSize;
  final double forcedMaxValue;

  final formatCurrency = new NumberFormat.decimalPattern();

  CustomBarChart({
    this.height = 220.0,
    this.itemWidth = 18,
    this.intervalY = 100.0,
    this.backgroundColor = const Color(0xFFE7F0FF),
    this.topPadding = 50,
    this.bottomRotateAngle = 0,
    this.reservedBottomSize = 8,
    this.leftMargin = 18,
    this.bottomMargin = 16,
    this.bottomTextSize = 14,
    this.forcedMaxValue,
    @required this.colorPalette,
    @required this.items,
  });

  double getMax<T extends BarChartDataType>(List<T> items) {
    return items.reduce((a, b) => (a.getY() > b.getY()) ? a : b).getY();
  }

  BarChartGroupData makeGroupData(T data) {
    final List<BarChartRodData> barRods = [];
    barRods.add(BarChartRodData(
      y: data.getY(),
      color: data.getColor(),
      width: itemWidth,
      borderRadius: BorderRadius.zero,
    ));

    return BarChartGroupData(
      barsSpace: 4,
      x: data.getX(),
      barRods: barRods,
    );
  }

  SideTitles bottomTitles(BuildContext context) {
    return SideTitles(
      showTitles: true,
      textStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: bottomTextSize,
      ),
      margin: bottomMargin,
      rotateAngle: bottomRotateAngle,
      reservedSize: reservedBottomSize,
      getTitles: (double value) {
        return items[value.toInt()].getXString() ??
            items[value.toInt()].getX().toString();
      },
    );
  }

  SideTitles leftTitles(BuildContext context) {
    return SideTitles(
      showTitles: true,
      textStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
      margin: leftMargin,
      reservedSize: 24,
      getTitles: (value) {
        return (value % intervalY == 0)
            ? formatCurrency.format(value.toInt()).replaceAll(",", ".")
            : "";
      },
    );
  }

  FlGridData gridData(BuildContext context) {
    return FlGridData(
      show: true,
      checkToShowHorizontalLine: (value) =>
          (value % intervalY == 0) || value == 1,
      getDrawingHorizontalLine: (value) => FlLine(
        color: colorPalette.mediumGrey,
        strokeWidth: 2,
      ),
    );
  }

  Widget background({@required Widget child}) {
    return Container(
        height: height,
        margin: EdgeInsets.only(top: 16.0),
        decoration: BoxDecoration(
            color: colorPalette.white,
            borderRadius: BorderRadius.circular(4.0)),
        alignment: Alignment.center,
        padding:
            EdgeInsets.only(left: 8.0, right: 32.0, bottom: 32.0, top: 8.0),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    return background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: BarChart(
              BarChartData(
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: bottomTitles(context),
                  leftTitles: leftTitles(context),
                ),
                gridData: gridData(context),
                borderData: FlBorderData(
                  show: false,
                ),
                alignment: BarChartAlignment.spaceAround,
                backgroundColor: backgroundColor,
                maxY: forcedMaxValue ?? getMax(items) + topPadding,
                barGroups: List.generate(
                    items.length, (idx) => makeGroupData(items[idx])),
              ),
            ),
          )
        ],
      ),
    );
  }
}
