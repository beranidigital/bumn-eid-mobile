import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bumn_eid/irwan_dev/pen/controllers/produksi/biofarma_controller.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/font_styles.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/style.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/background_stack.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/stacked_area_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/drop_down_custom.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/header_bumn.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/row_icon_text.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/table_data.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/text_underline_button.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class BioFarma extends StatelessWidget {
  String id;
  BioFarma({
    Key key,
    this.id,
  }) : super(key: key);

  List<String> _list = ["ada", "dua", "tiga", "empat", "lima", "enam"];
  List<String> _title = ["No", "Kelompok Produk (Satuan)", "Stok"];

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
                  title: "Bio Farma",
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
                  child: GetBuilder<BioFarmaController>(
                    init: BioFarmaController(),
                    builder: (controller) {
                      return Column(
                        children: [
                          Text(
                            "Summary",
                            style: font_poppins(14, FontWeight.bold),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              text_underline_button(() {
                                controller.setKondisiSummary(0);
                              }, "Ketersediaan Stok",
                                  (controller.kondisiSummary == 0) ? 1 : 0),
                              text_underline_button(() {
                                controller.setKondisiSummary(1);
                              }, "Kelangsungan Bisnis",
                                  (controller.kondisiSummary == 1) ? 1 : 0),
                            ],
                          ),
                          SizedBox(height: 14),
                          Container(
                            padding:
                                EdgeInsets.only(left: 15, bottom: 10, top: 10),
                            decoration: decor,
                            child: Column(
                              children: [
                                Text(
                                  "Tren Ketersediaan Stok",
                                  style: font_poppins(13, FontWeight.bold),
                                ),
                                StackedAreaChart(),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 10),
                            decoration: decor,
                            child: Column(
                              children: [
                                Text(
                                  "Ketersediaan Stok Berdasarkan Kelompok Produk",
                                  textAlign: TextAlign.center,
                                  style: font_poppins(13, FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                TableData(title: _title),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 10),
                            decoration: decor,
                            child: Column(
                              children: [
                                Text(
                                  "Ketersediaan Stok Berdasarkan Nama Produk",
                                  textAlign: TextAlign.center,
                                  style: font_poppins(13, FontWeight.bold),
                                ),
                                TableData(title: _title),
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
