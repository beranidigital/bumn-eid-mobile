import 'package:flutter/material.dart';
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
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class JasaMarga extends StatelessWidget {
  String id;
  JasaMarga({
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
                  title: "Jasamarga",
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
                        "Pergerakan Kapal",
                        style: font_poppins(14, FontWeight.bold),
                      ),
                      SizedBox(height: 14),
                      DropDownCustom(
                        listValue: _list,
                        onChanged: (value) {},
                        value: "ada",
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: DropDownCustom(
                              listValue: _list,
                              onChanged: (value) {},
                              value: "ada",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: DropDownCustom(
                              listValue: _list,
                              onChanged: (value) {},
                              value: "ada",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, bottom: 35, top: 10, right: 15),
                        decoration: decor,
                        child: Column(
                          children: [
                            Text(
                              "Tren Kuantitas Penjualan",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SizedBox(height: 15),
                            GraphChartColor(),
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
                              "Kuantitas Penjualan Berdasarkan Perusahaan",
                              style: font_poppins(13, FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            HorizontalBarChartLabel(list: _list1),
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
                              "Kuantitas Penjualan Berdasarkan Komoditas",
                              style: font_poppins(13, FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
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
