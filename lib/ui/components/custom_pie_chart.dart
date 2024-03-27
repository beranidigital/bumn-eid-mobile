import 'package:bumn_eid/ui/components/indicator.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:bumn_eid/ui/utils/new_color_palette.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart<T> extends StatefulWidget {
  final Map<String, List<T>> tableData;
  final ColorPalette colorPalette;
  final int maxItemToShowLabel;
  final int customTotalCount;
  final int Function(List<T>) customCountFunction;
  final double textSize;
  final double legendTextSize;
  final double radius;
  final double centerSpaceRadius;
  final int chartFlex;
  final double legendItemPadding;
  final Map<String, Color> colorMap;
  final bool sortKeys;

  CustomPieChart({
    @required this.tableData,
    @required this.colorPalette,
    this.maxItemToShowLabel = 6,
    this.customTotalCount,
    this.customCountFunction,
    this.textSize = 16,
    this.radius = 50,
    this.centerSpaceRadius = 40,
    this.chartFlex = 2,
    this.legendItemPadding = 16,
    this.legendTextSize,
    this.colorMap,
    this.sortKeys = true,
  });

  @override
  _CustomPieChartState<T> createState() => _CustomPieChartState<T>();
}

class _CustomPieChartState<T> extends State<CustomPieChart> {
  int touchedIndex;
  Map<String, Color> keyToColor = {};
  List<String> sortedKeys = List();

  void prepareData() {
    final colorMap = widget.colorMap ??
        categorizeToColor<String>(widget.tableData.keys
            .toList()); // we need to assign color to each key

    List<String> sortedKeys = widget.tableData.keys.toList()
      ..sort(
        (a, b) {
          if (widget.customCountFunction != null) {
            final bSum =
                widget.tableData[b] == null || widget.tableData[b].isEmpty
                    ? 0
                    : widget.customCountFunction(widget.tableData[b]);
            final aSum =
                widget.tableData[a] == null || widget.tableData[a].isEmpty
                    ? 0
                    : widget.customCountFunction(widget.tableData[a]);
            return bSum.compareTo(aSum);
          } else {
            final bLength = widget.tableData[b]?.length ?? 0;
            final aLength = widget.tableData[a]?.length ?? 0;
            return bLength.compareTo(aLength);
          }
        },
      );

    setState(() {
      this.keyToColor = colorMap;
      this.sortedKeys = sortedKeys;
    });
  }

  bool isDataReady() {
    return keyToColor.isNotEmpty &&
        widget.tableData != null &&
        sortedKeys.isNotEmpty;
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(sortedKeys.length, (i) {
      final companyCount = widget.customCountFunction != null
          ? widget.customCountFunction(widget.tableData[sortedKeys[i]])
          : widget.tableData[sortedKeys[i]].length;
      final totalCount = widget.customTotalCount ??
          widget.tableData.values.fold<int>(0, (t, e) => t + e.length);
      double percentage = 0.0;
      if (companyCount != 0 && totalCount != 0) {
        percentage = ((companyCount / totalCount) * 100).roundToDouble();
      }
      print(sortedKeys[i] + "  " + sortedKeys.length.toString());
      return PieChartSectionData(
        // color: keyToColor[sortedKeys[i]],
        color: sortedKeys.length == 2
            ? color2Warna[i]
            : sortedKeys.length == 3
                ? color3Warna[i]
                : sortedKeys.length == 4
                    ? color4Warna[i]
                    : sortedKeys.length == 5
                        ? color5Warna[i]
                        : sortedKeys.length == 6
                            ? color6Warna[i]
                            : sortedKeys.length == 7
                                ? color7Warna[i]
                                : sortedKeys.length == 8
                                    ? color8Warna[i]
                                    : sortedKeys.length == 9
                                        ? color9Warna[i]
                                        : color10Warna[i],
        value: percentage,
        title: "${percentage.toInt()}%",
        showTitle: i >= widget.maxItemToShowLabel ? false : true,
        radius: 65,
        titleStyle: TextStyle(
          fontSize: widget.textSize,
          fontWeight: FontWeight.w500,
          fontFamily: 'poppins',
          color: const Color(0xffffffff),
        ),
      );
    });
  }

  Widget mainWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              children: List.generate(
                widget.sortKeys
                    ? sortedKeys.length
                    : widget.tableData.keys.length,
                (idx) {
                  if (idx >= widget.maxItemToShowLabel) return Container();
                  // return Text("${idx}");
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: widget.legendItemPadding,
                    ),
                    child: Indicator(
                      color: sortedKeys.length == 2
                          ? color2Warna[idx]
                          : sortedKeys.length == 3
                              ? color3Warna[idx]
                              : sortedKeys.length == 4
                                  ? color4Warna[idx]
                                  : sortedKeys.length == 5
                                      ? color5Warna[idx]
                                      : sortedKeys.length == 6
                                          ? color6Warna[idx]
                                          : sortedKeys.length == 7
                                              ? color7Warna[idx]
                                              : sortedKeys.length == 8
                                                  ? color8Warna[idx]
                                                  : sortedKeys.length == 9
                                                      ? color9Warna[idx]
                                                      : color10Warna[idx],
                      // widget.sortKeys
                      // ? keyToColor[sortedKeys[idx]]
                      // : keyToColor[widget.tableData.keys.toList()[idx]],
                      text: widget.sortKeys
                          ? sortedKeys[idx]
                          : widget.tableData.keys.toList()[idx],
                      size: widget.textSize,
                      fontSize: widget.legendTextSize,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Flexible(
          flex: widget.chartFlex,
          child: AspectRatio(
            aspectRatio: isSmallDevice(context) ? 1.2 : 1.0,
            child: PieChart(
              PieChartData(
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 2,
                centerSpaceRadius: 0.0,
                sections: showingSections(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    prepareData();
    return isDataReady()
        ? mainWidget(context)
        : LoadingWidget(
            colorPalette: widget.colorPalette,
          );
  }
}
