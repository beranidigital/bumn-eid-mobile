import 'package:bumn_eid/irwan_dev/cosmics/api/list_api.dart';
import 'package:bumn_eid/irwan_dev/cosmics/controllers/filter_searc_view.dart';
import 'package:bumn_eid/irwan_dev/cosmics/controllers/main_terdampak.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/terdampak_bumn.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/terdampak_kabupaten.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/terdampak_provinsi.dart';
import 'package:bumn_eid/irwan_dev/cosmics/resources/list_color.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/detail_list_main_page.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/selengkapnya/detail_main_terdampak.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/selengkapnya/filter_main_terdampak.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/card_listview.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/frame_list_view.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/summarty_view_2.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainTerdampak extends StatelessWidget {
  List<TerdampakBumn> _listDataBumn1 = [];
  List<TerdampakProvinsi> _listDataProvinsi1 = [];
  List<TerdampakKabupaten> _listDataKabupaten1 = [];
  List<TerdampakBumn> _listDataBumn = [];
  List<TerdampakProvinsi> _listDataProvinsi = [];
  List<TerdampakKabupaten> _listDataKabupaten = [];

  TextEditingController _formText = TextEditingController();

  final FilterSearchViewController _filterSearchViewController =
      Get.put(FilterSearchViewController());

  final MainTerdampakController _mainTerdampakController =
      Get.put(MainTerdampakController());

  mainWidget(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: Get.width,
            height: 100,
            // color: color_appbar,
          ),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: [
              FutureBuilder(
                future: ListApi.getSummaryTerdampak(),
                builder: (context, snapshot) {
                  var hasil = snapshot.data;
                  if (snapshot.hasData) {
                    return GetBuilder<MainTerdampakController>(
                      init: MainTerdampakController(),
                      builder: (controller) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  controller.setChoice(1);
                                },
                                child: SummaryView2(
                                  path: (controller.choice == 1)
                                      ? "res/images/small_white_cosmics.png"
                                      : "res/images/small_black_cosmics.png",
                                  warna_background: (controller.choice == 1)
                                      ? Colors.blue
                                      : Colors.white,
                                  warna_teks: (controller.choice == 1)
                                      ? Colors.white
                                      : Colors.black,
                                  statKond: 1,
                                  title: "BUMN",
                                  val: "${hasil['total_bumn']}",
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  controller.setChoice(2);
                                },
                                child: SummaryView2(
                                  path: (controller.choice == 2)
                                      ? "res/images/small_white_cosmics.png"
                                      : "res/images/small_black_cosmics.png",
                                  warna_background: (controller.choice == 2)
                                      ? Colors.blue
                                      : Colors.white,
                                  warna_teks: (controller.choice == 2)
                                      ? Colors.white
                                      : Colors.black,
                                  statKond: 1,
                                  title: "Provinsi",
                                  val: "${hasil['total_provinsi']}",
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  controller.setChoice(3);
                                },
                                child: SummaryView2(
                                  path: (controller.choice == 3)
                                      ? "res/images/small_white_cosmics.png"
                                      : "res/images/small_black_cosmics.png",
                                  warna_background: (controller.choice == 3)
                                      ? Colors.blue
                                      : Colors.white,
                                  warna_teks: (controller.choice == 3)
                                      ? Colors.white
                                      : Colors.black,
                                  statKond: 1,
                                  title: "Kab. Kota",
                                  val: "${hasil['total_kabupaten']}",
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              SizedBox(height: 15),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: FilterMainTerdampak(),
              // ),
              // SizedBox(height: 15),
              Text(
                "Pencarian",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
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
                        onChanged: (value) {
                          if (_mainTerdampakController.choice == 1) {
                            _listDataBumn = [];
                            setListDataBumn(value);
                          } else if (_mainTerdampakController.choice == 2) {
                            _listDataProvinsi = [];
                            setListDataProvinsi(value);
                          } else if (_mainTerdampakController.choice == 3) {
                            _listDataKabupaten = [];
                            setListDataKabupaten(value);
                          }
                          _filterSearchViewController.setUpdate();
                        },
                        controller: _formText,
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
              GetBuilder<MainTerdampakController>(
                init: MainTerdampakController(),
                builder: (controller) {
                  if (controller.choice == 1) {
                    return FutureBuilder<List<TerdampakBumn>>(
                      future: ListApi.getAllListBumnTerdampak(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var hasil = snapshot.data;
                          _listDataBumn = hasil;
                          _listDataBumn1 = hasil;
                          return GetBuilder<FilterSearchViewController>(
                            init: FilterSearchViewController(),
                            builder: (controller) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _listDataBumn.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        bottom: 10, left: 1, right: 1),
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailListMainPage(
                                                  bumn_id: _listDataBumn[index]
                                                      .bumn_id,
                                                ),
                                              ));
                                          // Get.to(
                                          //   DetailListMainPage(
                                          //     title: _listDataBumn[index]
                                          //         .bumn_name,
                                          //     bumn_id: _listDataBumn[index]
                                          //         .bumn_id,
                                          //   ),
                                          // );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          child: CardListView(
                                            index: index,
                                            title:
                                                "${_listDataBumn[index].bumn_name}",
                                            subtitle: "Terinfeksi",
                                            value:
                                                "${_listDataBumn[index].total}",
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
                    );
                  } else if (controller.choice == 2) {
                    return FutureBuilder<List<TerdampakProvinsi>>(
                      future: ListApi.getAllListProvinsiTerdampak(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var hasil = snapshot.data;
                          _listDataProvinsi = hasil;
                          _listDataProvinsi1 = hasil;
                          return GetBuilder<FilterSearchViewController>(
                            init: FilterSearchViewController(),
                            builder: (controller) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _listDataProvinsi.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailMainTerdampak(
                                              title_appbar:
                                                  "Provinsi Terdampak",
                                              id: _listDataProvinsi[index]
                                                  .provinsi_id,
                                              title: _listDataProvinsi[index]
                                                  .provinsi,
                                              value: _listDataProvinsi[index]
                                                  .total,
                                              kondisi: 1,
                                            ),
                                          ));
                                      // Get.to(DetailMainTerdampak(
                                      //   title_appbar: "Provinsi Terdampak",
                                      //   id: _listDataProvinsi[index]
                                      //       .provinsi_id,
                                      //   title:
                                      //       _listDataProvinsi[index].provinsi,
                                      //   value: _listDataProvinsi[index].total,
                                      //   kondisi: 1,
                                      // ));
                                    },
                                    child: FrameListView(
                                      index: index,
                                      title: _listDataProvinsi[index].provinsi,
                                      value:
                                          "${_listDataProvinsi[index].total}",
                                      subtitle: "Terinfeksi",
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
                    );
                  } else {
                    return FutureBuilder<List<TerdampakKabupaten>>(
                      future: ListApi.getAllListKabupatenTerdampak(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var hasil = snapshot.data;
                          _listDataKabupaten = hasil;
                          _listDataKabupaten1 = hasil;
                          return GetBuilder<FilterSearchViewController>(
                            init: FilterSearchViewController(),
                            builder: (controller) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _listDataKabupaten.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailMainTerdampak(
                                              title_appbar:
                                                  "Kab. Kota Terdampak",
                                              title: _listDataKabupaten[index]
                                                  .kabupaten,
                                              id: _listDataKabupaten[index]
                                                  .kabupaten_id,
                                              value: _listDataKabupaten[index]
                                                  .total,
                                              kondisi: 2,
                                            ),
                                          ));
                                      // Get.to(DetailMainTerdampak(
                                      //   title_appbar: "Kab. Kota Terdampak",
                                      //   title: _listDataKabupaten[index]
                                      //       .kabupaten,
                                      //   id: _listDataKabupaten[index]
                                      //       .kabupaten_id,
                                      //   value:
                                      //       _listDataKabupaten[index].total,
                                      //   kondisi: 2,
                                      // ));
                                    },
                                    child: FrameListView(
                                      index: index,
                                      title:
                                          _listDataKabupaten[index].kabupaten,
                                      value:
                                          "${_listDataKabupaten[index].total}",
                                      subtitle: "Terinfeksi",
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
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void setListDataBumn(String value) {
    if (value.isEmpty) {
      _listDataBumn.addAll(_listDataBumn1);
    } else {
      for (int i = 0; i < _listDataBumn1.length; i++) {
        if (_listDataBumn1[i].bumn_name.toLowerCase().contains(value)) {
          _listDataBumn.add(_listDataBumn1[i]);
        }
      }
    }
  }

  void setListDataProvinsi(String value) {
    if (value.isEmpty) {
      _listDataProvinsi.addAll(_listDataProvinsi1);
    } else {
      for (int i = 0; i < _listDataProvinsi1.length; i++) {
        if (_listDataProvinsi1[i].provinsi.toLowerCase().contains(value)) {
          _listDataProvinsi.add(_listDataProvinsi1[i]);
        }
      }
    }
  }

  void setListDataKabupaten(String value) {
    if (value.isEmpty) {
      _listDataKabupaten.addAll(_listDataKabupaten1);
      _filterSearchViewController.setUpdate();
    } else {
      for (int i = 0; i < _listDataKabupaten1.length; i++) {
        if (_listDataKabupaten1[i].kabupaten.toLowerCase().contains(value)) {
          _listDataKabupaten.add(_listDataKabupaten1[i]);
        }
        _filterSearchViewController.setUpdate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Terdampak",
      body: (ctx) => mainWidget(ctx),
    );
  }
}
