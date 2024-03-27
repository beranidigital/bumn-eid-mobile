import 'package:flutter/material.dart';

class FilterMainEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        listTileCustom(Icons.filter, "Filter", context),
        listTileCustom(Icons.filter, "Jasa Keungan dan Bank", context),
        listTileCustom(Icons.filter, "Kontrak", context),
      ],
    );
  }

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
          //                       border:
          //                           Border.all(color: Colors.blue, width: 1),
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
          //                       constraints: BoxConstraints(
          //                           maxHeight: 25, minHeight: 25),
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
          //                       constraints: BoxConstraints(
          //                           maxHeight: 25, minHeight: 25),
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
}
