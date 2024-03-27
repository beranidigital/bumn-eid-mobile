import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/pen/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/font_styles.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/style.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/background_stack.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/line_point_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/ordinal_combo_bar_line.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/ordinal_combo_bar_line_2.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/drop_down_custom.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/header_bumn.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/row_icon_text.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class TelkomIndonesia extends StatelessWidget {
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
  TelkomIndonesia({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "PEN",
      body: (ctx) => mainWidget(context),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("PEN"),
  //       elevation: 0,
  //       centerTitle: true,
  //       backgroundColor: color_background,
  //     ),
  //     body:
  //   );
  // }

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
                  title: "PT Telkom Indonesia (Persero)",
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: Offset(0, 3),
                        spreadRadius: 1,
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Rata-rata Arpu per Pelanggan dari Telkom dan Telkomsel",
                        textAlign: TextAlign.center,
                        style: font_poppins(14, FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: decor,
                        padding: EdgeInsets.only(
                            top: 10, bottom: 15, left: 10, right: 10),
                        child: Column(
                          children: [
                            Text(
                              "Tren Arpu Telkom dan Telkomsel",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SizedBox(height: 6),
                            OrdinalComboBarLineChart(),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 20,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(width: 5),
                                    Text("Prepaid"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 20,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 5),
                                    Text("Postpaid"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: decor,
                        padding: EdgeInsets.only(
                            top: 10, bottom: 15, left: 10, right: 10),
                        child: Column(
                          children: [
                            Text(
                              "Tren Pendapatan Penjualan (kWH)",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 20,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(width: 5),
                                    Text("Data"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 20,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 5),
                                    Text("Voice"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 20,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 5),
                                    Text("Sms"),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            LinePointChart(),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: 15, top: 10, left: 10, right: 10),
                        decoration: decor,
                        child: Column(
                          children: [
                            Text(
                              "Tren Arpu Telkomsel Berdasarkan Metode Pembayaran",
                              textAlign: TextAlign.center,
                              style: font_poppins(
                                13,
                                FontWeight.bold,
                              ),
                            ),
                            OrdinalComboBarLineChart(),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 20,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(width: 5),
                                    Text("Prepaid"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 20,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 5),
                                    Text("Postpaid"),
                                  ],
                                ),
                              ],
                            ),
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
