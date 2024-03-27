import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/pen/controllers/konsumsi_dan_media/itdc_controller.dart';
import 'package:bumn_eid/irwan_dev/pen/models/hor_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/font_styles.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/style.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/background_stack.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/horizontal_bar_chart_label.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/stacked_area_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/drop_down_custom.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/header_bumn.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/legenda_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/row_icon_text.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/text_underline_button.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class ITDC extends StatelessWidget {
  List<String> _list = ["satu", "dua", "tiga", "empat", "lima", "enam"];

  List<String> _listTgl = [
    "1 Des 2020",
    "34 Des 2020",
    "33 Des 2020",
    "1 Des 2022",
    "1 Des 2018",
    "1 Jan 2021"
  ];

  List<HorBarChart> _list1 = [];

  String id;
  ITDC({
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

  // @override
  // Widget build(BuildContext context) {
  //   _list1 = [];
  //   _list1.add(HorBarChart(title: "Rumah Tangga", value: 70, totalValue: 80));
  //   _list1.add(HorBarChart(title: "Bisnis", value: 30, totalValue: 80));
  //   _list1.add(HorBarChart(title: "Industri", value: 55, totalValue: 80));
  //   _list1.add(HorBarChart(title: "Pemerintahan", value: 20, totalValue: 80));
  //   _list1.add(HorBarChart(title: "Pemerintahan", value: 76, totalValue: 80));
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
                  title: "Indonesia Tourism Development Corporation",
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
                        blurRadius: 2,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Tingkat Okupansi ITDC",
                        style: font_poppins(
                          14,
                          FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: decor,
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 15, top: 10),
                        child: Column(
                          children: [
                            Text(
                              "Tren Tingkat Okupansi",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            StackedAreaChart(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                legendaChart("Data", Colors.blue),
                                legendaChart("Invoice", Colors.red),
                              ],
                            ),
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
                              "Tren Jumlah Pengunjung",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "*Last Month Update",
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                            SizedBox(height: 13),
                            HorizontalBarChartLabel(
                              list: _list1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: decor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Text(
                              "Tren Rata-rata Lama Menginap",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            StackedAreaChart(),
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
                              "Tren Jumlah Pendapatan Per Kategori",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "*Last Month Update",
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                            SizedBox(height: 15),
                            GetBuilder<ITDCController>(
                              init: ITDCController(),
                              builder: (controller) {
                                return Column(
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          text_underline_button(() {
                                            controller.setKKondisiKategori(0);
                                          },
                                              "All",
                                              (controller.kondisiKategori == 0)
                                                  ? 1
                                                  : 0),
                                          text_underline_button(() {
                                            controller.setKKondisiKategori(1);
                                          },
                                              "Kompensasi\nSewa Lahan",
                                              (controller.kondisiKategori == 1)
                                                  ? 1
                                                  : 0),
                                          text_underline_button(() {
                                            controller.setKKondisiKategori(2);
                                          },
                                              "Assesment",
                                              (controller.kondisiKategori == 2)
                                                  ? 1
                                                  : 0),
                                          text_underline_button(() {
                                            controller.setKKondisiKategori(3);
                                          },
                                              "Pengolahan\nLimbah Air",
                                              (controller.kondisiKategori == 3)
                                                  ? 1
                                                  : 0),
                                          text_underline_button(() {
                                            controller.setKKondisiKategori(4);
                                          },
                                              "Lainnya",
                                              (controller.kondisiKategori == 4)
                                                  ? 1
                                                  : 0),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    HorizontalBarChartLabel(
                                      list: _list1,
                                    ),
                                  ],
                                );
                              },
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
