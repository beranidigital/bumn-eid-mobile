import 'package:bumn_eid/irwan_dev/cosmics/api/list_api.dart';
import 'package:bumn_eid/irwan_dev/cosmics/controllers/filter_searc_view.dart';
import 'package:bumn_eid/irwan_dev/cosmics/controllers/main_parimeter.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/parimeter_bumn.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/parimeter_kategori.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/parimeter_provinsi.dart';
import 'package:bumn_eid/irwan_dev/cosmics/resources/list_color.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/detail_list_main_page.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/perimeter/detail_main_parimeter.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/perimeter/filter_main_perimeter.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/card_listview.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/frame_list_view.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/summarty_view_2.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainParimeter extends StatelessWidget {
  List<ParimeterKategori> _listParimeterKategori1 = [];
  List<ParimeterKategori> _listParimeterKategori2 = [];
  List<ParimeterBumn> _listParimeterBumn1 = [];
  List<ParimeterBumn> _listParimeterBumn2 = [];
  List<ParimeterProvinsi> _listParimeterProvinsi1 = [];
  List<ParimeterProvinsi> _listParimeterProvinsi2 = [];

  final TextEditingController _formText = TextEditingController();

  final FilterSearchViewController _filterSearchViewController =
      Get.put(FilterSearchViewController());

  final MainParimeterController _mainParimeterController =
      Get.put(MainParimeterController());

  mainWidget(BuildContext context) {
    return Container(
      width: Get.width,
      child: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        children: [
          FutureBuilder(
            future: ListApi.getSummaryParimeter(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var hasil = snapshot.data;
                return GetBuilder<MainParimeterController>(
                  init: MainParimeterController(),
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
                              warna_background: (controller.choice == 1)
                                  ? Colors.blue
                                  : Colors.white,
                              warna_teks: (controller.choice == 1)
                                  ? Colors.white
                                  : Colors.black,
                              path: (controller.choice == 1)
                                  ? "res/images/small_white_cosmics.png"
                                  : "res/images/small_black_cosmics.png",
                              title: "BUMN",
                              val: "${hasil['total_bumn']}",
                              statKond: 1,
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
                              warna_background: (controller.choice == 2)
                                  ? Colors.blue
                                  : Colors.white,
                              warna_teks: (controller.choice == 2)
                                  ? Colors.white
                                  : Colors.black,
                              path: (controller.choice == 2)
                                  ? "res/images/small_white_cosmics.png"
                                  : "res/images/small_black_cosmics.png",
                              title: "Provinsi",
                              val: "${hasil['total_provinsi']}",
                              statKond: 1,
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
                              warna_background: (controller.choice == 3)
                                  ? Colors.blue
                                  : Colors.white,
                              warna_teks: (controller.choice == 3)
                                  ? Colors.white
                                  : Colors.black,
                              path: (controller.choice == 3)
                                  ? "res/images/small_white_cosmics.png"
                                  : "res/images/small_black_cosmics.png",
                              title: "Kategori Parimeter",
                              val: "${hasil['total_kategori']}",
                              statKond: 2,
                            ),
                          ),
                        ),
                      ],
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
          SizedBox(height: 20),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: FilterMainParimeter(),
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
                    autofocus: false,
                    controller: _formText,
                    onChanged: (value) {
                      if (_mainParimeterController.choice == 1) {
                        _listParimeterBumn1 = [];
                        setListDataBumn(value);
                      } else if (_mainParimeterController.choice == 2) {
                        _listParimeterProvinsi1 = [];
                        setListDataProvinsi(value);
                      } else {
                        _listParimeterKategori1 = [];
                        setListDataKategori(value);
                      }
                      _filterSearchViewController.setUpdate();
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
          GetBuilder<MainParimeterController>(
            init: MainParimeterController(),
            builder: (controller) {
              if (controller.choice == 1) {
                ApiStatistic()
                    .insertStatistic("Cosmic", "Total Parimeter BUMN");
                // ApiStatistic()
                // .insertStatistic("Cosmic - Total Parimeter BUMN");
                return FutureBuilder<List<ParimeterBumn>>(
                  future: ListApi.getDataParimeterBumn(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var hasil = snapshot.data;
                      _listParimeterBumn1 = hasil;
                      _listParimeterBumn2 = hasil;
                      return GetBuilder<FilterSearchViewController>(
                        init: FilterSearchViewController(),
                        builder: (controller) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _listParimeterBumn1.length,
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
                                      ApiStatistic().insertStatistic("Cosmic",
                                          "BUMN Readlness ${_listParimeterBumn1[index].bumn_id}");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailListMainPage(
                                              bumn_id:
                                                  _listParimeterBumn1[index]
                                                      .bumn_id,
                                            ),
                                          ));
                                      // Get.to(
                                      //   DetailListMainPage(
                                      //       bumn_id:
                                      //           _listParimeterBumn1[index]
                                      //               .bumn_id,
                                      //       title:
                                      //           _listParimeterBumn1[index]
                                      //               .bumn_name),
                                      // );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: CardListView(
                                        index: index,
                                        title:
                                            "${_listParimeterBumn1[index].bumn_name}",
                                        subtitle: "Parameter",
                                        value:
                                            "${_listParimeterBumn1[index].total_perimeter}",
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
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else if (controller.choice == 2) {
                ApiStatistic()
                    .insertStatistic("Cosmic", "Total Parimeter Provinsi");
                // ApiStatistic()
                // .insertStatistic("Cosmic - Total Parimeter Provinsi");
                return FutureBuilder<List<ParimeterProvinsi>>(
                  future: ListApi.getDataParimeterProvinsi(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var hasil = snapshot.data;
                      _listParimeterProvinsi1 = hasil;
                      _listParimeterProvinsi2 = hasil;
                      return GetBuilder<FilterSearchViewController>(
                        init: FilterSearchViewController(),
                        builder: (controller) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _listParimeterProvinsi1.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  ApiStatistic().insertStatistic("Cosmic",
                                      "Detail List Parimeter Provinsi");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailMainParimeter(
                                                title: _listParimeterProvinsi1[
                                                        index]
                                                    .provinsi,
                                                id: "${_listParimeterProvinsi1[index].provinsi_id}",
                                                title_appbar: "Provinsi",
                                                kondisi: 1,
                                                total_parimeter:
                                                    _listParimeterProvinsi1[
                                                            index]
                                                        .total_perimeter,
                                              )));
                                  // Get.to(DetailMainParimeter(
                                  //   title: _listParimeterProvinsi1[index]
                                  //       .provinsi,
                                  //   id: "${_listParimeterProvinsi1[index].provinsi_id}",
                                  //   title_appbar: "Provinsi",
                                  //   kondisi: 1,
                                  //   total_parimeter:
                                  //       _listParimeterProvinsi1[index]
                                  //           .total_perimeter,
                                  // ));
                                },
                                child: FrameListView(
                                  index: index,
                                  title:
                                      _listParimeterProvinsi1[index].provinsi,
                                  value:
                                      "${_listParimeterProvinsi1[index].total_perimeter}",
                                  subtitle: "Parameter",
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else {
                ApiStatistic().insertStatistic(
                    "Cosmic", "Total Parimeter Kategori Parimeter");
                return FutureBuilder<List<ParimeterKategori>>(
                  future: ListApi.getDataParimeterKategori(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var hasil = snapshot.data;
                      _listParimeterKategori1 = hasil;
                      _listParimeterKategori2 = hasil;
                      return GetBuilder<FilterSearchViewController>(
                        init: FilterSearchViewController(),
                        builder: (controller) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _listParimeterKategori1.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  ApiStatistic().insertStatistic("Cosmic",
                                      "Detail List Parimeter Kategori");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailMainParimeter(
                                                title: _listParimeterKategori1[
                                                        index]
                                                    .kategori,
                                                id: "${_listParimeterKategori1[index].id_kategori}",
                                                title_appbar: "Kategori",
                                                kondisi: 2,
                                                total_parimeter:
                                                    _listParimeterKategori1[
                                                            index]
                                                        .total_perimeter,
                                              )));
                                  // Get.to(DetailMainParimeter(
                                  //   title: _listParimeterKategori1[index]
                                  //       .kategori,
                                  //   id: "${_listParimeterKategori1[index].id_kategori}",
                                  //   title_appbar: "Kategori",
                                  //   kondisi: 2,
                                  //   total_parimeter:
                                  //       _listParimeterKategori1[index]
                                  //           .total_perimeter,
                                  // ));
                                },
                                child: FrameListView(
                                  index: index,
                                  title:
                                      _listParimeterKategori1[index].kategori,
                                  value:
                                      "${_listParimeterKategori1[index].total_perimeter}",
                                  subtitle: "Parameter",
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
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
      title: "Parimeter",
      body: (ctx) => mainWidget(ctx),
    );
  }

  void setListDataProvinsi(String value) {
    if (value.isEmpty) {
      _listParimeterProvinsi1.addAll(_listParimeterProvinsi2);
    } else {
      for (int i = 0; i < _listParimeterProvinsi2.length; i++) {
        if (_listParimeterProvinsi2[i].provinsi.toLowerCase().contains(value)) {
          _listParimeterProvinsi1.add(_listParimeterProvinsi2[i]);
        }
      }
    }
  }

  void setListDataKategori(String value) {
    if (value.isEmpty) {
      _listParimeterKategori1.addAll(_listParimeterKategori2);
    } else {
      for (int i = 0; i < _listParimeterKategori2.length; i++) {
        if (_listParimeterKategori2[i].kategori.toLowerCase().contains(value)) {
          _listParimeterKategori1.add(_listParimeterKategori2[i]);
        }
      }
    }
  }

  void setListDataBumn(String value) {
    if (value.isEmpty) {
      _listParimeterBumn1.addAll(_listParimeterBumn2);
    } else {
      for (int i = 0; i < _listParimeterBumn2.length; i++) {
        if (_listParimeterBumn2[i].bumn_name.toLowerCase().contains(value)) {
          _listParimeterBumn1.add(_listParimeterBumn2[i]);
        }
      }
    }
  }
}
