import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class Antara extends StatelessWidget {
  List<String> _list = ["satu", "dua", "tiga", "empat", "lima", "enam"];

  List<HorBarChart> _list1 = [];
  List<String> titleTableData = ["No", "Gambar", "Judul & Link Berita"];
  List<String> _listTgl = [
    "1 Des 2020",
    "34 Des 2020",
    "33 Des 2020",
    "1 Des 2022",
    "1 Des 2018",
    "1 Jan 2021"
  ];

  String id;
  Antara({
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
                  title: "LKBN Antara",
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
                        "Pencapaian Situs Web LKBN Antara ?",
                        style: font_poppins(14, FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      DropDownCustom(
                        listValue: _list,
                        onChanged: (value) {},
                        value: "tiga",
                      ),
                      SizedBox(height: 12),
                      Container(
                        decoration: decor,
                        padding: EdgeInsets.only(
                            bottom: 35, top: 10, left: 15, right: 15),
                        child: Column(
                          children: [
                            Text(
                              "Tren Jumlah Tampilan Halaman",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            GraphChartColor(),
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
                              "Tren Jumlah Pengunjung",
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
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: decorationMainContainer,
                  child: Column(
                    children: [
                      Text(
                        "Pencapaian Berita Tentang PEN Dirilis\noleh LKBN Antara",
                        textAlign: TextAlign.center,
                        style: font_poppins(13, FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      DropDownCustom(
                        listValue: _list,
                        value: "empat",
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 10),
                      TableData(title: titleTableData),
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
