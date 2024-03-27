import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class SumTypeText extends StatelessWidget {
  final ColorPalette colorPalette;
  final String sumText;
  final num sum;
  final String sumNotNumber;
  final Color sumColor;
  final bool percentage;
  final bool isCentered;
  final double headerTextSize;

  SumTypeText({
    this.sumText = "Jumlah",
    @required this.sum,
    @required this.colorPalette,
    this.sumColor,
    this.percentage = false,
    this.isCentered = false,
    this.sumNotNumber,
    this.headerTextSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisAlignment:
            isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            sumText,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'poppins',
              color: colorPalette.softerPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            sumNotNumber != null
                ? sumNotNumber
                : percentage
                    ? "${formatNumber(sum)} %"
                    : formatNumber(sum),
            style: TextStyle(
              color: sumColor ?? colorPalette.gold,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
