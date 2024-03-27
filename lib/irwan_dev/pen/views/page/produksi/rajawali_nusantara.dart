import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bumn_eid/irwan_dev/pen/controllers/produksi/rajawali_nusantara_controller.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/font_styles.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/style.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/background_stack.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/dual_horizontal_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/graph_chart_color.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/stacked_area_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/drop_down_custom.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/header_bumn.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/row_icon_text.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/table_data.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/text_underline_button.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class RajawaliNusantaraIndonesia extends StatelessWidget {
  String id;
  RajawaliNusantaraIndonesia({
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
                  title: "Rajawali Nusantara Indonesia",
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
                SizedBox(height: 17),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          row_icon_text(
                              Icons.calendar_today, "Pilih Perusahaan"),
                          SizedBox(height: 7),
                          DropDownCustom(
                            listValue: _list,
                            value: "dua",
                            onChanged: (String value) {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          row_icon_text(Icons.calendar_today, "Pilih Produk"),
                          SizedBox(height: 7),
                          DropDownCustom(
                            listValue: _list,
                            value: "dua",
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
                        "Kinerja Penjualan dan Pembelian",
                        style: font_poppins(
                          14,
                          FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 17),
                      Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 10,
                        ),
                        decoration: decor,
                        child: Column(
                          children: [
                            Text(
                              "Tren Penjualan dan Pembelian",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            StackedAreaChart(),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: decor,
                        padding: EdgeInsets.only(
                            bottom: 10, left: 10, right: 10, top: 10),
                        child: GetBuilder<RajawaliNusantaraController>(
                          init: RajawaliNusantaraController(),
                          builder: (controller) {
                            return Column(
                              children: [
                                Text(
                                  "Penjualan dan Pembelian",
                                  style: font_poppins(
                                    13,
                                    FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    text_underline_button(() {
                                      controller.setKondisiPenjualan(0);
                                    },
                                        "Berdasarkan Perusahaan",
                                        (controller.kondisiPenjualan == 0)
                                            ? 1
                                            : 0),
                                    text_underline_button(() {
                                      controller.setKondisiPenjualan(1);
                                    },
                                        "Grup Produk",
                                        (controller.kondisiPenjualan == 1)
                                            ? 1
                                            : 0),
                                  ],
                                ),
                                DualHorizontalBarChart(),
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
                  child: GetBuilder<RajawaliNusantaraController>(
                    init: RajawaliNusantaraController(),
                    builder: (controller) {
                      return Column(
                        children: [
                          Text(
                            "Ketersediaan dari RNI",
                            style: font_poppins(
                              14,
                              FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              text_underline_button(() {
                                controller.setKondisiKetersediaan(0);
                              },
                                  "Kuantitas",
                                  (controller.kondisiKetersediaan == 0)
                                      ? 1
                                      : 0),
                              text_underline_button(() {
                                controller.setKondisiKetersediaan(1);
                              },
                                  "Nilai",
                                  (controller.kondisiKetersediaan == 1)
                                      ? 1
                                      : 0),
                            ],
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, top: 10, bottom: 35, right: 15),
                            decoration: decor,
                            child: Column(
                              children: [
                                Text(
                                  "Tren",
                                  style: font_poppins(
                                    13,
                                    FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 15),
                                GraphChartColor(),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: decor,
                            child: Column(
                              children: [
                                Text(
                                  "Kuantitas Ketersediaan Berdasarkan Nama Produk",
                                  textAlign: TextAlign.center,
                                  style: font_poppins(
                                    13,
                                    FontWeight.bold,
                                  ),
                                ),
                                TableData(
                                  title: [
                                    "No",
                                    "Nama Produk",
                                    "Kuantitas",
                                    "Unit"
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: decor,
                            child: Column(
                              children: [
                                Text(
                                  "Kuantitas Ketersediaan Berdasarkan Perusahaan",
                                  style: font_poppins(13, FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                TableData(
                                  title: [
                                    "No",
                                    "Perusahaan",
                                    "Produk",
                                    "Kuantitas",
                                    "Unit"
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
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
