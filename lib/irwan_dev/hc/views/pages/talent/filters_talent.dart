import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/controllers/bod/main_bod_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/controllers/talent/main_talent_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/models/filter_talent.dart';
import 'package:bumn_eid/irwan_dev/resources/list_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void filterTalent(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.white.withOpacity(0.0),
    enableDrag: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return GetBuilder<MainTalentController>(
        init: MainTalentController(),
        builder: (control) {
          if (control.dataList == null || control.dataList.isEmpty) {
            return FutureBuilder<Map<String, dynamic>>(
              future: ListApiHC().getDataFilterTalent(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var hasil = snapshot.data;
                  control.setListDataObs(hasil);
                  return GetBuilder<MainTalentController>(
                    id: 'refreshFilter',
                    init: MainTalentController(),
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
                                      // jk = "";
                                      // agama = "";
                                      // wamen = "";
                                      // kelas = "";
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
                              "Status Talent",
                              controller.statusTalent,
                              getListString(control.dataList['status']),
                              (String value) {
                                controller.setStatusTalent = value;
                                controller.refreshFilter();
                              },
                            ),
                            dropDownCustom(
                              "Kelompok Usia",
                              controller.kelompokUsia,
                              [
                                "",
                                "Between 51 60",
                                "Between 41 50",
                                "Under 40",
                                "Above 60",
                              ],
                              (String value) {
                                if (value == "Between 51 60")
                                  controller.setValKelompokUsia = "3";
                                else if (value == "Between 41 50")
                                  controller.setValKelompokUsia = "2";
                                else if (value == "Under 40")
                                  controller.setValKelompokUsia = "1";
                                else if (value == "Above 60")
                                  controller.setValKelompokUsia = "4";
                                else
                                  controller.setValKelompokUsia = value;
                                controller.setKelompokUsia = value;
                                controller.refreshFilter();
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: dropDownCustom(
                                    "Agama",
                                    controller.agama,
                                    getListStringAgama(
                                        control.dataList['agama']),
                                    (String value) {
                                      controller.setAgama = value;
                                      controller.refreshFilter();
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: dropDownCustom(
                                    "Jenis Kelamin",
                                    controller.jk,
                                    getListStringJk(
                                        control.dataList['jenis_kelamin']),
                                    (String value) {
                                      controller.setJk = value;
                                      controller.refreshFilter();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: dropDownCustom(
                                    "Wamen",
                                    controller.wamen,
                                    getListString(
                                        control.dataList['wamen_bumn']),
                                    (String value) {
                                      controller.setWamen = value;
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
                                        control.dataList['kelas_bumn']),
                                    (String value) {
                                      controller.setKelas = value;
                                      controller.refreshFilter();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // dropDownCustom(
                            //   "Masa Jabat",
                            //   controller.masaJabat,
                            //   [
                            //     "",
                            //     "Expire Above 3 Years",
                            //     "Expire In 2 Years",
                            //     "Expire In 1 Years",
                            //     "Expire In 6 Month",
                            //     "Expire In 3 Month",
                            //     "Expire In 1 Month"
                            //   ],
                            //   (String value) {
                            //     if (value == "Expire Above 3 Years")
                            //       controller.setValMasaJabat = "1";
                            //     else if (value == "Expire In 2 Years")
                            //       controller.setValMasaJabat = "2";
                            //     else if (value == "Expire In 1 Years")
                            //       controller.setValMasaJabat = "3";
                            //     else if (value == "Expire In 6 Month")
                            //       controller.setValMasaJabat = "4";
                            //     else if (value == "Expire In 3 Month")
                            //       controller.setValMasaJabat = "5";
                            //     else if (value == "Expire In 1 Month")
                            //       controller.setValMasaJabat = "6";
                            //     else
                            //       controller.setValMasaJabat = value;
                            //     controller.setMasaJabat = value;
                            //     controller.refreshFilter();
                            //   },
                            // ),
                            dropDownCustom(
                              "Cluster",
                              controller.cluster,
                              getListString(control.dataList['cluster_bumn']),
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
                                  if (controller.statusTalent.isNotEmpty) {
                                    path +=
                                        "&status=" + controller.statusTalent;
                                    icons.add(Icons.filter_list);
                                    titles.add(controller.statusTalent);
                                  }
                                  if (controller.kelompokUsia.isNotEmpty) {
                                    path +=
                                        "&usia=" + controller.valKelompokUsia;
                                    icons.add(Icons.filter_list);
                                    titles.add(controller.kelompokUsia);
                                  }
                                  if (controller.jk.isNotEmpty) {
                                    path += "&jenis_kelamin=" + controller.jk;
                                    icons.add(Icons.filter_list);
                                    titles.add(controller.jk);
                                  }
                                  if (controller.agama.isNotEmpty) {
                                    path += "&agama=" + controller.agama;
                                    icons.add(Icons.filter_list);
                                    titles.add(controller.agama);
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
                                  if (controller.masaJabat.isNotEmpty) {
                                    path += "&masa_jabat=" +
                                        controller.valMasaJabat;
                                    icons.add(Icons.filter_list);
                                    titles.add(controller.masaJabat);
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
                                  // print(path.replaceAll(" ", "%20"));
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
            return GetBuilder<MainTalentController>(
              id: 'refreshFilter',
              init: MainTalentController(),
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
                                // jk = "";
                                // agama = "";
                                // wamen = "";
                                // kelas = "";
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
                        "Status Talent",
                        controller.statusTalent,
                        getListString(control.dataList['status']),
                        (String value) {
                          controller.setStatusTalent = value;
                          controller.refreshFilter();
                        },
                      ),
                      dropDownCustom(
                        "Kelompok Usia",
                        controller.kelompokUsia,
                        [
                          "",
                          "Between 51 60",
                          "Between 41 50",
                          "Under 40",
                          "Above 60",
                        ],
                        (String value) {
                          if (value == "Between 51 60")
                            controller.setValKelompokUsia = "3";
                          else if (value == "Between 41 50")
                            controller.setValKelompokUsia = "2";
                          else if (value == "Under 40")
                            controller.setValKelompokUsia = "1";
                          else if (value == "Above 60")
                            controller.setValKelompokUsia = "4";
                          else
                            controller.setValKelompokUsia = value;
                          controller.setKelompokUsia = value;
                          controller.refreshFilter();
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: dropDownCustom(
                              "Agama",
                              controller.agama,
                              getListStringAgama(control.dataList['agama']),
                              (String value) {
                                controller.setAgama = value;
                                controller.refreshFilter();
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: dropDownCustom(
                              "Jenis Kelamin",
                              controller.jk,
                              getListStringJk(
                                  control.dataList['jenis_kelamin']),
                              (String value) {
                                controller.setJk = value;
                                controller.refreshFilter();
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: dropDownCustom(
                              "Wamen",
                              controller.wamen,
                              getListString(control.dataList['wamen_bumn']),
                              (String value) {
                                controller.setWamen = value;
                                controller.refreshFilter();
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: dropDownCustom(
                              "Kelas",
                              controller.kelas,
                              getListString(control.dataList['kelas_bumn']),
                              (String value) {
                                controller.setKelas = value;
                                controller.refreshFilter();
                              },
                            ),
                          ),
                        ],
                      ),
                      // dropDownCustom(
                      //   "Masa Jabat",
                      //   controller.masaJabat,
                      //   [
                      //     "",
                      //     "Expire Above 3 Years",
                      //     "Expire In 2 Years",
                      //     "Expire In 1 Years",
                      //     "Expire In 6 Month",
                      //     "Expire In 3 Month",
                      //     "Expire In 1 Month"
                      //   ],
                      //   (String value) {
                      //     if (value == "Expire Above 3 Years")
                      //       controller.setValMasaJabat = "1";
                      //     else if (value == "Expire In 2 Years")
                      //       controller.setValMasaJabat = "2";
                      //     else if (value == "Expire In 1 Years")
                      //       controller.setValMasaJabat = "3";
                      //     else if (value == "Expire In 6 Month")
                      //       controller.setValMasaJabat = "4";
                      //     else if (value == "Expire In 3 Month")
                      //       controller.setValMasaJabat = "5";
                      //     else if (value == "Expire In 1 Month")
                      //       controller.setValMasaJabat = "6";
                      //     else
                      //       controller.setValMasaJabat = value;
                      //     controller.setMasaJabat = value;
                      //     controller.refreshFilter();
                      //   },
                      // ),
                      dropDownCustom(
                        "Cluster",
                        controller.cluster,
                        getListString(control.dataList['cluster_bumn']),
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
                            if (controller.statusTalent.isNotEmpty) {
                              path += "&status=" + controller.statusTalent;
                              icons.add(Icons.filter_list);
                              titles.add(controller.statusTalent);
                            }
                            if (controller.kelompokUsia.isNotEmpty) {
                              path += "&usia=" + controller.valKelompokUsia;
                              icons.add(Icons.filter_list);
                              titles.add(controller.kelompokUsia);
                            }
                            if (controller.jk.isNotEmpty) {
                              path += "&jenis_kelamin=" + controller.jk;
                              icons.add(Icons.filter_list);
                              titles.add(controller.jk);
                            }
                            if (controller.agama.isNotEmpty) {
                              path += "&agama=" + controller.agama;
                              icons.add(Icons.filter_list);
                              titles.add(controller.agama);
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
                            // if (controller.masaJabat.isNotEmpty) {
                            //   path += "&masa_jabat=" + controller.valMasaJabat;
                            //   icons.add(Icons.filter_list);
                            //   titles.add(controller.masaJabat);
                            // }
                            if (controller.cluster.isNotEmpty) {
                              path += "&cluster_bumn=" + controller.cluster;
                              icons.add(Icons.filter_list);
                              titles.add(controller.cluster);
                            }
                            // print(path.replaceAll(" ", "%20"));
                            controller.updateFilter(icons, titles,
                                path.replaceAll(" ", "%20").toString().trim());
                            // print(path.replaceAll(" ", "%20"));
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

List<String> getListStringAgama(List<dynamic> list) {
  List<String> listData = [""];
  for (int i = 0; i < list.length; i++) {
    listData.add(list[i]['agama']);
  }
  return listData;
}

List<String> getListStringJk(List<dynamic> list) {
  List<String> listData = [""];
  for (int i = 0; i < list.length; i++) {
    listData.add(list[i]['jk']);
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
