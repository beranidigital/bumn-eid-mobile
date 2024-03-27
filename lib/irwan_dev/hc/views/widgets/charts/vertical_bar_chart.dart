import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';

enum ModeBackground { modeOutline, modeBackground }

class VerticalBarChart extends StatelessWidget {
  String judul;
  List<int> nilai;
  List<String> title;
  ModeBackground modeBackground;
  VerticalBarChart({
    Key key,
    this.judul,
    this.nilai,
    this.title,
    this.modeBackground,
  }) : super(key: key);

  var totalNilai = 0;

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < nilai.length; i++) {
      totalNilai += nilai[i];
    }
    switch (modeBackground) {
      case ModeBackground.modeOutline:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: color_blue, width: 1.5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Text(
                "$judul",
                style: font_poppins(15, FontWeight.w600),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  barChart(
                      nilai[0],
                      context,
                      (120 * nilai[0] / ((totalNilai != 0) ? totalNilai : 1))
                          .toDouble(),
                      title[0]),
                  barChart(
                      nilai[1],
                      context,
                      (120 * nilai[1] / ((totalNilai != 0) ? totalNilai : 1))
                          .toDouble(),
                      title[1]),
                  barChart(
                      nilai[2],
                      context,
                      (120 * nilai[2] / ((totalNilai != 0) ? totalNilai : 1))
                          .toDouble(),
                      title[2]),
                  barChart(
                      nilai[3],
                      context,
                      (120 * nilai[3] / ((totalNilai != 0) ? totalNilai : 1))
                          .toDouble(),
                      title[3]),
                ],
              ),
            ],
          ),
        );
        break;
      case ModeBackground.modeBackground:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 12),
          decoration: decorBackContainer,
          child: Column(
            children: [
              Text(
                "$judul",
                style: font_poppins(15, FontWeight.w600),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  barChart(
                      nilai[0],
                      context,
                      (120 * nilai[0] / ((totalNilai != 0) ? totalNilai : 1))
                          .toDouble(),
                      title[0]),
                  barChart(
                      nilai[1],
                      context,
                      (120 * nilai[1] / ((totalNilai != 0) ? totalNilai : 1))
                          .toDouble(),
                      title[1]),
                  barChart(
                      nilai[2],
                      context,
                      (120 * nilai[2] / ((totalNilai != 0) ? totalNilai : 1))
                          .toDouble(),
                      title[2]),
                  barChart(
                      nilai[3],
                      context,
                      (120 * nilai[3] / ((totalNilai != 0) ? totalNilai : 1))
                          .toDouble(),
                      title[3]),
                ],
              ),
            ],
          ),
        );

        break;
    }
  }

  Widget barChart(
      int nilai, BuildContext context, double tinggi, String title) {
    return Expanded(
      flex: 1,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$nilai\n(${(nilai * 100 / ((totalNilai != 0) ? totalNilai : 1)).toStringAsFixed(2)}%)",
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.5,
                fontFamily: 'Poppins',
                fontSize: 12.5,
              ),
            ),
            SizedBox(height: 1),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: tinggi,
              color: color_blue,
            ),
            Text(
              title,
              style: font_poppins(12.5, FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
