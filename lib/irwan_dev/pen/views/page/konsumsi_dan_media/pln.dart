import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/pen/models/hor_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/font_styles.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/style.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/background_stack.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/graph_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/graph_chart_color.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/horizontal_bar_chart_label.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/horizontal_stacked_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/drop_down_custom.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/header_bumn.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/row_icon_text.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class PLN extends StatelessWidget {
  String id;

  List<String> _listTgl = [
    "1 Des 2020",
    "34 Des 2020",
    "33 Des 2020",
    "1 Des 2022",
    "1 Des 2018",
    "1 Jan 2021"
  ];
  List<String> _listProvinsi = [
    "Sulawesi Selatan",
    "Jakarta",
    "Bandung",
    "Maluku",
    "Lombok",
    "Papua"
  ];

  List<String> _kategoriTarif = ["Tunai", "Transfer", "Kredit"];
  List<HorBarChart> _list1 = [];
  PLN({
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
  //       title: Text(
  //         "PEN",
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontFamily: 'Poppins',
  //         ),
  //       ),
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
                  title: "PT Perusahaan Listrik Negara (Persero)",
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
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 1.2,
                        color: Colors.grey,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Pendapatan Pendapatan PLN",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: DropDownCustom(
                              listValue: _listProvinsi,
                              value: "Sulawesi Selatan",
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: DropDownCustom(
                              listValue: _kategoriTarif,
                              value: "Tunai",
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: decor,
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 40,
                          left: 12,
                          right: 17,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Tren Pendapatan Penjualan (kWH)",
                              style: font_poppins(12, FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            GraphChartColor(),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: decor,
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 10),
                        child: Column(
                          children: [
                            Text(
                              "Pendapatan Penjualan Berdasarkan Kelompok Tarif",
                              textAlign: TextAlign.center,
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SizedBox(height: 13),
                            HorizontalBarChartLabel(list: _list1),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: decor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Top 10 Pendapatan Penjualan Berdasarkan Provinsi",
                              textAlign: TextAlign.center,
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SizedBox(height: 13),
                            HorizontalBarChartLabel(list: _list1),
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
