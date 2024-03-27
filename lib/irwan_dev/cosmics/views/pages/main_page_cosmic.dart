import 'package:bumn_eid/irwan_dev/cosmics/api/list_api.dart';
import 'package:bumn_eid/irwan_dev/cosmics/controllers/main_page.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/list_bumn.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/summary_main_page_1.dart';
import 'package:bumn_eid/irwan_dev/cosmics/resources/list_color.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/detail_list_main_page.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/selengkapnya/main_terdampak.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/card_listview.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/main_page/container_custom_1.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/main_page/filter_icon_main_page.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/summary_graph_1.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageCosmic extends StatelessWidget {
  final TextEditingController _formSearch = TextEditingController();

  final MainPageController _mainPageController = Get.put(MainPageController());

  List<ListBumn> _listBumn = [];
  List<ListBumn> _listBumnAll = [];

  mainWidget(BuildContext context) {
    // backgroundColor: lower_background_color,
    return Container(
      width: Get.width,
      height: Get.height,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          SizedBox(height: 15),
          FutureBuilder<SummaryMainPage1>(
            future: ListApi.getDataSummary1(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var hasil = snapshot.data;
                return Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ContainerCustom1(
                                route: 1,
                                // icons: Icons.access_alarms,
                                path: "res/images/company_big_cosmics.png",
                                title: "Average Cosmic Index",
                                value:
                                    "${hasil.summaryAll[0].average_cosmic_index}%"),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: ContainerCustom1(
                              route: 2,
                              title: "Total Parimeter",
                              path: "res/images/parimeter_cosmics.png",
                              value: "${hasil.summaryAll[0].total_perimeter}",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ContainerCustom1(
                                route: 3,
                                path: "res/images/event_cosmics.png",
                                title: "Event",
                                value: "${hasil.summaryAll[0].events}"),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: ContainerCustom1(
                              route: 4,
                              title: "Vaksinasi Pegawai",
                              path: "res/images/vaksinasi_cosmics.png",
                              value: "${hasil.summaryAll[0].vaksin}",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0, 3),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Perkembangan Kasus",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "1 Januari 2020, 18:30",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Get.to(MainTerdampak());
                                        ApiStatistic().insertStatistic(
                                            "Cosmic", "Level 2 Terdampak");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MainTerdampak(),
                                            ));
                                      },
                                      child: Text(
                                        "Selengkapnya >>",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            SummaryGraph1(
                              path: [
                                "res/images/terdampak_cosmics.png",
                                "res/images/sembuh_cosmics.png",
                                "res/images/meninggal_cosmics.png"
                              ],
                              title: ["Terdampak", "Sembuh", "Meninggal"],
                              value: [
                                "${hasil.summaryAll[0].perkembangan_kasus.terinfeksi}",
                                "${hasil.summaryAll[0].perkembangan_kasus.sembuh}",
                                "${hasil.summaryAll[0].perkembangan_kasus.meninggal}"
                              ],
                              modeSummary: ModeSummary.mode1,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        "${hasil.summaryAll[0].perkembangan_kasus.recovery_rate}% Recovery Rate",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${hasil.summaryAll[0].perkembangan_kasus.fatality_rate}% Fatality Rate",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SizedBox(height: 14),
          // FilterMainPage(),
          // SizedBox(height: 10),
          Text(
            "Pencarian",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 7),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  offset: Offset(0, 3),
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.search),
                Expanded(
                    child: Container(
                  child: TextFormField(
                    controller: _formSearch,
                    onChanged: (value) {
                      _listBumn = [];
                      if (value.isEmpty) {
                        _listBumn.addAll(_listBumnAll);
                      } else {
                        for (int i = 0; i < _listBumnAll.length; i++) {
                          if (_listBumnAll[i]
                              .bumn_name
                              .toLowerCase()
                              .contains(value)) {
                            _listBumn.add(_listBumnAll[i]);
                          }
                        }
                      }
                      _mainPageController.setUpdate();
                    },
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          FutureBuilder<List<ListBumn>>(
            future: ListApi.getDataAllListBumn(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var hasil = snapshot.data;
                _listBumn = hasil;
                _listBumnAll = hasil;
                return GetBuilder<MainPageController>(
                  init: MainPageController(),
                  builder: (controller) {
                    return ListView.builder(
                      // primary: false,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      // itemCount: hasil.length,
                      itemCount: _listBumn.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.only(bottom: 10, left: 1, right: 1),
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: Offset(0, 3),
                                blurRadius: 2,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(6),
                              splashColor: Colors.grey,
                              onTap: () {
                                ApiStatistic().insertStatistic("Cosmic",
                                    "BUMN Readlness ${_listBumn[index].bumn_id}");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailListMainPage(
                                              bumn_id:
                                                  "${_listBumn[index].bumn_id}",
                                            )));
                                // Get.to(DetailListMainPage(
                                //   // title: "${hasil[index].bumn_name}",
                                //   // bumn_id: "${hasil[index].bumn_id}",
                                //   title: "${_listBumn[index].bumn_name}",
                                //   bumn_id: "${_listBumn[index].bumn_id}",
                                // ));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: CardListView(
                                  index: index,
                                  title: "${_listBumn[index].bumn_name}",
                                  subtitle: "Cosmic Index",
                                  value: "${_listBumn[index].cosmic_index}",
                                ),
                              ),
                            ),
                          ),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Cosmics Readiness",
      body: (ctx) => mainWidget(ctx),
    );
  }
}
