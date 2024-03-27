import 'package:bumn_eid/irwan_dev/hc/models/profil_detail_detail_bumn.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/expansion_tile_3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/cosmics/api/list_api.dart';
import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/controllers/perusahaan/main_perusahaan_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/models/detail_bumn_talent.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/perusahaan/main_perusahaan.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/expansion_tile_1.dart';

class DetailDetailPerusahaan extends StatelessWidget {
  final String idBUMN;
  const DetailDetailPerusahaan({
    Key key,
    this.idBUMN,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<DetailProfilBUMN>(
        future: ListApiHC().getDetailBUMNProfiles(idBUMN),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var hasil = snapshot.data;
            return Column(
              children: [
                // Text(
                //   "Detail Perusahaan",
                //   style: font_poppins(15, FontWeight.w600),
                // ),
                (hasil.relasi_perusahaan.level_perusahaan == 1)
                    ? Container()
                    : ExpansionTile3(
                        title: "Induk Perusahaan",
                        dataList: hasil.relasi_perusahaan.daftar_induk,
                      ),
                (hasil.relasi_perusahaan.level_perusahaan == 1)
                    ? Container()
                    : SizedBox(height: 15),
                (hasil.relasi_perusahaan.level_perusahaan == 2)
                    ? Container()
                    : ExpansionTile3(
                        title: "Anak Perusahaan",
                        dataList: hasil.relasi_perusahaan.daftar_anak,
                      ),
                (hasil.relasi_perusahaan.level_perusahaan == 2)
                    ? Container()
                    : SizedBox(height: 15),
                (hasil.relasi_perusahaan.level_perusahaan == 3)
                    ? Container()
                    : ExpansionTile3(
                        title: "Cucu Perusahaan",
                        dataList: hasil.relasi_perusahaan.daftar_cucu,
                      ),
                (hasil.relasi_perusahaan.level_perusahaan == 3)
                    ? Container()
                    : SizedBox(height: 15),
                ExpansionTile1(
                  title: "Nama Komisaris",
                  dataList: hasil.daftar_komisaris,
                ),
                SizedBox(height: 15),
                ExpansionTile1(
                  title: "Nama Direksi",
                  dataList: hasil.daftar_direksi,
                ),
                SizedBox(height: 15),
                // GestureDetector(
                //   onTap: () {
                //     Get.put<MainPerusahaanController>(MainPerusahaanController()).setPath(
                //         "&bumn_name=${namaCompany.replaceAll(" ", "%20".toString())}");
                //     Get.put<MainPerusahaanController>(MainPerusahaanController())
                //         .setChoicePerusahaan(1);
                //     Navigator.pop(context);
                //     // Navigator.push(context, MaterialPageRoute(
                //     //   builder: (context) {
                //     //     return new MainPerusahaan(
                //     //       pilihanPerusahaan: 1,
                //     //       endPointPath:
                //     //           "bumn_name=${namaCompany.replaceAll(" ", "%20".toString())}",
                //     //     );
                //     //   },
                //     // ));
                //   },
                //   child: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       border: Border.all(color: color_orange_custom, width: 2),
                //       borderRadius: BorderRadius.circular(7),
                //     ),
                //     child: Row(
                //       children: [
                //         Text(
                //           "Anak Perusahaan",
                //           style: font_poppins(14, FontWeight.w600),
                //         ),
                //         Expanded(
                //           child: Align(
                //             alignment: Alignment.centerRight,
                //             child: Column(
                //               children: [
                //                 Text(
                //                   "Perusahaan",
                //                   style: TextStyle(
                //                     fontFamily: 'Poppins',
                //                     fontSize: 11,
                //                     color: Colors.purple.shade800,
                //                   ),
                //                 ),
                //                 SizedBox(height: 5),
                //                 Text(
                //                   "${listData['total_anak_perusahaan']}",
                //                   style: TextStyle(
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 17,
                //                     color: color_yellow_custom,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         SizedBox(width: 10),
                //         Icon(Icons.arrow_forward),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(height: 10),
                // GestureDetector(
                //   onTap: () {
                //     Get.put<MainPerusahaanController>(MainPerusahaanController()).setPath(
                //         "&bumn_name=${namaCompany.replaceAll(" ", "%20".toString())}");
                //     Get.put<MainPerusahaanController>(MainPerusahaanController())
                //         .setChoicePerusahaan(2);
                //     Navigator.pop(context);
                //     // Navigator.push(context, MaterialPageRoute(
                //     //   builder: (context) {
                //     //     return new MainPerusahaan(
                //     //       pilihanPerusahaan: 2,
                //     //       endPointPath:
                //     //           "bumn_name=${namaCompany.replaceAll(" ", "%20".toString())}",
                //     //     );
                //     //   },
                //     // ));
                //   },
                //   child: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       border: Border.all(color: color_orange_custom, width: 2),
                //       borderRadius: BorderRadius.circular(7),
                //     ),
                //     child: Row(
                //       children: [
                //         Text(
                //           "Cucu Perusahaan",
                //           style: font_poppins(14, FontWeight.w600),
                //         ),
                //         Expanded(
                //           child: Align(
                //             alignment: Alignment.centerRight,
                //             child: Column(
                //               children: [
                //                 Text(
                //                   "Perusahaan",
                //                   style: TextStyle(
                //                     fontFamily: 'Poppins',
                //                     fontSize: 11,
                //                     color: Colors.purple.shade800,
                //                   ),
                //                 ),
                //                 SizedBox(height: 5),
                //                 Text(
                //                   "${listData['total_cucu_perusahaan']}",
                //                   style: TextStyle(
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 17,
                //                     color: color_yellow_custom,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         SizedBox(width: 10),
                //         Icon(Icons.arrow_forward),
                //       ],
                //     ),
                //   ),
                // ),
                // ExpansionTile1(
                //   title: "Talent Pool",
                // ),
                // SizedBox(height: 15),
                // Container(
                //   decoration: decorBackContainer,
                //   child: ExpansionTile(
                //     title: Text(
                //       "Anggaran",
                //       style: TextStyle(
                //         fontWeight: FontWeight.w600,
                //         fontSize: 14,
                //         fontFamily: 'Poppins',
                //       ),
                //     ),
                //     children: [
                //       Text(
                //         "*Data yang ditampilkan dalam juta rupiah",
                //         style: TextStyle(
                //           fontSize: 11,
                //           color: Colors.red,
                //           fontFamily: 'Poppins',
                //         ),
                //       ),
                //       ListView.builder(
                //         padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                //         shrinkWrap: true,
                //         physics: NeverScrollableScrollPhysics(),
                //         itemCount: 3,
                //         itemBuilder: (context, index) {
                //           return Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               SizedBox(height: 13),
                //               Text(
                //                 "Anggaran SDM - Rencana",
                //                 style: TextStyle(
                //                   color: color_yellow_custom,
                //                   fontSize: 15,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //               SizedBox(height: 7),
                //               FittedBox(
                //                 child: new DataTable(
                //                   dataRowHeight: 40,
                //                   columns:
                //                       ["Anggaran", "2020", "2019", "2018"].map((e) {
                //                     return DataColumn(
                //                         label: Text(
                //                       e,
                //                       style: TextStyle(fontSize: 19),
                //                     ));
                //                   }).toList(),
                //                   rows: ["Mantapp", "Siapp", "Adakah"].map((e) {
                //                     return DataRow(
                //                       cells: ["Anggaran", "2020", "2019", "2018"]
                //                           .map((e) {
                //                         return DataCell(Text(
                //                           e,
                //                           style: TextStyle(fontSize: 19),
                //                         ));
                //                       }).toList(),
                //                     );
                //                   }).toList(),
                //                 ),
                //               ),
                //               SizedBox(height: 10),
                //               Divider(
                //                 color: main_color_background,
                //                 height: 1,
                //               ),
                //             ],
                //           );
                //         },
                //       ),
                //     ],
                //   ),
                // ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
