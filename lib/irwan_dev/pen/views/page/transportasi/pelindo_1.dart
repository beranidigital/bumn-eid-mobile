import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bumn_eid/irwan_dev/pen/controllers/tranportasi/pelindo_controller.dart';
import 'package:bumn_eid/irwan_dev/pen/models/hor_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/font_styles.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/style.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/background_stack.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/graph_chart_color.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/horizontal_bar_chart_label.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/horizontal_stacked_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/drop_down_custom.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/header_bumn.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/row_icon_text.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/text_underline_button.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class Pelindo1 extends StatelessWidget {
  String id;
  Pelindo1({
    Key key,
    this.id,
  }) : super(key: key);
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
                  title: "PT Pelabuhan Indonesia 1",
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
                        "Lalu Lintas di Pelabuhan Indonesia",
                        style: font_poppins(14, FontWeight.bold),
                      ),
                      SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: DropDownCustom(
                              listValue: ["Satuan 1", "satuan 2"],
                              onChanged: (value) {},
                              value: "Satuan 1",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: DropDownCustom(
                              listValue: ["Satuan 1", "satuan 2"],
                              onChanged: (value) {},
                              value: "Satuan 1",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 13),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 15, bottom: 35, top: 10),
                        decoration: decor,
                        child: GetBuilder<PelindoController>(
                          init: PelindoController(),
                          builder: (controller) {
                            return Column(
                              children: [
                                Text(
                                  "Tren Pergerakan",
                                  style: font_poppins(13, FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      text_underline_button(() {
                                        controller.setKondisiPergerakan(0);
                                      },
                                          "Penumpang",
                                          (controller.kondisiPergerakan == 0)
                                              ? 1
                                              : 0),
                                      text_underline_button(() {
                                        controller.setKondisiPergerakan(1);
                                      },
                                          "Kapal",
                                          (controller.kondisiPergerakan == 1)
                                              ? 1
                                              : 0),
                                      text_underline_button(() {
                                        controller.setKondisiPergerakan(2);
                                      },
                                          "Kontainer",
                                          (controller.kondisiPergerakan == 2)
                                              ? 1
                                              : 0),
                                      text_underline_button(() {
                                        controller.setKondisiPergerakan(3);
                                      },
                                          "Non-Kontainer",
                                          (controller.kondisiPergerakan == 3)
                                              ? 1
                                              : 0),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                GraphChartColor(),
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
                        child: GetBuilder<PelindoController>(
                          init: PelindoController(),
                          builder: (controller) {
                            return Column(
                              children: [
                                Text(
                                  "Top 10 Cabang Berdasarkan",
                                  style: font_poppins(13, FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    text_underline_button(() {
                                      controller.setKondisiSummary(0);
                                    },
                                        "Penumpang",
                                        (controller.kondisiSummary == 0)
                                            ? 1
                                            : 0),
                                    text_underline_button(() {
                                      controller.setKondisiSummary(1);
                                    },
                                        "Tonase",
                                        (controller.kondisiSummary == 1)
                                            ? 1
                                            : 0),
                                  ],
                                ),
                                SizedBox(height: 15),
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
                        child: GetBuilder<PelindoController>(
                          init: PelindoController(),
                          builder: (controller) {
                            return Column(
                              children: [
                                Text(
                                  "Jumlah Berdasarkan Cabang",
                                  style: font_poppins(13, FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    text_underline_button(() {
                                      controller.setKondisiCabang(0);
                                    },
                                        "Jumlah GT",
                                        (controller.kondisiCabang == 0)
                                            ? 1
                                            : 0),
                                    text_underline_button(() {
                                      controller.setKondisiCabang(1);
                                    },
                                        "Jumlah Unit",
                                        (controller.kondisiCabang == 1)
                                            ? 1
                                            : 0),
                                    text_underline_button(() {
                                      controller.setKondisiCabang(2);
                                    },
                                        "Jumlah Terus",
                                        (controller.kondisiCabang == 2)
                                            ? 1
                                            : 0),
                                  ],
                                ),
                                SizedBox(height: 15),
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
