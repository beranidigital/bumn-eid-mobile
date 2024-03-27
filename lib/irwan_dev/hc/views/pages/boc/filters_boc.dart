import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/controllers/boc/main_boc_controller.dart';
import 'package:bumn_eid/irwan_dev/resources/list_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// String asalInstansi = "";
// String gender = "";
// String kelas = "";
// String wamen = "";
// String cluster = "";

void bottomSheetDialog(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.white.withOpacity(0.0),
    enableDrag: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return GetBuilder<MainBocController>(
        init: MainBocController(),
        builder: (control) {
          if (control.listData.isEmpty) {
            return FutureBuilder<Map<String, dynamic>>(
              future: ListApiHC().getDataFilterBOC(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var hasil = snapshot.data;
                  control.setListDataObs(hasil);
                  return GetBuilder<MainBocController>(
                    id: 'refreshFilter',
                    init: MainBocController(),
                    builder: (controller) {
                      return Container(
                        width: Get.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Material(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    onTap: () {
                                      // asalInstansi = "";
                                      // gender = "";
                                      // kelas = "";
                                      // wamen = "";
                                      // cluster = "";
                                      controller.setResetFilter();
                                      controller.refreshFilter();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: colorBlueCustom,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Text(
                                        "Reset",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: colorBlueCustom,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            dropDownCustom(
                              "Asal Instansi",
                              controller.asalInstansi,
                              getListString(control.listData['asal_instansi']),
                              (String value) {
                                controller.setAsalInstansi = value;
                                controller.refreshFilter();
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: dropDownCustom(
                                    "Gender",
                                    controller.gender,
                                    getListString(
                                        control.listData['jenis_kelamin']),
                                    (String value) {
                                      // (value == "")
                                      //     ? gender = ""
                                      //     : (value == "P")
                                      //         ? gender = "P"
                                      //         : gender = "L";
                                      controller.setGender = value;
                                      controller.refreshFilter();
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: dropDownCustom(
                                    "Kelas",
                                    controller.kelas,
                                    getListString(
                                        control.listData['kelas_bumn']),
                                    (String value) {
                                      controller.setKelas = value;
                                      controller.refreshFilter();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            dropDownCustom(
                              "Wamen",
                              controller.wamen,
                              getListString(control.listData['wamen_bumn']),
                              (String value) {
                                controller.setWamen = value;
                                controller.refreshFilter();
                              },
                            ),
                            dropDownCustom(
                              "Cluster",
                              controller.cluster,
                              getListString(control.listData['cluster_bumn']),
                              (String value) {
                                controller.setCluster = value;
                                controller.refreshFilter();
                              },
                            ),
                            SizedBox(height: 8),
                            Material(
                              borderRadius: BorderRadius.circular(50),
                              color: colorBlueCustom,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                onTap: () {
                                  controller.setDataFilter(
                                      [Icons.filter_list], ["Filter"]);
                                  List<IconData> icons = [];
                                  List<String> titles = [];
                                  String path = "";
                                  if (controller.asalInstansi.isNotEmpty) {
                                    path += "&asal_instansi=" +
                                        controller.asalInstansi;
                                    icons.add(Icons.filter_list);
                                    titles.add(controller.asalInstansi);
                                  }
                                  if (controller.gender.isNotEmpty) {
                                    path +=
                                        "&jenis_kelamin=" + controller.gender;
                                    icons.add(Icons.filter_list);
                                    titles.add(controller.gender);
                                  }
                                  if (controller.kelas.isNotEmpty) {
                                    path += "&kelas_bumn=" + controller.kelas;
                                    icons.add(Icons.filter_list);
                                    titles.add(controller.kelas);
                                  }
                                  if (controller.wamen.isNotEmpty) {
                                    path += "&wamen_bumn=" + controller.wamen;
                                    icons.add(Icons.filter_list);
                                    titles.add(controller.wamen);
                                  }
                                  if (controller.cluster.isNotEmpty) {
                                    path +=
                                        "&cluster_bumn=" + controller.cluster;
                                    icons.add(Icons.filter_list);
                                    titles.add(controller.cluster);
                                  }
                                  // print(path.replaceAll(" ", "%20"));
                                  controller.updateFilter(
                                      icons,
                                      titles,
                                      path
                                          .replaceAll(" ", "%20")
                                          .toString()
                                          .trim());
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  width: Get.width,
                                  child: Center(
                                    child: Text(
                                      "Tampilkan",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            return GetBuilder<MainBocController>(
              id: 'refreshFilter',
              init: MainBocController(),
              builder: (controller) {
                return Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Material(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                // asalInstansi = "";
                                // gender = "";
                                // kelas = "";
                                // wamen = "";
                                // cluster = "";
                                controller.setResetFilter();
                                controller.refreshFilter();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: colorBlueCustom,
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  "Reset",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorBlueCustom,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      dropDownCustom(
                        "Asal Instansi",
                        controller.asalInstansi,
                        getListString(control.listData['asal_instansi']),
                        (String value) {
                          controller.setAsalInstansi = value;
                          controller.refreshFilter();
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: dropDownCustom(
                              "Gender",
                              controller.gender,
                              getListString(control.listData['jenis_kelamin']),
                              (String value) {
                                // (value == "")
                                //     ? gender = ""
                                //     : (value == "P")
                                //         ? gender = "P"
                                //         : gender = "L";
                                controller.setGender = value;
                                controller.refreshFilter();
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: dropDownCustom(
                              "Kelas",
                              controller.kelas,
                              getListString(control.listData['kelas_bumn']),
                              (String value) {
                                controller.setKelas = value;
                                controller.refreshFilter();
                              },
                            ),
                          ),
                        ],
                      ),
                      dropDownCustom(
                        "Wamen",
                        controller.wamen,
                        getListString(control.listData['wamen_bumn']),
                        (String value) {
                          controller.setWamen = value;
                          controller.refreshFilter();
                        },
                      ),
                      dropDownCustom(
                        "Cluster",
                        controller.cluster,
                        getListString(control.listData['cluster_bumn']),
                        (String value) {
                          controller.setCluster = value;
                          controller.refreshFilter();
                        },
                      ),
                      SizedBox(height: 8),
                      Material(
                        borderRadius: BorderRadius.circular(50),
                        color: colorBlueCustom,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          onTap: () {
                            controller
                                .setDataFilter([Icons.filter_list], ["Filter"]);
                            List<IconData> icons = [];
                            List<String> titles = [];
                            String path = "";
                            if (controller.asalInstansi.isNotEmpty) {
                              path +=
                                  "&asal_instansi=" + controller.asalInstansi;
                              icons.add(Icons.filter_list);
                              titles.add(controller.asalInstansi);
                            }
                            if (controller.gender.isNotEmpty) {
                              path += "&jenis_kelamin=" + controller.gender;
                              icons.add(Icons.filter_list);
                              titles.add(controller.gender);
                            }
                            if (controller.kelas.isNotEmpty) {
                              path += "&kelas_bumn=" + controller.kelas;
                              icons.add(Icons.filter_list);
                              titles.add(controller.kelas);
                            }
                            if (controller.wamen.isNotEmpty) {
                              path += "&wamen_bumn=" + controller.wamen;
                              icons.add(Icons.filter_list);
                              titles.add(controller.wamen);
                            }
                            if (controller.cluster.isNotEmpty) {
                              path += "&cluster_bumn=" + controller.cluster;
                              icons.add(Icons.filter_list);
                              titles.add(controller.cluster);
                            }
                            // print(path.replaceAll(" ", "%20"));
                            controller.updateFilter(icons, titles,
                                path.replaceAll(" ", "%20").toString().trim());
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            width: Get.width,
                            child: Center(
                              child: Text(
                                "Tampilkan",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      );
    },
  );
}

List<String> getListString(List<dynamic> list) {
  List<String> listData = [""];
  for (int i = 0; i < list.length; i++) {
    listData.add(list[i]['text']);
  }
  return listData;
}

Widget dropDownCustom(
    String title, String value, List<String> listValue, Function onChanged) {
  return Container(
    margin: EdgeInsets.only(bottom: 13),
    child: Column(
      children: [
        Row(
          children: [
            // Icon(
            //   icon,
            //   size: 17,
            // ),
            Image.asset("res/images/icon_filter.png"),
            SizedBox(width: 3),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Container(
          constraints: BoxConstraints(maxHeight: 40),
          width: Get.width,
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButton(
            isExpanded: true,
            value: value,
            underline: Container(),
            items: listValue.map((e) {
              return DropdownMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        e,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                value: e,
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    ),
  );
}
