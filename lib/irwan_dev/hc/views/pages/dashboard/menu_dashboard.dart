import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/models/hc_main_page.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/boc/main_boc.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/bod/main_bod.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/perusahaan/main_perusahaan.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/talent/main_talent.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/filtering_list.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/icon_text_border.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/list_dashboard.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';

class MenuDashboard extends StatelessWidget {
  KetDahsboard dataDashboard;
  MenuDashboard({
    Key key,
    this.dataDashboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: FilteringList(
          //     icon: [
          //       Icons.ac_unit,
          //       Icons.pedal_bike,
          //       Icons.access_alarm,
          //       Icons.ac_unit,
          //       Icons.pedal_bike,
          //       Icons.access_alarm
          //     ],
          //     title: [
          //       "Filter",
          //       "Filter",
          //       "Filter",
          //       "filter",
          //       "Filter",
          //       "Filter"
          //     ],
          //   ),
          // ),
          // SizedBox(height: 15),
          ListDashboard(
            title: "Perusahaan Induk",
            value:
                "Total Karyawan ${dataDashboard.perusahaan_induk.total_karyawan}",
            valueList: [
              "${dataDashboard.perusahaan_induk.total}",
              "${dataDashboard.perusahaan_induk.boc}",
              "${dataDashboard.perusahaan_induk.bod}"
            ],
            onTap: [
              () {
                ApiStatistic().insertStatistic(
                    "Human Capital", "Perusahaan Perusahaan Induk");
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return new MainPerusahaan(pilihanPerusahaan: 0);
                  },
                ));
              },
              () {
                ApiStatistic()
                    .insertStatistic("Human Capital", "Perusahaan BOC");
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return new MainBoc(
                      pathEndPoint: "level=1",
                    );
                  },
                ));
              },
              () {
                ApiStatistic()
                    .insertStatistic("Human Capital", "Perusahaan BOD");
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return new MainBod(
                      pathEndPoint: "level=1",
                    );
                  },
                ));
              }
            ],
          ),
          SizedBox(height: 15),
          ListDashboard(
            title: "Anak Perusahaan",
            value:
                "Total Karyawan ${dataDashboard.perusahaan_anak.total_karyawan}",
            valueList: [
              "${dataDashboard.perusahaan_anak.total}",
              "${dataDashboard.perusahaan_anak.boc}",
              "${dataDashboard.perusahaan_anak.bod}"
            ],
            onTap: [
              () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return new MainPerusahaan(pilihanPerusahaan: 1);
                  },
                ));
              },
              () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return new MainBoc(
                      pathEndPoint: "level=2",
                    );
                  },
                ));
              },
              () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return new MainBod(
                      pathEndPoint: "level=2",
                    );
                  },
                ));
              }
            ],
          ),
          SizedBox(height: 15),
          ListDashboard(
            title: "Cucu Perusahaan",
            value:
                "Total Karyawan ${dataDashboard.perusahaan_cucu.total_karyawan}",
            valueList: [
              "${dataDashboard.perusahaan_cucu.total}",
              "${dataDashboard.perusahaan_cucu.boc}",
              "${dataDashboard.perusahaan_cucu.bod}"
            ],
            onTap: [
              () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return new MainPerusahaan(pilihanPerusahaan: 2);
                  },
                ));
              },
              () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return new MainBoc(
                      pathEndPoint: "level=3",
                    );
                  },
                ));
              },
              () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return new MainBod(
                      pathEndPoint: "level=3",
                    );
                  },
                ));
              }
            ],
          ),
          SizedBox(height: 15),
          Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.45),
                  offset: Offset(0, 3),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "Talent Pool",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 13),
                Container(
                  width: Get.width,
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        ApiStatistic().insertStatistic(
                            "Human Capital", "List Talent Pool All");
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return new MainTalent(
                              path: "",
                            );
                          },
                        ));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: color_blue, width: 1.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: Get.width,
                        child: Row(
                          children: [
                            Image.asset("res/images/ic_total_talent.png",
                                scale: 0.8),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Talent",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${dataDashboard.talent_pool.total_talent}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    iconTextBorder(
                        "Ready",
                        "${dataDashboard.talent_pool.ready}",
                        "ic_ready.png", () {
                      ApiStatistic().insertStatistic(
                          "Human Capital", "List Talent Pool Ready");
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return new MainTalent(path: "status=ready");
                        },
                      ));
                    }),
                    SizedBox(width: 10),
                    iconTextBorder(
                        "Eligible",
                        "${dataDashboard.talent_pool.eligible}",
                        "ic_eligible.png", () {
                      ApiStatistic().insertStatistic(
                          "Human Capital", "List Talent Pool Eligible");
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return new MainTalent(
                            path: "status=eligible",
                          );
                        },
                      ));
                    }),
                    SizedBox(width: 10),
                    iconTextBorder(
                        "Nominated",
                        "${dataDashboard.talent_pool.nominated}",
                        "ic_nominated.png", () {
                      ApiStatistic().insertStatistic(
                          "Human Capital", "List Talent Pool Nominated");
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return new MainTalent(
                            path: "status=nominated",
                          );
                        },
                      ));
                    }),
                    SizedBox(width: 10),
                    iconTextBorder(
                        "Selected",
                        "${dataDashboard.talent_pool.selected}",
                        "ic_selected.png", () {
                      ApiStatistic().insertStatistic(
                          "Human Capital", "List Talent Pool Selected");

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return new MainTalent(path: "status=selected");
                        },
                      ));
                    }),
                  ],
                ),
              ],
            ),
          ),
          // Container(
          //   color: Colors.white,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(7),
          //   ),
          //   child: Column(
          //     children: [
          //       Text("Talent Pool"),
          //       Container(
          //         width: Get.width,
          //         child: Material(
          //           child: InkWell(
          //             onTap: () {
          //               Navigator.push(context, MaterialPageRoute(
          //                 builder: (context) {
          //                   return new MainTalent();
          //                 },
          //               ));
          //             },
          //             child: Row(
          //               children: [
          //                 Icon(Icons.ac_unit),
          //                 Text("Total Talent"),
          //                 Text("1221"),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: iconTextBorder("Ready", "1221", Icons.access_alarm,
          //                 () {
          //               Navigator.push(context, MaterialPageRoute(
          //                 builder: (context) {
          //                   return new MainBod();
          //                 },
          //               ));
          //             }),
          //           ),
          //           Expanded(
          //             child: iconTextBorder(
          //                 "Eligible", "1221", Icons.access_alarm, () {
          //               Navigator.push(context, MaterialPageRoute(
          //                 builder: (context) {
          //                   return new MainBod();
          //                 },
          //               ));
          //             }),
          //           ),
          //           Expanded(
          //             child: iconTextBorder(
          //                 "Nominated", "1221", Icons.access_alarm, () {
          //               Navigator.push(context, MaterialPageRoute(
          //                 builder: (context) {
          //                   return new MainBod();
          //                 },
          //               ));
          //             }),
          //           ),
          //           Expanded(
          //             child: iconTextBorder(
          //                 "Selected", "1221", Icons.access_alarm, () {
          //               Navigator.push(context, MaterialPageRoute(
          //                 builder: (context) {
          //                   return new MainBod();
          //                 },
          //               ));
          //             }),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
