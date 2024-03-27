import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/controllers/boc/main_boc_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/models/detail_bumn_talent.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/boc/profil_pejabat.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/filtering_list.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/form_search.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';

class MenuListBox extends StatelessWidget {
  String pathEndPoint;

  TextEditingController formSearch = TextEditingController();
  List<DetailBUMNTalent> listDataAll = [];
  List<DetailBUMNTalent> listDataChanges = [];
  MenuListBox({
    Key key,
    this.pathEndPoint,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pencarian",
          style: font_poppins(13, FontWeight.bold),
        ),
        SizedBox(height: 6),
        GetBuilder<MainBocController>(
          id: 'dropDown',
          init: MainBocController(),
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
                    formText: formSearch,
                    onChange: (String text) async {
                      listDataChanges = [];
                      if (formSearch.text.isEmpty) {
                        await listDataChanges.addAll(listDataAll);
                      } else {
                        if (controller.kodePencarian == 0) {
                          for (int i = 0; i < listDataAll.length; i++) {
                            if (listDataAll[i]
                                .bumn_name
                                .toLowerCase()
                                .contains(formSearch.text.trim())) {
                              await listDataChanges.add(listDataAll[i]);
                            }
                          }
                        } else {
                          for (int i = 0; i < listDataAll.length; i++) {
                            if (listDataAll[i].nama_lengkap != null) {
                              if (listDataAll[i]
                                  .nama_lengkap
                                  .toLowerCase()
                                  .contains(formSearch.text.trim())) {
                                await listDataChanges.add(listDataAll[i]);
                              }
                            }
                          }
                        }
                      }
                      Get.find<MainBocController>().refreshList();
                    },
                    modeForm: ModeForm.mode2,
                  ),
                  // FormSearch(
                  //   formText: formSearch,
                  //   modeForm: ModeForm.mode1,
                  // ),
                ),
                // GestureDetector(
                //   onTap: () async {
                //     listDataChanges = [];
                //     if (formSearch.text.isEmpty) {
                //       await listDataChanges.addAll(listDataAll);
                //     } else {
                //       if (controller.kodePencarian == 0) {
                //         for (int i = 0; i < listDataAll.length; i++) {
                //           if (listDataAll[i]
                //               .bumn_name
                //               .toLowerCase()
                //               .contains(formSearch.text.trim())) {
                //             await listDataChanges.add(listDataAll[i]);
                //           }
                //         }
                //       } else {
                //         for (int i = 0; i < listDataAll.length; i++) {
                //           if (listDataAll[i].nama_lengkap != null) {
                //             if (listDataAll[i]
                //                 .nama_lengkap
                //                 .toLowerCase()
                //                 .contains(formSearch.text.trim())) {
                //               await listDataChanges.add(listDataAll[i]);
                //             }
                //           }
                //         }
                //       }
                //     }
                //     Get.find<MainBocController>().refreshList();
                //   },
                //   child: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                //     decoration: BoxDecoration(
                //       color: Colors.green.shade700,
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.45),
                //           blurRadius: 2,
                //           spreadRadius: 1,
                //           offset: Offset(0, 3),
                //         ),
                //       ],
                //       borderRadius: BorderRadius.only(
                //         topRight: Radius.circular(7),
                //         bottomRight: Radius.circular(7),
                //       ),
                //     ),
                //     child: Text(
                //       "Cari",
                //       style: TextStyle(
                //           color: Colors.white, fontWeight: FontWeight.w500),
                //     ),
                //   ),
                // ),
              ],
            );
          },
        ),
        // FormSearch(
        //   formText: formSearch,
        //   onChange: (String text) {
        //     listDataChanges = [];
        //     if (formSearch.text.isEmpty) {
        //       listDataChanges.addAll(listDataAll);
        //     } else {
        //       for (int i = 0; i < listDataAll.length; i++) {
        //         if (listDataAll[i]
        //             .bumn_name
        //             .toLowerCase()
        //             .contains(formSearch.text.trim())) {
        //           listDataChanges.add(listDataAll[i]);
        //         }
        //       }
        //     }
        //     Get.find<MainBocController>().refreshList();
        //   },
        //   modeForm: ModeForm.mode2,
        // ),
        SizedBox(height: 15),
        FutureBuilder<List<DetailBUMNTalent>>(
          future: ListApiHC().getDataListTalenta("boc?${pathEndPoint}"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var hasil = snapshot.data;
              listDataAll = hasil;
              listDataChanges = hasil;
              if (hasil.length == 0) {
                return Center(child: Text("Mohon Maaf, Data Tidak Ada!!"));
              } else {
                return GetBuilder<MainBocController>(
                  id: 'refreshList',
                  init: MainBocController(),
                  builder: (controller) {
                    return ListView.builder(
                      // itemCount: listDataChanges.length,
                      itemCount: (controller.limitVal < listDataChanges.length)
                          ? controller.limitVal
                          : listDataChanges.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 13),
                          decoration: decorListView,
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                ApiStatistic().insertStatistic("Human Capital",
                                    "Detail Talenta ${listDataChanges[index].nama_lengkap.toString()} BOC");
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return new ProfilPejabat(
                                      idTalent:
                                          "${listDataChanges[index].id_talenta}",
                                      jabatanBumn:
                                          "${listDataChanges[index].bumn_name}",
                                      namaBumn:
                                          "${listDataChanges[index].jabatan}",
                                    );
                                  },
                                ));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 10, bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  "${listDataChanges[index].nama_lengkap}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: font_poppins(
                                                    13,
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  "${listDataChanges[index].bumn_name}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors
                                                          .purple.shade700,
                                                      fontFamily: 'Poppins'),
                                                ),
                                                Text(
                                                  "${listDataChanges[index].jabatan}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          color_yellow_custom,
                                                      fontFamily: 'Poppins'),
                                                ),
                                                Text(
                                                  "${listDataChanges[index].sisa_pensiun_dalam_hari} Hari atau ${listDataChanges[index].sisa_pensiun_tanggal_tahun} Tahun, ${listDataChanges[index].sisa_pensiun_tanggal_bulan} Bulan",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(Icons.arrow_forward),
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
                    );
                  },
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
