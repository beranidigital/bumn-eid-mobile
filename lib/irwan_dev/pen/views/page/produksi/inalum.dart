import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bumn_eid/irwan_dev/pen/controllers/produksi/inalum_controller.dart';
import 'package:bumn_eid/irwan_dev/pen/models/hor_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/font_styles.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/style.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/background_stack.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/graph_chart_color.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/horizontal_bar_chart_label.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/line_point_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/numeric_line_point_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/stacked_area_color_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/drop_down_custom.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/header_bumn.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/row_icon_text.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/text_underline_button.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class Inalum extends StatelessWidget {
  String id;
  Inalum({
    Key key,
    this.id,
  }) : super(key: key);

  List<String> _list = ["ada", "dua", "tiga", "empat", "lima", "enam"];
  List<String> _listTgl = [
    "1 Des 2020",
    "34 Des 2020",
    "33 Des 2020",
    "1 Des 2022",
    "1 Des 2018",
    "1 Jan 2021"
  ];

  List<HorBarChart> _list1 = [];

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
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Container(
            child: Column(
              children: [
                HeaderBumn(
                  url:
                      'https://cdn.ayobandung.com/upload/bank_image/medium/polisi-periksa-12-saksi-kasus-pembobolan-bni.jpg',
                  title: "INALUM)",
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
                        "Kinerja Penjualan Inalum",
                        style: font_poppins(14, FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: 34, left: 10, right: 15, top: 10),
                        decoration: decor,
                        child: Column(
                          children: [
                            Text(
                              "Tren Kinerja Penjualan",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            GraphChartColor(),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: decor,
                        child: GetBuilder<InalumController>(
                          init: InalumController(),
                          builder: (controller) {
                            return Column(
                              children: [
                                Text(
                                  "Kinerja Penjualan Berdasarkan",
                                  style: font_poppins(13, FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    text_underline_button(() {
                                      controller.setKondisiKinerja(0);
                                    },
                                        "Produk",
                                        (controller.kondisiKinerja == 0)
                                            ? 1
                                            : 0),
                                    text_underline_button(() {
                                      controller.setKondisiKinerja(1);
                                    },
                                        "Distrik",
                                        (controller.kondisiKinerja == 1)
                                            ? 1
                                            : 0),
                                    text_underline_button(() {
                                      controller.setKondisiKinerja(2);
                                    },
                                        "Kelompok Pelanggan",
                                        (controller.kondisiKinerja == 2)
                                            ? 1
                                            : 0),
                                  ],
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
                        decoration: decor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: GetBuilder<InalumController>(
                          init: InalumController(),
                          builder: (controller) {
                            return Column(
                              children: [
                                Text(
                                  "Tren Berdasarkan",
                                  style: font_poppins(13, FontWeight.bold),
                                ),
                                SizedBox(height: 11),
                                Row(
                                  children: [
                                    text_underline_button(() {
                                      controller.setKondisiTren(0);
                                    }, "Produk",
                                        (controller.kondisiTren == 0) ? 1 : 0),
                                    text_underline_button(() {
                                      controller.setKondisiTren(1);
                                    }, "Kelompok Pelanggan",
                                        (controller.kondisiTren == 1) ? 1 : 0),
                                  ],
                                ),
                                StackedAreaColorChart(),
                              ],
                            );
                          },
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
                        "Harga Komoditas dan Industri",
                        style: font_poppins(14, FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: decor,
                        child: GetBuilder<InalumController>(
                          init: InalumController(),
                          builder: (controller) {
                            return Column(
                              children: [
                                Text(
                                  "Harga Komoditas",
                                  style: font_poppins(13, FontWeight.bold),
                                ),
                                SizedBox(height: 7),
                                Row(
                                  children: [
                                    text_underline_button(() {
                                      controller.setKondisiHarga(0);
                                    }, "Upstream",
                                        (controller.kondisiHarga == 0) ? 1 : 0),
                                    text_underline_button(() {
                                      controller.setKondisiHarga(1);
                                    }, "Downstream",
                                        (controller.kondisiHarga == 1) ? 1 : 0),
                                  ],
                                ),
                                LinePointChart(),
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
                              "Peringkat Harga Komoditas Harga (Rp)",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SizedBox(height: 15),
                            HorizontalBarChartLabel(
                              list: _list1,
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
