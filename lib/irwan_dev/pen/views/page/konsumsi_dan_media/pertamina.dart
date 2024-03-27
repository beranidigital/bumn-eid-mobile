import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/pen/controllers/konsumsi_dan_media/pertamina_controller.dart';
import 'package:bumn_eid/irwan_dev/pen/models/hor_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/font_styles.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/style.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/background_stack.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/graph_chart_color.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/horizontal_bar_chart_label.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/drop_down_custom.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/header_bumn.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/row_icon_text.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/table_data.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/text_underline_button.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class Pertamina extends StatelessWidget {
  List<String> _list = ["satu", "dua", "tiga", "empat", "lima", "enam"];

  List<String> _listTgl = [
    "1 Des 2020",
    "34 Des 2020",
    "33 Des 2020",
    "1 Des 2022",
    "1 Des 2018",
    "1 Jan 2021"
  ];

  List<String> titleTableData = ["No", "Level", "Total Production", "Unit"];
  List<HorBarChart> _list1 = [];

  String id;
  Pertamina({
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
  //   _list1.add(HorBarChart(title: "Rumah Tangga", value: 70, totalValue: 80));
  //   _list1.add(HorBarChart(title: "Bisnis", value: 30, totalValue: 80));
  //   _list1.add(HorBarChart(title: "Industri", value: 55, totalValue: 80));
  //   _list1.add(HorBarChart(title: "Pemerintahan", value: 20, totalValue: 80));
  //   _list1.add(HorBarChart(title: "Pemerintahan", value: 76, totalValue: 80));
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

  Widget kategoriProduksi() {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: decor,
            padding: EdgeInsets.only(
              top: 10,
              bottom: 35,
              left: 15,
              right: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Tren Produksi Oil dan Gas",
                  style: font_poppins(13, FontWeight.bold),
                ),
                SizedBox(height: 17),
                GraphChartColor(),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 10,
              right: 10,
            ),
            decoration: decor,
            child: Column(
              children: [
                Text(
                  "Produksi Oil dan Gas Berdasarkan Perusahaan MBOEPD",
                  style: font_poppins(13, FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text(
                  "*Last Mont Update",
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 15),
                HorizontalBarChartLabel(
                  list: _list1,
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            decoration: decor,
            child: Column(
              children: [
                Text(
                  "Produksi Oil dan Gas Berdasarkan Produk",
                  style: font_poppins(13, FontWeight.bold),
                ),
                SizedBox(height: 7),
                Text(
                  "*Last Month Update",
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 11),
                TableData(title: titleTableData),
              ],
            ),
          ),
        ],
      ),
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
                  title: "PT Pertamina (Persero)",
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
                        "Kinerja Pertamina",
                        style: font_poppins(13, FontWeight.bold),
                      ),
                      SizedBox(height: 13),
                      GetBuilder<PertaminaController>(
                        init: PertaminaController(),
                        builder: (controller) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  text_underline_button(() {
                                    controller.setNilaiAwal(0);
                                  }, "Produksi",
                                      (controller.nilaiAwal == 0) ? 1 : 0),
                                  text_underline_button(() {
                                    controller.setNilaiAwal(1);
                                  }, "Lifting",
                                      (controller.nilaiAwal == 1) ? 1 : 0),
                                  Material(
                                    child: InkWell(
                                      child: text_underline_button(() {
                                        controller.setNilaiAwal(2);
                                      }, "Penjualan",
                                          (controller.nilaiAwal == 2) ? 1 : 0),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 13),
                              kategoriProduksi(),
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
        ),
      ],
    );
  }
}
