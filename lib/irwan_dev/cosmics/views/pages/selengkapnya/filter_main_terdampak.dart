import 'package:bumn_eid/irwan_dev/cosmics/controllers/main_terdampak.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterMainTerdampak extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        listTileCustom(Icons.filter, "Filter", context),
        SizedBox(width: 8),
        listTileCustom(Icons.filter, "Jasa Keungan dan Bank", context),
        SizedBox(width: 8),
        listTileCustom(Icons.filter, "Kontrak", context),
        SizedBox(width: 8),
        listTileCustom(Icons.filter, "Total", context),
      ],
    );
  }
}

List<String> statusKasus = ["Kasus 1", "Kasus 2", "Kasus 3", "Kasus 4"];
List<String> totalStatusKasus = ["100 Ka", "200 Ka", "300 Ka", "400 Ka"];

List<String> tanggal = ["17", "18", "19", "20", "21", "22"];
List<String> totalTanggal = [
  "100 Ta",
  "200 Ta",
  "300 Ta",
  "400 Ta",
  "800 Ta",
  "900 Ta"
];

List<String> wamen = [
  "Pak Irwan",
  "Pak Adi",
  "Pak Diah",
  "Pak Siap",
  "Pak Mantap",
  "Pak Adiguna"
];
List<String> totalWamen = [
  "100 Wa",
  "200 Wa",
  "300 Wa",
  "400 Wa",
  "800 Wa",
  "900 Wa"
];

List<String> classs = ["a5", "a7", "a9", "a4", "a2", "a1"];
List<String> totalClass = [
  "100 Cl",
  "200 Cl",
  "300 Cl",
  "400 Cl",
  "800 Cl",
  "900 Cl"
];

List<String> cluster = ["Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4"];
List<String> totalCluster = ["100 Clu", "200 Clu", "300 Clu", "400 Clu"];

List<String> statusPegawai = [
  "Status 1",
  "Status 2",
  "Status 3",
  "Status 4",
  "Status 5",
  "Status 6"
];
List<String> totalStatusPegawai = [
  "100 St",
  "200 St",
  "300 St",
  "400 St",
  "800 St",
  "900 St"
];

Widget listTileCustom(IconData icon, String text, BuildContext _context) {
  return Material(
    borderRadius: BorderRadius.circular(25),
    child: InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        // showModalBottomSheet(
        //   isScrollControlled: true,
        //   backgroundColor: Colors.white.withOpacity(0.0),
        //   context: _context,
        //   builder: (context) {
        //     return GetBuilder<MainTerdampakController>(
        //       init: MainTerdampakController(),
        //       builder: (controller) {
        //         return Container(
        //           padding: EdgeInsets.symmetric(
        //             vertical: 10,
        //             horizontal: 15,
        //           ),
        //           width: Get.width,
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(15),
        //               topRight: Radius.circular(15),
        //             ),
        //           ),
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Container(
        //                 color: Colors.grey,
        //                 width: 40,
        //                 height: 4,
        //               ),
        //               SizedBox(height: 13),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Text(
        //                     "Filter Data",
        //                     style: TextStyle(fontWeight: FontWeight.bold),
        //                   ),
        //                   Container(
        //                     padding: EdgeInsets.symmetric(
        //                         horizontal: 20, vertical: 5),
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(20),
        //                       border: Border.all(color: Colors.blue, width: 1),
        //                     ),
        //                     child: Text("Reset"),
        //                   ),
        //                 ],
        //               ),
        //               Row(
        //                 children: [
        //                   Expanded(
        //                     child: Column(
        //                       children: [
        //                         iconText(Icons.ac_unit, "Status Kasus"),
        //                         Container(
        //                           constraints: BoxConstraints(maxHeight: 35),
        //                           width: Get.width,
        //                           padding: EdgeInsets.symmetric(
        //                             horizontal: 10,
        //                           ),
        //                           decoration: BoxDecoration(
        //                             color: Colors.grey.withOpacity(0.25),
        //                             borderRadius: BorderRadius.circular(5),
        //                           ),
        //                           child: DropdownButton(
        //                             isExpanded: true,
        //                             value: controller.statusKasus,
        //                             underline: Container(),
        //                             onChanged: (value) {
        //                               controller.setStatusKasus(value);
        //                             },
        //                             items: statusKasus.map((e) {
        //                               var index = statusKasus.indexOf(e);
        //                               return DropdownMenuItem(
        //                                 child: Row(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.spaceBetween,
        //                                   children: [
        //                                     Text(
        //                                       e,
        //                                       style: TextStyle(fontSize: 14),
        //                                     ),
        //                                     Text(totalStatusKasus[index]),
        //                                   ],
        //                                 ),
        //                                 value: e,
        //                               );
        //                             }).toList(),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                   SizedBox(width: 10),
        //                   Expanded(
        //                     child: Column(
        //                       children: [
        //                         iconText(Icons.ac_unit, "Tanggal"),
        //                         Container(
        //                           constraints: BoxConstraints(maxHeight: 35),
        //                           width: Get.width,
        //                           padding: EdgeInsets.symmetric(
        //                             horizontal: 10,
        //                           ),
        //                           decoration: BoxDecoration(
        //                             color: Colors.grey.withOpacity(0.25),
        //                             borderRadius: BorderRadius.circular(5),
        //                           ),
        //                           child: DropdownButton(
        //                             isExpanded: true,
        //                             value: controller.tanggal,
        //                             underline: Container(),
        //                             onChanged: (value) {
        //                               controller.setTanggal(value);
        //                             },
        //                             items: tanggal.map((e) {
        //                               var index = tanggal.indexOf(e);
        //                               return DropdownMenuItem(
        //                                 child: Row(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.spaceBetween,
        //                                   children: [
        //                                     Text(
        //                                       e,
        //                                       style: TextStyle(fontSize: 14),
        //                                     ),
        //                                     Text(totalTanggal[index]),
        //                                   ],
        //                                 ),
        //                                 value: e,
        //                               );
        //                             }).toList(),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               Row(
        //                 children: [
        //                   Expanded(
        //                     child: Column(
        //                       children: [
        //                         iconText(Icons.ac_unit, "Wamen"),
        //                         Container(
        //                           constraints: BoxConstraints(maxHeight: 35),
        //                           width: Get.width,
        //                           padding: EdgeInsets.symmetric(
        //                             horizontal: 10,
        //                           ),
        //                           decoration: BoxDecoration(
        //                             color: Colors.grey.withOpacity(0.25),
        //                             borderRadius: BorderRadius.circular(5),
        //                           ),
        //                           child: DropdownButton(
        //                             isExpanded: true,
        //                             value: controller.wamen,
        //                             underline: Container(),
        //                             onChanged: (value) {
        //                               controller.setWamen(value);
        //                             },
        //                             items: wamen.map((e) {
        //                               var index = wamen.indexOf(e);
        //                               return DropdownMenuItem(
        //                                 child: Row(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.spaceBetween,
        //                                   children: [
        //                                     Text(
        //                                       e,
        //                                       style: TextStyle(fontSize: 14),
        //                                       overflow: TextOverflow.ellipsis,
        //                                     ),
        //                                     Text(totalWamen[index]),
        //                                   ],
        //                                 ),
        //                                 value: e,
        //                               );
        //                             }).toList(),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                   SizedBox(width: 10),
        //                   Expanded(
        //                     child: Column(
        //                       children: [
        //                         iconText(Icons.ac_unit, "Class"),
        //                         Container(
        //                           constraints: BoxConstraints(maxHeight: 35),
        //                           width: Get.width,
        //                           padding: EdgeInsets.symmetric(
        //                             horizontal: 10,
        //                           ),
        //                           decoration: BoxDecoration(
        //                             color: Colors.grey.withOpacity(0.25),
        //                             borderRadius: BorderRadius.circular(5),
        //                           ),
        //                           child: DropdownButton(
        //                             isExpanded: true,
        //                             value: controller.classs,
        //                             underline: Container(),
        //                             onChanged: (value) {
        //                               controller.setClass(value);
        //                             },
        //                             items: classs.map((e) {
        //                               var index = classs.indexOf(e);
        //                               return DropdownMenuItem(
        //                                 child: Row(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.spaceBetween,
        //                                   children: [
        //                                     Text(
        //                                       e,
        //                                       style: TextStyle(fontSize: 14),
        //                                     ),
        //                                     Text(totalClass[index]),
        //                                   ],
        //                                 ),
        //                                 value: e,
        //                               );
        //                             }).toList(),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               iconText(Icons.ac_unit, "Cluster"),
        //               Container(
        //                 constraints: BoxConstraints(maxHeight: 35),
        //                 width: Get.width,
        //                 padding: EdgeInsets.symmetric(
        //                   horizontal: 10,
        //                 ),
        //                 decoration: BoxDecoration(
        //                   color: Colors.grey.withOpacity(0.25),
        //                   borderRadius: BorderRadius.circular(5),
        //                 ),
        //                 child: DropdownButton(
        //                   isExpanded: true,
        //                   value: controller.cluster,
        //                   underline: Container(),
        //                   onChanged: (value) {
        //                     controller.setCluster(value);
        //                   },
        //                   items: cluster.map((e) {
        //                     var index = cluster.indexOf(e);
        //                     return DropdownMenuItem(
        //                       child: Row(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Text(
        //                             e,
        //                             style: TextStyle(fontSize: 14),
        //                           ),
        //                           Text(totalCluster[index]),
        //                         ],
        //                       ),
        //                       value: e,
        //                     );
        //                   }).toList(),
        //                 ),
        //               ),
        //               iconText(Icons.ac_unit, "Status Pegawai"),
        //               Container(
        //                 constraints: BoxConstraints(maxHeight: 35),
        //                 width: Get.width,
        //                 padding: EdgeInsets.symmetric(
        //                   horizontal: 10,
        //                 ),
        //                 decoration: BoxDecoration(
        //                   color: Colors.grey.withOpacity(0.25),
        //                   borderRadius: BorderRadius.circular(5),
        //                 ),
        //                 child: DropdownButton(
        //                   isExpanded: true,
        //                   value: controller.statusPegawai,
        //                   underline: Container(),
        //                   onChanged: (value) {
        //                     controller.setStatusPegawai(value);
        //                   },
        //                   items: statusPegawai.map((e) {
        //                     var index = statusPegawai.indexOf(e);
        //                     return DropdownMenuItem(
        //                       child: Row(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Text(
        //                             e,
        //                             style: TextStyle(fontSize: 14),
        //                           ),
        //                           Text(totalStatusPegawai[index]),
        //                         ],
        //                       ),
        //                       value: e,
        //                     );
        //                   }).toList(),
        //                 ),
        //               ),
        //               iconText(Icons.ac_unit, "Total Kasus"),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                 children: [
        //                   GestureDetector(
        //                     onTap: () {
        //                       controller.setGroupTotalKasus(0);
        //                     },
        //                     child: Container(
        //                       constraints:
        //                           BoxConstraints(maxHeight: 25, minHeight: 25),
        //                       child: Row(
        //                         children: [
        //                           Transform.scale(
        //                             scale: 0.8,
        //                             child: Radio(
        //                               value: 0,
        //                               groupValue: controller.groupTotalKasus,
        //                               onChanged: (value) {
        //                                 controller.setGroupTotalKasus(value);
        //                               },
        //                             ),
        //                           ),
        //                           Text(
        //                             "Terbanyak - Terkecil",
        //                             style: TextStyle(fontSize: 13),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                   GestureDetector(
        //                     onTap: () {
        //                       controller.setGroupTotalKasus(1);
        //                     },
        //                     child: Container(
        //                       constraints:
        //                           BoxConstraints(maxHeight: 25, minHeight: 25),
        //                       child: Row(
        //                         children: [
        //                           Transform.scale(
        //                             scale: 0.8,
        //                             child: Radio(
        //                               value: 1,
        //                               groupValue: controller.groupTotalKasus,
        //                               onChanged: (value) {
        //                                 controller.setGroupTotalKasus(value);
        //                               },
        //                             ),
        //                           ),
        //                           Text(
        //                             "Terkecil - Terbanyak",
        //                             style: TextStyle(fontSize: 13),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               Material(
        //                 child: InkWell(
        //                   onTap: () {
        //                     Navigator.pop(context);
        //                   },
        //                   child: Container(
        //                     padding: EdgeInsets.symmetric(vertical: 10),
        //                     width: Get.width,
        //                     decoration: BoxDecoration(
        //                       color: Colors.blue,
        //                     ),
        //                     child: Center(
        //                       child: Text("Tampilkan"),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         );
        //       },
        //     );
        //   },
        // );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey.shade400.withOpacity(0.5),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14),
            SizedBox(width: 3),
            Text(
              text,
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget iconText(IconData icons, String title) {
  return Row(
    children: [
      Icon(icons, size: 17),
      Text(
        title,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    ],
  );
}
