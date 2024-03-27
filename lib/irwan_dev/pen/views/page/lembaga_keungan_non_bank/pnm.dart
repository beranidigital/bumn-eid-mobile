import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/pen/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/font_styles.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/style.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/background_stack.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/four_horizontal_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/line_point_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/ordinal_combo_bar_line.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/drop_down_custom.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/header_bumn.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/row_icon_text.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class PNM extends StatelessWidget {
  List<String> _list = ["ada", "dua", "tiga", "empat", "lima", "enam"];

  List<String> _listTgl = [
    "1 Des 2020",
    "34 Des 2020",
    "33 Des 2020",
    "1 Des 2022",
    "1 Des 2018",
    "1 Jan 2021"
  ];

  String id;
  PNM({
    Key key,
    this.id,
  }) : super(key: key);
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("PEN"),
  //       backgroundColor: color_background,
  //       elevation: 0,
  //       centerTitle: true,
  //     ),
  //     body:
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "PEN",
      body: (ctx) => mainWidget(context),
    );
  }

  mainWidget(BuildContext context) {
    return Stack(
      children: [
        BackgroundStack(),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              children: [
                HeaderBumn(
                  url:
                      'https://cdn.ayobandung.com/upload/bank_image/medium/polisi-periksa-12-saksi-kasus-pembobolan-bni.jpg',
                  title: "Permodalan Nasional Madani",
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          row_icon_text(Icons.calendar_today, "Tanggal Awal"),
                          SizedBox(height: 7),
                          DropDownCustom(
                            listValue: _listTgl,
                            value: "1 Des 2022",
                            onChanged: (String value) {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          row_icon_text(Icons.calendar_today, "Tanggal Akhir"),
                          SizedBox(height: 7),
                          DropDownCustom(
                            listValue: _listTgl,
                            value: "33 Des 2020",
                            onChanged: (String value) {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: decorationMainContainer,
                  child: Column(
                    children: [
                      Text(
                        "Pertumbuhan Pelanggan dan Outstanding Loan",
                        style: font_poppins(14, FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: decor,
                        child: Column(
                          children: [
                            Text(
                              "Tren Jumlah Pelaksanaan dan Jumlah Outstanding Loan",
                              style: font_poppins(13, FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            OrdinalComboBarLineChart(),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: decor,
                        child: Column(
                          children: [
                            Text(
                              "Jumlah Pelanggan Berdasarkan Jenis Layanan",
                              style: font_poppins(13, FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            FourHorizontalBarChart(),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: decor,
                        child: Column(
                          children: [
                            Text(
                              "Jumlah Outstanding Loan Berdasarkan\nJenis Layanan",
                              style: font_poppins(13, FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            LinePointChart(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
