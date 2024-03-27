import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

mixin ListBarChartDataType {
  double getY();
  int getX();
  String getColorKey();
}

class CustomListBarChart<T extends ListBarChartDataType> extends StatefulWidget {

  final Map<String, List<T>> data;
  final double width;
  final double chartHeight;
  final ColorPalette colorPalette;
  final double intervalY;
  final Color backgroundColor;
  final double topPadding;
  final double leftPadding;
  final double barSpace;
  final Map<String, Color> keyToColor;
  final double bottomRotateAngle;
  final double reservedBottomSize;
  final double legendSize;
  final double legendFontSize;
  final double chartFontSize;
  final double chartPadding;
  final bool withBackground;
  final double legendToChartPadding;
  final double bottomTitlePadding;

  CustomListBarChart({
    @required
     this.data,
    @required
    this.colorPalette,
    this.width = 10.0,
    this.chartHeight = 220.0,
    this.intervalY = 100.0,
    this.backgroundColor = const Color(0xFFE7F0FF),
    this.topPadding = 10,
    this.leftPadding = 16,
    this.barSpace = 4,
    this.keyToColor,
    this.bottomRotateAngle = 0,
    this.reservedBottomSize = 8,
    this.legendSize = 10,
    this.legendFontSize = 12,
    this.chartFontSize = 14,
    this.chartPadding = 32,
    this.withBackground = true,
    this.legendToChartPadding = 8,
    this.bottomTitlePadding = 16
  });

  @override
  _CustomListBarChartState<T> createState() => _CustomListBarChartState<T>();
}

class _CustomListBarChartState<T extends ListBarChartDataType> extends State<CustomListBarChart>
    with AfterLayoutMixin<CustomListBarChart> {

  Map<String, Color> generatedKeyToColor;

  @override
  void afterFirstLayout(BuildContext context) {
    prepareData();
  }

  bool isDataReady() {
    return (widget.keyToColor != null || generatedKeyToColor != null) && widget.data != null;
  }

  void prepareData() {
    if (widget.keyToColor != null) return;
    final sampleData = widget.data.values.first;
    final colorMap = categorizeToColor<String>(sampleData.map((a)=>a.getColorKey()).toList()); // we need to assign color to each key

    setState(() {
      this.generatedKeyToColor = colorMap;
    });
  }

  double getMax<T extends ListBarChartDataType>(List<T> items) {
    return items.reduce((a,b) => (a.getY()>b.getY()) ? a : b).getY();
  }

  Widget legendYear(BuildContext context, String colorKey) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            height: widget.legendSize,
            width: widget.legendSize,
            margin: EdgeInsets.only(right: 8.0),
            decoration: BoxDecoration(
                color: widget.keyToColor != null ? widget.keyToColor[colorKey] : generatedKeyToColor[colorKey]
            ),
          ),
          Text(
            colorKey,
            style: TextStyle(
                color: widget.colorPalette.black,
                fontWeight: FontWeight.w700,
                fontSize: widget.legendFontSize
            ),
          )
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData({@required String type, @required List<T> data}) {
    final List<BarChartRodData> barRods = [];
    for (var value in data) {
      barRods.add(
          BarChartRodData(
            y: value.getY(),
            color: widget.keyToColor != null ? widget.keyToColor[value.getColorKey()] : generatedKeyToColor[value.getColorKey()],
            width: widget.width,
            borderRadius: BorderRadius.zero,
          )
      );
    }

    return BarChartGroupData(
      barsSpace: widget.barSpace,
      x: type.hashCode,
      barRods: barRods,
    );
  }

  Widget background({@required Widget child}) {
    return Container(
      height: widget.chartHeight,
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
          color: widget.colorPalette.white,
          borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.only(left: 8.0, right: widget.chartPadding, bottom: widget.chartPadding, top: 8.0),
      child: child,
    );
  }

  Widget legends(BuildContext context) {
    return Row(
      children: widget.data.values.first.map((data) => legendYear(context, data.getColorKey())).toList(),
    );
  }

  SideTitles bottomTitles(BuildContext context) {
    return SideTitles(
      showTitles: true,
      textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: widget.chartFontSize
      ),
      rotateAngle: widget.bottomRotateAngle,
      reservedSize: widget.reservedBottomSize,
      margin: widget.bottomTitlePadding,
      getTitles: (double value) => parseStringForChart(widget.data.keys.toList()[value.toInt()]),
    );
  }

  SideTitles leftTitles(BuildContext context) {
    return SideTitles(
      showTitles: true,
      textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: widget.chartFontSize
      ),
      margin: 8,
      reservedSize: widget.leftPadding,
      getTitles: (value) {
        return (value % widget.intervalY == 0) ? value.toInt().toString() : "";
      },
    );
  }

  FlGridData gridData(BuildContext context) {
    return FlGridData(
      show: true,
      checkToShowHorizontalLine: (value) => (value % widget.intervalY == 0),
      getDrawingHorizontalLine: (value) => FlLine(
        color: widget.colorPalette.mediumGrey,
        strokeWidth: 1,
      ),
    );
  }

  Widget chart(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          enabled: false,
        ),
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
        backgroundColor: widget.backgroundColor,
        maxY: getMax(widget.data.values.expand((a)=>a).toList())+widget.topPadding,
        barGroups: List.generate(widget.data.keys.length, (idx)
                          => makeGroupData(
                              type: widget.data.keys.toList()[idx],
                              data: widget.data[widget.data.keys.toList()[idx]]
                          )),
      ),
    );
  }

  Widget chartWidget(BuildContext context) {
    return background(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 16.0),
            child: legends(context),
          ),
          Expanded(
            child: chart(context),
          )
        ],
      ),
    );
  }

  Widget chartWidgetWithoutBg(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: widget.legendToChartPadding, left: 16.0),
            child: legends(context),
          ),
          Expanded(
            child: chart(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isDataReady()
        ? widget.withBackground
            ? chartWidget(context)
            : chartWidgetWithoutBg(context)
        : LoadingWidget(colorPalette: widget.colorPalette,);
  }
}
