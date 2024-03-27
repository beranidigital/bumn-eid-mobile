import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/pen/controllers/lembaga_keuangan_bank/bank_controller.dart';
import 'package:bumn_eid/irwan_dev/pen/models/hor_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/font_styles.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/style.dart';
import 'package:bumn_eid/irwan_dev/pen/views/page/lembaga_keungan_bank/bank_bni.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/background_stack.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/graph_chart_color.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/horizontal_bar_chart_label.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/ordinal_combo_bar_line_2.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/drop_down_custom.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/header_bumn.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/row_icon_text.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/text_underline_button.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class BankBTN extends StatelessWidget {
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

  String id;
  BankBTN({
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
                  title: "PT Bank Negara Indonesia",
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
                  child: GetBuilder<BankController>(
                    init: BankController(),
                    builder: (controller) {
                      return Column(
                        children: [
                          Text(
                            "Kondisi Subsidi Bunga",
                            style: font_poppins(14, FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              text_underline_button(() {
                                controller.setKondisiSubsidi(0);
                              }, "Jumlah Rekening",
                                  (controller.kondisiSubsidi == 0) ? 1 : 0),
                              text_underline_button(() {
                                controller.setKondisiSubsidi(1);
                              }, "Jumlah Nominal",
                                  (controller.kondisiSubsidi == 1) ? 1 : 0),
                            ],
                          ),
                          SizedBox(height: 17),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: textContainer(
                                    "Jumlah Rekening", "123432123"),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                flex: 1,
                                child:
                                    textContainer("Rekening KUR", "81273891"),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                flex: 1,
                                child: textContainer(
                                    "Rekening Non-KUR", "341239801"),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: decor,
                            child: Column(
                              children: [
                                Text(
                                  "Tren Subsidi Bunga Berdasarkan Jumlah Rekening",
                                  style: font_poppins(13, FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                OrdinalComboBarLineChart2(),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: decorationMainContainer,
                  child: GetBuilder<BankController>(
                    init: BankController(),
                    builder: (controller) {
                      return Column(
                        children: [
                          Text(
                            "Pencapaian Dana Bantuan PEN PMK",
                            style: font_poppins(14, FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              text_underline_button(() {
                                controller.setKondisiBantuan(0);
                              }, "Jumlah Debitur",
                                  (controller.kondisiBantuan == 0) ? 1 : 0),
                              text_underline_button(() {
                                controller.setKondisiBantuan(1);
                              }, "Jumlah Nominal",
                                  (controller.kondisiBantuan == 1) ? 1 : 0),
                            ],
                          ),
                          SizedBox(height: 17),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: decor,
                            child: Column(
                              children: [
                                Text(
                                  "Tren Pencapaian",
                                  style: font_poppins(13, FontWeight.bold),
                                ),
                                OrdinalComboBarLineChart2(),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            decoration: decor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Realisasi Dana Bantuan per Provinsi",
                                    style: font_poppins(13, FontWeight.bold)),
                                SizedBox(height: 15),
                                HorizontalBarChartLabel(list: _list1),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            decoration: decor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Realisasi Dana Bantuan per Sektor",
                                    style: font_poppins(13, FontWeight.bold)),
                                SizedBox(height: 15),
                                HorizontalBarChartLabel(list: _list1),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: decorationMainContainer,
                  child: Column(
                    children: [
                      Text(
                        "Penempatan Dana Bantuan PEN PMK",
                        style: font_poppins(14, FontWeight.bold),
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
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SizedBox(height: 15),
                            GraphChartColor(),
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
