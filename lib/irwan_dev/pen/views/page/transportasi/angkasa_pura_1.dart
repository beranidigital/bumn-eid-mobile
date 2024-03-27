import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bumn_eid/irwan_dev/pen/controllers/tranportasi/angkasa_pura_controller.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/font_styles.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/style.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/background_stack.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/graph_chart_color.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/horizontal_stacked_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/drop_down_custom.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/header_bumn.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/legenda_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/row_icon_text.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/text_underline_button.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class AngkasaPura1 extends StatelessWidget {
  String id;
  AngkasaPura1({
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
                  title: "Angkasa Pura 1",
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
                  child: GetBuilder<AngkasaPuraController>(
                    init: AngkasaPuraController(),
                    builder: (controller) {
                      return Column(
                        children: [
                          Text(
                            "Kondisi Lalu Lintas",
                            style: font_poppins(
                              14,
                              FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              text_underline_button(() {
                                controller.setKondisiLintas(0);
                              }, "Pergerakan Pesawat",
                                  (controller.kondisiLintas == 0) ? 1 : 0),
                              text_underline_button(() {
                                controller.setKondisiLintas(1);
                              }, "Penumpang",
                                  (controller.kondisiLintas == 1) ? 1 : 0),
                              text_underline_button(() {
                                controller.setKondisiLintas(2);
                              }, "Kargo",
                                  (controller.kondisiLintas == 2) ? 1 : 0),
                            ],
                          ),
                          SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: DropDownCustom(
                                  listValue: _list,
                                  onChanged: (value) {},
                                  value: "tiga",
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: DropDownCustom(
                                  listValue: _list,
                                  onChanged: (value) {},
                                  value: "empat",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 15, top: 10, bottom: 35),
                            decoration: decor,
                            child: Column(
                              children: [
                                Text(
                                  "Tren Jumlah Pergerakan Pesawat",
                                  style: font_poppins(
                                    13,
                                    FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 14),
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
                                  "Rute Penerbangan Asal",
                                  style: font_poppins(
                                    13,
                                    FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 14),
                                HorizontalStackedChart(),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    legendaChart("Departure", Colors.blue),
                                    legendaChart("Arrival", Colors.red),
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
}
