import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/font_styles.dart';
import 'package:bumn_eid/irwan_dev/pen/resources/style.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/background_stack.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/dual_horizontal_bar_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/stacked_area_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/charts/stacked_area_color_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/drop_down_custom.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/header_bumn.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/legenda_chart.dart';
import 'package:bumn_eid/irwan_dev/pen/views/widget/row_icon_text.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class KeretaApi extends StatelessWidget {
  String id;
  KeretaApi({
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
                  title: "Kereta Api Indonesia",
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
                      SizedBox(height: 15),
                      DropDownCustom(
                        listValue: ["Stasiun 1", "Stasiun 2", "Stasiun 3"],
                        onChanged: (value) {},
                        value: "Stasiun 1",
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 10),
                        decoration: decor,
                        child: Column(
                          children: [
                            Text(
                              "Tren Jumlah Penumpang dan Jumlah Kargo",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            SizedBox(height: 10),
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
                              "Jumlah Penumpang Berdasarkan Provinsi",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            DualHorizontalBarChart(),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                legendaChart("Bagian 3", Colors.blue),
                                legendaChart("Origin", Colors.red),
                              ],
                            ),
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
                              "Jumlah Penumpang Berdasarkan Stasiun",
                              style: font_poppins(13, FontWeight.bold),
                            ),
                            DualHorizontalBarChart(),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                legendaChart("Bagian 3", Colors.blue),
                                legendaChart("Origin", Colors.red),
                              ],
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
