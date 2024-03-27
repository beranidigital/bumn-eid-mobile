import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/controllers/talent/main_talent_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/models/list_company_talent_pool.dart';
import 'package:bumn_eid/irwan_dev/hc/models/list_talent_pool.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/talent/filters_talent.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/talent/profil_talent.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/filtering_list.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/form_search.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';

class MenuListTalent extends StatelessWidget {
  String path = "";

  TextEditingController _formSearch = TextEditingController();
  List<DataListTalentPool> listDataAll = [];
  List<DataListTalentPool> listDataChanges = [];
  MenuListTalent({
    Key key,
    @required this.path,
  }) : super(key: key);

  bool pressing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<MainTalentController>(
        id: 'mainListTalent',
        init: MainTalentController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pencarian",
                style: font_poppins(13, FontWeight.bold),
              ),
              SizedBox(height: 6),
              GetBuilder<MainTalentController>(
                id: 'dropDown',
                init: MainTalentController(),
                builder: (controller) {
                  return Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.45),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: PopupMenuButton<String>(
                          icon: Icon(
                              (controller.kodePencarian == 0)
                                  ? Icons.home_work_outlined
                                  : Icons.person_pin,
                              size: 30),
                          onSelected: (value) {
                            if (value == '1') {
                              controller.setKodePencarian(0);
                            } else {
                              controller.setKodePencarian(1);
                            }
                          },
                          itemBuilder: (context) {
                            return <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: '1',
                                child: Text('By Company'),
                              ),
                              const PopupMenuItem<String>(
                                value: '2',
                                child: Text('By Name'),
                              ),
                            ];
                          },
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: FormSearch(
                          formText: _formSearch,
                          modeForm: ModeForm.mode1,
                          onChange: (String value) {
                            if (value.length < 3) {
                              pressing = false;
                            } else {
                              pressing = true;
                            }
                            controller.refreshDropDown();
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: (!pressing)
                            ? () {}
                            : () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                listDataChanges = [];
                                if (_formSearch.text.isEmpty) {
                                  await listDataChanges.addAll(listDataAll);
                                } else {
                                  if (controller.kodePencarian == 0) {
                                    for (int i = 0;
                                        i < listDataAll.length;
                                        i++) {
                                      if (listDataAll[i]
                                          .bumn_name
                                          .toLowerCase()
                                          .contains(_formSearch.text.trim())) {
                                        await listDataChanges
                                            .add(listDataAll[i]);
                                      }
                                    }
                                  } else {
                                    for (int i = 0;
                                        i < listDataAll.length;
                                        i++) {
                                      // print(listDataAll[i].nama.toLowerCase());
                                      if (listDataAll[i]
                                          .nama
                                          .toLowerCase()
                                          .contains(_formSearch.text.trim())) {
                                        // print(listDataAll[i].nama.toLowerCase());
                                        await listDataChanges
                                            .add(listDataAll[i]);
                                      }
                                    }
                                  }
                                }
                                Get.find<MainTalentController>()
                                    .refreshListTalent();

                                // FocusScope.of(context).unfocus();
                              },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                          decoration: BoxDecoration(
                            color: (!pressing)
                                ? Colors.grey.shade400
                                : Colors.green.shade700,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.45),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(7),
                              bottomRight: Radius.circular(7),
                            ),
                          ),
                          child: Text(
                            "Cari",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 15),
              FutureBuilder<ListTalentPool>(
                // future: dataListTalent,
                future: ListApiHC().getListTalentPool(path),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var hasil = snapshot.data.list;
                    if (hasil == null || hasil.isEmpty) {
                      return Center(
                        child: Text("Mohon Maaf! Data Tidak Ada!!"),
                      );
                    }
                    listDataAll = hasil;
                    listDataChanges = hasil;
                    return GetBuilder<MainTalentController>(
                      id: 'refreshListTalent',
                      init: MainTalentController(),
                      builder: (controller) {
                        List<String> dataFilter = [];
                        List<String> dataListCompany = [];
                        for (int i = 0; i < listDataChanges.length; i++) {
                          if (!dataFilter
                              .contains(listDataChanges[i].id_angka)) {
                            dataFilter.add(listDataChanges[i].id_angka);
                            dataListCompany.add(listDataChanges[i].bumn_name);
                          }
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          // itemCount: dataListCompany.length,
                          itemCount:
                              (dataListCompany.length > controller.limitVal)
                                  ? controller.limitVal
                                  : dataListCompany.length,
                          itemBuilder: (context, indexx) {
                            List<DataListTalentPool> dataTalent = [];
                            for (int a = 0; a < listDataChanges.length; a++) {
                              if (listDataChanges[a].id_angka ==
                                  dataFilter[indexx]) {
                                dataTalent.add(listDataChanges[a]);
                              }
                            }
                            // else {
                            //   for (int a = 0; a < listDataChanges.length; a++) {
                            //     if (listDataChanges[a].id_angka ==
                            //             dataFilter[indexx] &&
                            //         listDataChanges[a].status == status) {
                            //       dataTalent.add(listDataChanges[a]);
                            //     }
                            //   }
                            // }

                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    Divider(
                                      thickness: 1,
                                    ),
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        color: second_color_background,
                                        child: Text(
                                          "${dataListCompany[indexx]}",
                                          textAlign: TextAlign.center,
                                          style:
                                              font_poppins(13, FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: dataTalent.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 13),
                                      decoration: decorListView,
                                      child: Material(
                                        borderRadius: BorderRadius.circular(10),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () {
                                            ApiStatistic().insertStatistic(
                                                "Human Capital",
                                                "Detail Profil Talent ${dataTalent[index].nama.toString()} Talent Pool");
                                            print(dataTalent[index].nik);
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return new ProfilTalent(
                                                  nik: dataTalent[index].nik,
                                                );
                                              },
                                            ));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                top: 10,
                                                bottom: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${index + 1}  ",
                                                  style: font_poppins(
                                                    13,
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "${dataTalent[index].nama}",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  font_poppins(
                                                                13,
                                                                FontWeight.w500,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${dataTalent[index].bumn_name}",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .purple
                                                                      .shade700,
                                                                  fontFamily:
                                                                      'Poppins'),
                                                            ),
                                                            Text(
                                                              "${dataTalent[index].jabatan}",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color:
                                                                      color_yellow_custom,
                                                                  fontFamily:
                                                                      'Poppins'),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        children: [
                                                          Image.asset(
                                                            (dataTalent[index]
                                                                        .status ==
                                                                    "ready")
                                                                ? "res/images/ic_ready_color.png"
                                                                : (dataTalent[index]
                                                                            .status ==
                                                                        "eligible")
                                                                    ? "res/images/ic_eligible_color.png"
                                                                    : (dataTalent[index].status ==
                                                                            "nominated")
                                                                        ? "res/images/ic_nominated_color.png"
                                                                        : "res/images/ic_selected_color.png",
                                                            scale: 0.85,
                                                          ),
                                                          SizedBox(height: 4),
                                                          Text(
                                                            "${dataTalent[index].status}",
                                                            style: TextStyle(
                                                                fontSize: 10.5,
                                                                color: (dataTalent[index]
                                                                            .status ==
                                                                        "ready")
                                                                    ? Color(
                                                                        0XFF5AB7A5)
                                                                    : (dataTalent[index].status ==
                                                                            "eligible")
                                                                        ? Color(
                                                                            0XFF1FA4CA)
                                                                        : (dataTalent[index].status ==
                                                                                "nominated")
                                                                            ? Color(0XFFDFC276)
                                                                            : Color(0XFFF19857)),
                                                          ),
                                                        ],
                                                      ),
                                                      // Icon(Icons.arrow_forward),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
