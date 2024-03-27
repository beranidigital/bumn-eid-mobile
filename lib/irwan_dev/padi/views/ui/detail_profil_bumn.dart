import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/hc/views/widgets/header_bumn.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_table_one.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/text_underline_button.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/expansion_tile_custom.dart';
import 'package:bumn_eid/irwan_dev/padi/controllers/detail_bumn_controller.dart';
import 'package:get/get.dart';
import 'package:bumn_eid/irwan_dev/padi/resources/const.dart';

class DetailProfilBumn extends StatelessWidget {
  final String title;
  final String id;
  const DetailProfilBumn({
    Key key,
    this.title,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Profil BUMN",
      body: (ctx) => mainWidget(context),
    );
  }

  mainWidget(BuildContext context) {
    return Stack(
      children: [
        new Container(
          width: Get.width,
          height: 100,
          color: main_color_background,
        ),
        new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
          children: [
            HeaderBumn(
              title: "PT Bank Negara Indonesia (Persero)",
              url:
                  "https://img2.pngdownload.id/20180819/kta/kisspng-bank-negara-indonesia-logo-bank-bni-syariah-pt-sym-republik-logo-bank-5b7964f437ea15.359053621534682356229.jpg",
            ),
            SizedBox(height: 20),
            GetBuilder<DetailBumnController>(
              id: 'choiceSummary',
              init: DetailBumnController(),
              builder: (controller) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Summary",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                text_underline_button(() {
                                  controller.setChoiceSummary(0);
                                }, "Semua",
                                    (controller.choiceSummary == 0) ? 1 : 0),
                                text_underline_button(() {
                                  controller.setChoiceSummary(1);
                                }, "Eproc",
                                    (controller.choiceSummary == 1) ? 1 : 0),
                                text_underline_button(() {
                                  controller.setChoiceSummary(2);
                                }, "B2B",
                                    (controller.choiceSummary == 2) ? 1 : 0),
                                text_underline_button(() {
                                  controller.setChoiceSummary(3);
                                }, "B2C",
                                    (controller.choiceSummary == 3) ? 1 : 0),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                textBorder2("Jumlah UMKM", "123"),
                                SizedBox(width: 8),
                                textBorder2("UMKM Register", "23"),
                                SizedBox(width: 8),
                                textBorder2("UMKM Handle Project", "100"),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                textBorder("Jumlah\nProvinsi", "20"),
                                SizedBox(width: 8),
                                textBorder("Jumlah\nProject", "1234"),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                textBorder("Jumlah\nTransaksi", "20"),
                                SizedBox(width: 8),
                                textBorder("Value\nTransaksi", "1234"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      ExpansionTileCustom(
                        subtitle: "",
                        title: "Level UMKM By Handle Project",
                        dataColumn: [
                          "No",
                          "Level",
                          "Jumlah UMKM",
                          "Jumlah Nilai"
                        ],
                        dataRow: [
                          new DataRow(
                            cells: [
                              new DataCell(
                                new Text("1"),
                              ),
                              new DataCell(
                                new Text("Mikro"),
                              ),
                              new DataCell(
                                new Text("10 T"),
                              ),
                              new DataCell(
                                new Text("1.200"),
                              ),
                            ],
                          ),
                          new DataRow(
                            cells: [
                              new DataCell(
                                new Text("2"),
                              ),
                              new DataCell(
                                new Text("Kecil"),
                              ),
                              new DataCell(
                                new Text("10 T"),
                              ),
                              new DataCell(
                                new Text("4.400"),
                              ),
                            ],
                          ),
                          new DataRow(
                            cells: [
                              new DataCell(
                                new Text("3"),
                              ),
                              new DataCell(
                                new Text("Menengah"),
                              ),
                              new DataCell(
                                new Text("1 T"),
                              ),
                              new DataCell(
                                new Text("0"),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTileCustom(
                        subtitle: "* Hanya 10 Teratas yang Ditampilkan",
                        title: "Category Project",
                        dataColumn: ["No", "Nama", "Total Value", "UMKM"],
                        dataRow: [
                          new DataRow(
                            cells: [
                              new DataCell(
                                new Text("1"),
                              ),
                              new DataCell(
                                new Text("Mikro"),
                              ),
                              new DataCell(
                                new Text("10 T"),
                              ),
                              new DataCell(
                                new Text("1.200"),
                              ),
                            ],
                          ),
                          new DataRow(
                            cells: [
                              new DataCell(
                                new Text("2"),
                              ),
                              new DataCell(
                                new Text("Kecil"),
                              ),
                              new DataCell(
                                new Text("10 T"),
                              ),
                              new DataCell(
                                new Text("4.400"),
                              ),
                            ],
                          ),
                          new DataRow(
                            cells: [
                              new DataCell(
                                new Text("3"),
                              ),
                              new DataCell(
                                new Text("Menengah"),
                              ),
                              new DataCell(
                                new Text("1 T"),
                              ),
                              new DataCell(
                                new Text("0"),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTileCustom(
                        subtitle: "",
                        title: "Tabulasi Transaksi",
                        dataRow: [
                          new DataRow(
                            cells: [
                              new DataCell(
                                new Text("1"),
                              ),
                              new DataCell(
                                new Text("Mikro"),
                              ),
                              new DataCell(
                                new Text("10 T"),
                              ),
                              new DataCell(
                                new Text("1.200"),
                              ),
                            ],
                          ),
                          new DataRow(
                            cells: [
                              new DataCell(
                                new Text("2"),
                              ),
                              new DataCell(
                                new Text("Kecil"),
                              ),
                              new DataCell(
                                new Text("10 T"),
                              ),
                              new DataCell(
                                new Text("4.400"),
                              ),
                            ],
                          ),
                          new DataRow(
                            cells: [
                              new DataCell(
                                new Text("3"),
                              ),
                              new DataCell(
                                new Text("Menengah"),
                              ),
                              new DataCell(
                                new Text("1 T"),
                              ),
                              new DataCell(
                                new Text("0"),
                              ),
                            ],
                          ),
                        ],
                        dataColumn: [
                          "No",
                          "Bulan",
                          "Jumlah Transaksi",
                          "Jumlah Nilai"
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            // new ItemTableOne(
            //   title: "Level By Handle Project",
            // ),
            // new ItemTableOne(
            //   title: "Category Project",
            // ),
            // new ItemTableOne(
            //   title: "Tabulasi Transaksi",
            // ),
          ],
        ),
      ],
    );
  }

  Widget textBorder(String title, String value) {
    return Expanded(
      flex: 1,
      child: Container(
        constraints: BoxConstraints(
          minHeight: 60,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 6),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textBorder2(String title, String value) {
    return Expanded(
      flex: 1,
      child: Container(
        constraints: BoxConstraints(
          minHeight: 80,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(7),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class DetailProfilBumn extends StatefulWidget {
//   @override
//   _DetailProfilBumnState createState() => _DetailProfilBumnState();
// }

// class _DetailProfilBumnState extends State<DetailProfilBumn> {
//   @override
//   Widget build(BuildContext context) {
//     MediaQueryData mediaQueryData = MediaQuery.of(context);
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text("Profil BUMN"),
//         centerTitle: true,
//       ),
//       body: new SizedBox.expand(
//         child: new Container(
//           width: mediaQueryData.size.width,
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           margin: const EdgeInsets.only(top: 10.0),
//           child: new ListView(
//             children: [
//               new ItemTableOne(
//                 title: "Level By Handle Project",
//               ),
//               new ItemTableOne(
//                 title: "Category Project",
//               ),
//               new ItemTableOne(
//                 title: "Tabulasi Transaksi",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
