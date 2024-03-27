import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin LineChartDataType {
  double getY();
  int getX();
  Color getColor();
}

class CustomLineChart<T extends LineChartDataType> extends StatelessWidget {

  final double height;
  final double itemWidth;
  final ColorPalette colorPalette;
  final List<T> items;
  final double intervalY;
  final Color backgroundColor;
  final double topPadding;
  final double bottomPadding;
  final double leftPadding;

  final formatCurrency = new NumberFormat.decimalPattern();

  CustomLineChart({
    this.height = 220.0,
    this.itemWidth = 2,
    this.intervalY = 100.0,
    this.backgroundColor = const Color(0xFFE7F0FF),
    this.topPadding = 50,
    this.bottomPadding = 100,
    this.leftPadding = 24,
    @required this.colorPalette,
    @required this.items,
  });

  double getMax<T extends LineChartDataType>(List<T> items) {
    return items.reduce((a,b) => (a.getY()>b.getY()) ? a : b).getY();
  }

  List<LineChartBarData> makeGroupData(List<T> data) {
    double count = 0;
    return [LineChartBarData(
      barWidth: itemWidth,
      spots: List.generate(data.length, (idx) {
        return FlSpot(count++, data[idx].getY());
      }),
      dotData: FlDotData(
          dotColor: data.first.getColor(),
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [
          Colors.orange.withOpacity(0.5),
          Colors.orange.withOpacity(0.0),
        ],
        gradientColorStops: [0.5, 1.0],
        gradientFrom: const Offset(0, 0),
        gradientTo: const Offset(0, 1),
        spotsLine: BarAreaSpotsLine(
          show: true,
          flLineStyle: const FlLine(
            color: Colors.blue,
            strokeWidth: 2,
          ),
          checkToShowSpotLine: (spot) => true,
        ),
      ),
    )];
  }

  SideTitles bottomTitles(BuildContext context) {
    return SideTitles(
      showTitles: true,
      textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14),
      reservedSize: 0,
      margin: 16,
      getTitles: (double value) {
        return items[value.toInt()].getX().toString();
      },
    );
  }

  SideTitles leftTitles(BuildContext context) {
    return SideTitles(
      showTitles: true,
      textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14
      ),
      margin: 24,
      reservedSize: leftPadding,
      interval: intervalY,
      getTitles: (value) {
        return formatCurrency.format(value.toInt()).replaceAll(",", ".");
      },
    );
  }

  FlGridData gridData(BuildContext context) {
    return FlGridData(
      show: true,
      checkToShowHorizontalLine: (value) => (value % intervalY == 0) || value == 1,
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
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
                color: colorPalette.mediumGrey,
                width: 2.0
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(2.0, 4.0)
              )
            ]
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 8.0, right: 32.0, bottom: 32.0, top: 8.0),
        child: child
    );
  }

  @override
  Widget build(BuildContext context) {
    return background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: bottomTitles(context),
                  leftTitles: leftTitles(context),
                ),
                gridData: gridData(context),
                borderData: FlBorderData(show: false,),
                backgroundColor: backgroundColor,
                maxY: getMax(items)+topPadding,
                minY: bottomPadding,
                lineBarsData: makeGroupData(items),
              ),
            ),
          )
        ],
      ),
    );
  }
}
