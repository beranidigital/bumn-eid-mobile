import 'package:bumn_eid/irwan_dev/cosmics/controllers/main_parimeter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterMainParimeter extends StatelessWidget {
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

List<String> cluster = ["Adakah 1", "Adakah 2", "Adakah 3", "Adakah 4"];
List<String> totalCluster = ["100", "200", "300", "400"];

List<String> wamen = ["2020", "2021", "2022", "2023", "2024", "2025"];
List<String> totalWamen = ["100", "200", "300", "400", "800", "900"];

List<String> classs = ["2020", "2021", "2022", "2023", "2024", "2025"];
List<String> totalClass = ["100", "200", "300", "400", "800", "900"];

Widget listTileCustom(IconData icon, String text, BuildContext _context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.shade400,
      borderRadius: BorderRadius.circular(25),
    ),
    child: Material(
      color: Colors.grey.shade400,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        splashColor: Colors.grey,
        onTap: () {
          // showModalBottomSheet(
          //   backgroundColor: Colors.white.withOpacity(0.0),
          //   context: _context,
          //   builder: (context) {
          //     return GetBuilder<MainParimeterController>(
          //       init: MainParimeterController(),
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
          //               iconText(Icons.ac_unit, "Total Parameter"),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                 children: [
          //                   GestureDetector(
          //                     onTap: () {
          //                       controller.setGroupValueTotal(0);
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
          //                               groupValue: controller.groupValueTotal,
          //                               onChanged: (value) {
          //                                 controller.setGroupValueTotal(value);
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
          //                       controller.setGroupValueTotal(1);
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
          //                               groupValue: controller.groupValueTotal,
          //                               onChanged: (value) {
          //                                 controller.setGroupValueTotal(value);
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
