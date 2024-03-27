import 'package:bumn_eid/irwan_dev/cosmics/api/list_api.dart';
import 'package:bumn_eid/irwan_dev/cosmics/controllers/filter_searc_view.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/parimeter_bumn.dart';
import 'package:bumn_eid/irwan_dev/cosmics/resources/list_color.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/detail_list_main_page.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/card_listview.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/summary_view_1.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailMainParimeter extends StatelessWidget {
  String title_appbar;
  String title;
  String id;
  int kondisi;
  int total_parimeter;
  DetailMainParimeter({
    Key key,
    this.title_appbar,
    this.title,
    this.id,
    this.kondisi,
    this.total_parimeter,
  }) : super(key: key);

  List<ParimeterBumn> _listData = [];
  List<ParimeterBumn> _listDataAll = [];
  TextEditingController _formText = TextEditingController();
  final FilterSearchViewController _filterSearchViewController =
      Get.put(FilterSearchViewController());

  mainWidget(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  offset: Offset(0, 3),
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
            ),
            width: Get.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 15),
                FutureBuilder<List<ParimeterBumn>>(
                  future: ListApi.getDetailParimeterBumn((kondisi == 1)
                      ? "https://eid.bumn.go.id/api/cosmics/perimeter/provinsi/$id"
                      : "https://eid.bumn.go.id/api/cosmics/perimeter/kategori/$id"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var hasil = snapshot.data;
                      return Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SummaryView1(
                              title: "Total BUMN",
                              value: "${hasil.length}",
                              borderFirstContainer: 7,
                              borderSecondContainer: 5,
                              font_size: 2,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: SummaryView1(
                              title: "Total Parimeter",
                              value: "${total_parimeter}",
                              borderFirstContainer: 7,
                              borderSecondContainer: 5,
                              font_size: 2,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 14),
          Text(
            "Pencarian",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
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
          FutureBuilder<List<ParimeterBumn>>(
            future: ListApi.getDetailParimeterBumn((kondisi == 1)
                ? "https://eid.bumn.go.id/api/cosmics/perimeter/provinsi/$id"
                : "https://eid.bumn.go.id/api/cosmics/perimeter/kategori/$id"),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailListMainPage(
                                        bumn_id: _listData[index].bumn_id,
                                      ),
                                    ));
                                // Get.to(
                                //   DetailListMainPage(
                                //     bumn_id: _listData[index].bumn_id,
                                //     title: _listData[index].bumn_name,
                                //   ),
                                // );
                                // print("Mantapp");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: CardListView(
                                  index: index,
                                  title: "${_listData[index].bumn_name}",
                                  subtitle: "Parameter",
                                  value: "${_listData[index].total_perimeter}",
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Parimeter $title_appbar",
      body: (ctx) => mainWidget(ctx),
    );
  }
}
