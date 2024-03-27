import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/pen/controllers/logistik_dan_pergudangan/bhanda_ghara.dart';
import 'package:bumn_eid/irwan_dev/pen/models/hor_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/font_styles.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/style.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/background_stack.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/dual_horizontal_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/graph_chart_color.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/horizontal_bar_chart_label.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/simple_pie_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/drop_down_custom.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/header_bumn.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/row_icon_text.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/text_underline_button.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class BhandaGhara extends StatelessWidget {
  List<String> _list = ["ada", "dua", "tiga", "empat", "lima", "enam"];

  List<HorBarChart> _list1 = [];

  List<String> _listTgl = [
    "1 Des 2020",
    "34 Des 2020",
    "33 Des 2020",
    "1 Des 2022",
    "1 Des 2018",
    "1 Jan 2021"
  ];

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

  String id;
  BhandaGhara({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _list1 = [];
    _list1.add(HorBarChart(title: "Rumah Tangga", value: 70, totalValue: 80));
    _list1.add(HorBarChart(title: "Bisnis", value: 30, totalValue: 80));
    _list1.add(HorBarChart(title: "Industri", value: 55, totalValue: 80));
    _list1.add(HorBarChart(title: "Pemerintahan", value: 20, totalValue: 80));
    _list1.add(HorBarChart(title: "Pemerintahan", value: 76, totalValue: 80));
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
                  title: "Bhanda Ghara Reksa",
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
                row_icon_text(Icons.ac_unit, "Pilih Komoditas"),
                SizedBox(height: 7),
                DropDownCustom(
                  listValue: ["Satu", "Dua", "Tiga", "Empat", "Lima"],
                  onChanged: (value) {},
                  value: "Tiga",
                ),
                SizedBox(height: 20),
                Container(
                  decoration: decorationMainContainer,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    children: [
                      Text(
                        "Kinerja Bhanda Ghara Reksa",
                        style: font_poppins(14, FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: 35, left: 10, right: 15, top: 10),
                        decoration: decor,
                        child: Column(
                          children: [
                            Text(
                              "Tren Jumlah Perintah Kerja",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SizedBox(height: 15),
                            GraphChartColor(),
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
                              "Jumlah Perintah Kerja Berdasarkan Rute",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            DualHorizontalBarChart(),
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
                              "Top 10 Komditas",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            DualHorizontalBarChart(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: decorationMainContainer,
                  child: Column(
                    children: [
                      Text(
                        "Kinerja Partner dari Bhanda Ghara Reksa",
                        style: font_poppins(14, FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: decor,
                        child: GetBuilder<BhandaGharaController>(
                          init: BhandaGharaController(),
                          builder: (controller) {
                            return Column(
                              children: [
                                Text(
                                  "Stok Komoditas",
                                  style: font_poppins(13, FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      text_underline_button(() {
                                        controller.setKondisiStok(0);
                                      },
                                          "Berdasarkan Gudang",
                                          (controller.kondisiStok == 0)
                                              ? 1
                                              : 0),
                                      text_underline_button(() {
                                        controller.setKondisiStok(1);
                                      },
                                          "Berdasarkan Perusahaan",
                                          (controller.kondisiStok == 1)
                                              ? 1
                                              : 0),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                HorizontalBarChartLabel(
                                  list: _list1,
                                ),
                              ],
                            );
                          },
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
                              "Cold Storage vs Gudang Biasa",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SimplePieChart(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: decorationMainContainer,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    children: [
                      Text(
                        "Kinerja Partner dari Bhanda Ghara Raksa",
                        style: font_poppins(14, FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: 35, left: 10, right: 15, top: 10),
                        decoration: decor,
                        child: Column(
                          children: [
                            Text(
                              "Tren Pendapatan Transaksi",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SizedBox(height: 15),
                            GraphChartColor(),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: decor,
                        child: GetBuilder<BhandaGharaController>(
                          init: BhandaGharaController(),
                          builder: (controller) {
                            return Column(
                              children: [
                                Text(
                                  "Pendapatan Transaksi",
                                  style: font_poppins(13, FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    text_underline_button(() {
                                      controller.setKondisiPendapatan(0);
                                    },
                                        "Berdasarkan Area",
                                        (controller.kondisiPendapatan == 0)
                                            ? 1
                                            : 0),
                                    text_underline_button(() {
                                      controller.setKondisiPendapatan(1);
                                    },
                                        "Berdasarkan Komoditas",
                                        (controller.kondisiPendapatan == 1)
                                            ? 1
                                            : 0),
                                  ],
                                ),
                                SizedBox(height: 13),
                                HorizontalBarChartLabel(
                                  list: _list1,
                                ),
                              ],
                            );
                          },
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
