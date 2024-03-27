import 'dart:math';

import 'package:bumn_eid/irwan_dev/cosmics/api/list_api.dart';
import 'package:bumn_eid/irwan_dev/cosmics/controllers/filter_searc_view.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/list_event.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/summary_jenis_kegiatan.dart';
import 'package:bumn_eid/irwan_dev/cosmics/resources/list_color.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/event/filter_main_event.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/pie_chart_touch.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainEvent extends StatelessWidget {
  TextEditingController _formText = TextEditingController();

  final FilterSearchViewController _filterSearchViewController =
      Get.put(FilterSearchViewController());
  List<ListEvent> _listData = [];
  List<ListEvent> _listDataAll = [];

  mainWidget(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: Get.width,
                height: 100,
                color: color_appbar,
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  color: lower_background_color,
                ),
              ),
            ],
          ),
          Container(
            width: Get.width,
            height: Get.height,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              children: [
                Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(0, 3),
                        blurRadius: 1,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Jenis Kegiatan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: 8),
                      FutureBuilder<List<SummaryJenisKegiatan>>(
                        future: ListApi.getSummaryJenisKegiatan(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var hasil = snapshot.data;
                            return PieChartTouch(dataList: hasil);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // FilterMainEvent(),
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
                          controller: _formText,
                          autofocus: false,
                          onChanged: (value) {
                            _listData = [];
                            if (value.isEmpty) {
                              _listData.addAll(_listDataAll);
                            } else {
                              for (int i = 0; i < _listDataAll.length; i++) {
                                if (_listDataAll[i]
                                    .bumn_name
                                    .toLowerCase()
                                    .contains(value)) {
                                  _listData.add(_listDataAll[i]);
                                }
                              }
                            }
                            _filterSearchViewController.setUpdate();
                          },
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                FutureBuilder<List<ListEvent>>(
                  future: ListApi.getDataEvent(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var hasil = snapshot.data;
                      _listData = hasil;
                      _listDataAll = hasil;
                      return GetBuilder<FilterSearchViewController>(
                        init: FilterSearchViewController(),
                        builder: (controller) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _listData.length,
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
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(""),
                                            titleTextStyle:
                                                TextStyle(fontSize: 0.1),
                                            content:
                                                dialogWidget(_listData[index]),
                                          );
                                        },
                                      );

                                      // Get.defaultDialog(
                                      //   radius: 5,
                                      //   content: dialogWidget(_listData[index]),
                                      //   title: "",
                                      //   titleStyle: TextStyle(
                                      //     fontSize: 0.1,
                                      //   ),
                                      // );

                                      // Get.dialog(dialogWidget());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${index + 1}.  ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${_listData[index].nama_kegiatan}",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${_listData[index].bumn_name}",
                                                        style: TextStyle(
                                                          color: Colors
                                                              .deepPurple
                                                              .shade500,
                                                          fontSize: 12.5,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${_listData[index].jenis_kegiatan}",
                                                        style: TextStyle(
                                                          fontSize: 12.5,
                                                          color: Colors.amber,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(Icons.arrow_forward),
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
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dialogWidget(ListEvent hasil) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${hasil.nama_kegiatan}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today,
                  size: 18, color: Colors.deepPurple.shade500),
              SizedBox(width: 5),
              Text(
                "${hasil.tanggal}",
                style: TextStyle(
                  color: Colors.deepPurple.shade500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "Deskripsi : ",
            style: TextStyle(
              color: Colors.deepPurple.shade500.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "${hasil.deskripsi}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  child: CachedNetworkImage(
                    // http://cosmicsystem.id/cosmic/uploads/sosialisasi/0701/1600675888596.jpg
                    fit: BoxFit.cover,
                    imageUrl:
                        "http://cosmicsystem.id/cosmic/uploads${hasil.file_1}",
                    placeholder: (context, url) => CircularProgressIndicator(),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  child: CachedNetworkImage(
                    imageUrl:
                        "http://cosmicsystem.id/cosmic/uploads${hasil.file_2}",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Event",
      body: (ctx) => mainWidget(ctx),
    );
  }
}
