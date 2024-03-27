import 'package:bumn_eid/irwan_dev/cosmics/controllers/main_page.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/drop_down_custom.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/row_icon_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          listTileCustom(Icons.filter, "Filter", context),
          SizedBox(width: 10),
          listTileCustom(Icons.filter, "Cosmic Index", context),
          SizedBox(width: 10),
          listTileCustom(Icons.filter, "Wamen I", context),
          SizedBox(width: 10),
          listTileCustom(Icons.filter, "Class IV", context),
          SizedBox(width: 10),
          listTileCustom(Icons.filter, "Cluster I", context),
          SizedBox(width: 10),
          listTileCustom(Icons.filter, "2018", context),
          SizedBox(width: 10),
          listTileCustom(Icons.filter, "Terbanyak - Terkecil", context),
        ],
      ),
    );
  }
}

List<String> cluster = ["Adakah 1", "Adakah 2", "Adakah 3", "Adakah 4"];
List<String> totalCluster = ["100", "200", "300", "400"];

List<String> waktu = ["2020", "2021", "2022", "2023", "2024", "2025"];
List<String> totalWaktu = ["100", "200", "300", "400", "800", "900"];

List<String> wamen = ["2020", "2021", "2022", "2023", "2024", "2025"];
List<String> totalWamen = ["100", "200", "300", "400", "800", "900"];

List<String> classs = ["2020", "2021", "2022", "2023", "2024", "2025"];
List<String> totalClass = ["100", "200", "300", "400", "800", "900"];

Widget listTileCustom(IconData icon, String text, BuildContext _context) {
  return Material(
    borderRadius: BorderRadius.circular(25),
    child: InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        // bottomSheetDialog(_context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey.shade400.withOpacity(0.5),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(icon, size: 15),
            SizedBox(width: 3),
            Text(
              text,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    ),
  );
}

void bottomSheetDialog(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.white.withOpacity(0.0),
    context: context,
    builder: (context) {
      return GetBuilder<MainPageController>(
        init: MainPageController(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.grey,
                  width: 40,
                  height: 4,
                ),
                SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filter Data",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue, width: 1),
                      ),
                      child: Text("Reset"),
                    ),
                  ],
                ),
                iconText(Icons.ac_unit, "Data yang Ditampilkan"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setGroupValueData(0);
                      },
                      child: Container(
                        constraints:
                            BoxConstraints(maxHeight: 25, minHeight: 25),
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                value: 0,
                                groupValue: controller.groupValueData,
                                onChanged: (value) {
                                  controller.setGroupValueData(value);
                                },
                              ),
                            ),
                            Text(
                              "Cosmic Index",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setGroupValueData(1);
                      },
                      child: Container(
                        constraints:
                            BoxConstraints(maxHeight: 25, minHeight: 25),
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                value: 1,
                                groupValue: controller.groupValueData,
                                onChanged: (value) {
                                  controller.setGroupValueData(value);
                                },
                              ),
                            ),
                            Text(
                              "Kategori Parimeter",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: dropDownCustom("2020", Icons.post_add, "Wamen",
                          (value) {}, wamen, totalWamen, 1),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: dropDownCustom("2021", Icons.post_add, "Class",
                          (value) {}, classs, totalClass, 1),
                    ),
                  ],
                ),
                dropDownCustom("Adakah 2", Icons.people, "Cluster", (value) {},
                    cluster, totalCluster, 1),
                dropDownCustom("2022", Icons.access_alarm, "Waktu", (value) {},
                    waktu, totalWaktu, 1),
                iconText(Icons.ac_unit, "Total"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setGroupValueTotal(0);
                      },
                      child: Container(
                        constraints:
                            BoxConstraints(maxHeight: 25, minHeight: 25),
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                value: 0,
                                groupValue: controller.groupValueTotal,
                                onChanged: (value) {
                                  controller.setGroupValueTotal(value);
                                },
                              ),
                            ),
                            Text(
                              "Terbanyak - Terkecil",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setGroupValueTotal(1);
                      },
                      child: Container(
                        constraints:
                            BoxConstraints(maxHeight: 25, minHeight: 25),
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                value: 1,
                                groupValue: controller.groupValueTotal,
                                onChanged: (value) {
                                  controller.setGroupValueTotal(value);
                                },
                              ),
                            ),
                            Text(
                              "Terkecil - Terbanyak",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text("Tampilkan"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
