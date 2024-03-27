import 'dart:convert';

import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/controllers/perusahaan/main_perusahaan_controller.dart';
import 'package:bumn_eid/irwan_dev/hc/models/bumn_list.dart';
import 'package:bumn_eid/irwan_dev/hc/models/count_perusahaan.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/perusahaan/detail_perusahaan.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/perusahaan/filters_perusahaan.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/button_icon_text2.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/filtering_list.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/form_search.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/lv_perusahaan_anak.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/lv_perusahaan_cucu.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/lv_perusahaan_induk.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';

class MainPerusahaan extends StatelessWidget {
  int pilihanPerusahaan;
  MainPerusahaan({
    Key key,
    this.pilihanPerusahaan,
  }) : super(key: key);

  TextEditingController formSearch = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  List<BumnList> listDataAll = [];
  List<BumnList> listDataChanges = [];

  int maxPage = 1;

  String path = "";

  bool paginationOn = true;

  final MainPerusahaanController _mainPerusahaanController =
      Get.put<MainPerusahaanController>(MainPerusahaanController());

  mainWidget(BuildContext context) {
    _scrollController.addListener(() async {
      if (paginationOn) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (_mainPerusahaanController.currentPage < maxPage) {
            Get.put<MainPerusahaanController>(MainPerusahaanController())
                .addCurrentPage();
            var hasil = await fetchDataPageOther(
                "$path${_mainPerusahaanController.currentPage}");
            if (hasil == 1)
              Get.put<MainPerusahaanController>(MainPerusahaanController())
                  .refreshList();
          }
        }
      }
    });
    Get.put<MainPerusahaanController>(MainPerusahaanController())
        .setValueChoice(pilihanPerusahaan);
    return Container(
      child: FutureBuilder<CountPerusahaan>(
        future: ListApiHC().getCountPerusahaan(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var hasil = snapshot.data;
            return GetBuilder<MainPerusahaanController>(
              id: 'refreshChoicePerusahaan',
              init: MainPerusahaanController(),
              builder: (controller) {
                if (controller.choicePerusahaan == 0)
                  path = "induk?page=";
                else if (controller.choicePerusahaan == 1)
                  path = "anak?page=";
                else if (controller.choicePerusahaan == 2) path = "cucu?page=";
                return Container(
                  width: Get.width,
                  height: Get.height,
                  color: second_color_background,
                  child: ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: ButtonIconText2(
                                  title: "Induk",
                                  value: "${hasil.induk}",
                                  kondisi: (controller.choicePerusahaan == 0)
                                      ? 1
                                      : 0,
                                  onTap: () {
                                    controller.setCurrentPage(1);
                                    controller.setChoicePerusahaan(0);
                                  })),
                          SizedBox(width: 10),
                          Expanded(
                              child: ButtonIconText2(
                            title: "Anak",
                            value: "${hasil.anak}",
                            kondisi: (controller.choicePerusahaan == 1) ? 1 : 0,
                            onTap: () {
                              controller.setCurrentPage(1);
                              controller.setChoicePerusahaan(1);
                            },
                          )),
                          SizedBox(width: 10),
                          Expanded(
                              child: ButtonIconText2(
                            title: "Cucu",
                            value: "${hasil.cucu}",
                            kondisi: (controller.choicePerusahaan == 2) ? 1 : 0,
                            onTap: () {
                              controller.setCurrentPage(1);
                              controller.setChoicePerusahaan(2);
                            },
                          )),
                        ],
                      ),
                      SizedBox(height: 17),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: FilteringList(
                          onTap: () {
                            bottomSheetDialogPerusahaan(context);
                          },
                          icon: controller.iconFilter,
                          title: controller.titleFilter,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Pencarian (nama company)",
                        style: font_poppins(13, FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      FormSearch(
                        formText: formSearch,
                        onChange: (String text) {
                          if (formSearch.text.isEmpty) {
                            listDataChanges = [];
                            listDataChanges.addAll(listDataAll);
                            paginationOn = true;
                            Get.find<MainPerusahaanController>().refreshList();
                          } else if (text.length < 3) {
                            paginationOn = false;
                          } else {
                            listDataChanges = [];
                            for (int i = 0; i < listDataAll.length; i++) {
                              if (listDataAll[i]
                                  .bumn_name
                                  .toLowerCase()
                                  .contains(formSearch.text.trim())) {
                                listDataChanges.add(listDataAll[i]);
                              }
                            }
                            paginationOn = false;
                            Get.find<MainPerusahaanController>().refreshList();
                          }
                        },
                        modeForm: ModeForm.mode2,
                      ),
                      SizedBox(height: 15),
                      GetBuilder<MainPerusahaanController>(
                        init: MainPerusahaanController(),
                        id: 'refreshFetchList',
                        builder: (controller) {
                          // print("Page Sekarang $currentPage");
                          return FutureBuilder<BUMNListPagination>(
                            future: ListApiHC().getBUMNList((controller
                                        .choicePerusahaan ==
                                    0)
                                ? "induk?page=${controller.currentPage}${controller.path}"
                                : (controller.choicePerusahaan == 1)
                                    ? "anak?page=${controller.currentPage}${controller.path}"
                                    : "cucu?page=${controller.currentPage}${controller.path}"),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var hasil = snapshot.data;
                                maxPage = snapshot.data.last_page;
                                listDataAll = hasil.data;
                                listDataChanges = hasil.data;
                                return GetBuilder<MainPerusahaanController>(
                                  id: 'refreshList',
                                  init: MainPerusahaanController(),
                                  builder: (controller) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: listDataChanges.length,
                                      itemBuilder: (context, index) {
                                        if (listDataChanges.length == 0) {
                                          return Center(
                                            child: Text(
                                                "Mohom Maaf, Data Tidak Ada!!"),
                                          );
                                        } else {
                                          return LVPerusahaanInduk(
                                            index: index + 1,
                                            bumnList: listDataChanges[index],
                                            onTap: () {
                                              print(listDataChanges[index]
                                                  .id_angka
                                                  .toString());
                                              ApiStatistic().insertStatistic(
                                                  "Human Capital",
                                                  "Detail Profil BUMN ${listDataChanges[index].bumn_name.toString()} Perusahaan");
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return new DetailPerusahaan(
                                                    idBumn:
                                                        "${listDataChanges[index].id_angka}",
                                                  );
                                                },
                                              ));
                                            },
                                          );
                                        }
                                      },
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          );
                        },
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Perusahaan",
      body: (ctx) => mainWidget(ctx),
    );
  }

  Future<int> fetchDataPageOther(String path) async {
    final response = await http.get("https://eid.bumn.go.id/api/hc/bumn/$path");

    print(response.request.toString());

    if (response.statusCode == 201 || response.statusCode == 200) {
      var dataGet = json.decode(response.body);
      var dataHasil = (dataGet as Map<String, dynamic>)['data'];

      listDataChanges = [];
      for (int i = 0; i < dataHasil.length; i++) {
        listDataAll.add(BumnList.fromMap(dataHasil[i]));
        // listDataChanges.add(BumnList.fromMap(dataHasil[i]));
      }
      listDataChanges = listDataAll;

      return 1;
    } else {
      return 2;
    }
  }
}
