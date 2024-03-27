import 'package:bumn_eid/irwan_dev/cosmics/api/list_api.dart';
import 'package:bumn_eid/irwan_dev/cosmics/controllers/filter_searc_view.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/terdampak_bumn.dart';
import 'package:bumn_eid/irwan_dev/cosmics/resources/list_color.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/detail_list_main_page.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/selengkapnya/filter_main_terdampak.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/card_listview.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/widgets/summary_graph_1.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailMainTerdampak extends StatelessWidget {
  String title_appbar;
  String title;
  int id;
  int value;
  int kondisi;
  DetailMainTerdampak({
    Key key,
    this.title_appbar,
    this.title,
    this.id,
    this.value,
    this.kondisi,
  }) : super(key: key);

  List<TerdampakBumn> _listData = [];
  List<TerdampakBumn> _listDataAll = [];

  final FilterSearchViewController _filterSearchViewController =
      Get.put(FilterSearchViewController());

  TextEditingController _formText = TextEditingController();

  mainWidget(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: Get.width,
            height: 100,
            color: color_appbar,
          ),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: [
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 1.5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                width: Get.width,
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 10),
                    SummaryGraph1(
                      path: [
                        "res/images/terdampak_cosmics.png",
                        "res/images/sembuh_cosmics.png",
                        "res/images/meninggal_cosmics.png"
                      ],
                      title: ["Terdampak", "Sembuh", "Meninggal"],
                      value: ["${value}", "747", "747"],
                      modeSummary: ModeSummary.mode3,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FilterMainTerdampak(),
              ),
              SizedBox(height: 15),
              Text(
                "Pencarian",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
              FutureBuilder<List<TerdampakBumn>>(
                future: ListApi.getDetailTerdampakBumn((kondisi == 1)
                    ? "https://eid.bumn.go.id/api/cosmics/terdampak/provinsi/$id"
                    : "https://eid.bumn.go.id/api/cosmics/terdampak/kabupaten/$id"),
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailListMainPage(
                                                  bumn_id:
                                                      "${_listData[index].bumn_id}",
                                                )));
                                    // Get.to(DetailListMainPage(
                                    //   title: _listData[index].bumn_name,
                                    //   bumn_id: "${_listData[index].bumn_id}",
                                    // ));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: CardListView(
                                      index: index,
                                      title: "${_listData[index].bumn_name}",
                                      subtitle: "Terinfeksi",
                                      value: "${_listData[index].total}",
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: title_appbar,
      body: (ctx) => mainWidget(ctx),
    );
  }
}
