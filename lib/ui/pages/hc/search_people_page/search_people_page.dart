import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/api/response/hc/search_item_response.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/search_people_item.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/pages/hc/search_people_page/di/search_people_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/search_people_page/search_people_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class SearchPeoplePage extends StatefulWidget with InjectableWidget {
  final SearchPeoplePageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  SearchPeoplePageActionMapper actionMapper;
  //injected
  HcController hcController;
  //injected
  Store<AppState> store;

  @override
  SearchPeoplePageGraph graph() => _graph;

  SearchPeoplePage([graph]) : this._graph = graph ?? SearchPeoplePageGraph() {
    setup();
  }

  @override
  _SearchPeoplePageState createState() => _SearchPeoplePageState();
}

class _SearchPeoplePageState extends State<SearchPeoplePage>
    with AfterLayoutMixin<SearchPeoplePage> {
  SearchItemResponse data = SearchItemResponse(item: null);
  TextEditingController searchController = TextEditingController();

  bool isError = false;

  bool isQueryExist() {
    return searchController?.text != null && searchController.text.isNotEmpty;
  }

  bool isDataReady() {
    return data?.item != null;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getData({String query}) async {
    try {
      String predefinedText = searchController?.text;
      if (query == null && predefinedText != null && predefinedText.isNotEmpty)
        query = predefinedText;
      if (query == null || query.isEmpty) return;
      setState(() {
        this.data = null;
        isError = false;
      });
      final data = await widget.hcController.fetchSearchPeople(name: query);

      setState(() {
        this.data = data;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        this.data = null;
        isError = true;
      });
    }
  }

  @override
  void dispose() {
    searchController?.dispose();
    super.dispose();
  }

  Widget queryNotFoundError(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          "Mohon maaf, data yang Anda cari tidak tersedia. Silakan coba dengan pencarian lain.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: widget.colorPalette.black),
        ),
      ),
    );
  }

  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TypeAheadField<String>(
            textFieldConfiguration: TextFieldConfiguration(
                controller: searchController,
                autofocus: true,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF264E6E),
                    decoration: TextDecoration.none),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: widget.colorPalette.mediumGrey,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  filled: true,
                  fillColor: widget.colorPalette.white,
                  labelText: "Cari Nama Talent Disini",
                  labelStyle: TextStyle(
                      color: Color(0xFF264E6E),
                      fontSize: 14,
                      decoration: TextDecoration.none),
                  hintText: "Cari Nama Talent Disini",
                  hintStyle: TextStyle(
                      color: widget.colorPalette.mediumGrey,
                      fontSize: 14,
                      decoration: TextDecoration.none),
                )),
            suggestionsCallback: (String pattern) async {
              if (pattern.isEmpty) return Future.value([]);
              return await widget.hcController.fetchAutocomplete(name: pattern);
            },
            errorBuilder: (context, object) {
              return Text(
                "Pejabat Tidak Ditemukan",
                style: TextStyle(color: widget.colorPalette.mediumGrey),
              );
            },
            noItemsFoundBuilder: (context) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                child: Text(
                  "Pejabat Tidak Ditemukan",
                  style: TextStyle(color: widget.colorPalette.mediumGrey),
                ),
              );
            },
            itemBuilder: (context, String suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            onSuggestionSelected: (String suggestion) {
              getData(query: suggestion);
              searchController?.text = suggestion;
            },
          )
        ],
      ),
    );
  }

  Widget items() {
    if (data.item.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 48.0),
          child: Text(
            "Silakan Lakukan Pencarian",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
      );
    }
    final tableData = data.item;
    if (tableData.isEmpty) return queryNotFoundError(context);

    return Padding(
      padding:
          const EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 16),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Text(
            "Induk Perusahaan",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SingleListView<SearchPeopleItem>(
              colorPalette: widget.colorPalette,
              onItemTap: (SearchPeopleItem item) =>
                  widget.actionMapper.goToDetailInduk(item.id),
              items: data.item,
              extraBottomWidget: (SearchPeopleItem item) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.nama_lengkap ?? "-",
                        style: TextStyle(
                            color: Color(0xFF7D90B5),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        item.pangkat ?? "-",
                        style: TextStyle(
                            color: Color(0xFFD8B005),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          data.itemAnak.isEmpty
              ? Container()
              : Text(
                  "Anak Perusahaan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
          data.itemAnak.isEmpty
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: data.itemAnak.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "Item Tidak Ditemukan",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                          ),
                        )
                      : SingleListView<SearchPeopleItem>(
                          colorPalette: widget.colorPalette,
                          onItemTap: (SearchPeopleItem item) =>
                              widget.actionMapper.goToDetailAnak(item.id),
                          items: data.itemAnak,
                          extraBottomWidget: (SearchPeopleItem item) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    item.namaAnak ?? "-",
                                    style: TextStyle(
                                        color: Color(0xFF7D90B5),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    item.pangkat ?? "-",
                                    style: TextStyle(
                                        color: Color(0xFFD8B005),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                ),
          data.itemCucu.isEmpty
              ? Container()
              : Text(
                  "Cucu Perusahaan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
          data.itemCucu.isEmpty
              ? Container()
              : data.itemCucu.isEmpty
                  ? Center(
                      child: Text(
                        "Item Tidak Ditemukan",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                    )
                  : SingleListView<SearchPeopleItem>(
                      colorPalette: widget.colorPalette,
                      onItemTap: (SearchPeopleItem item) =>
                          widget.actionMapper.goToDetailCucu(item.id),
                      items: data.itemCucu,
                      extraBottomWidget: (SearchPeopleItem item) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                item.namaCucu ?? "-",
                                style: TextStyle(
                                    color: Color(0xFF7D90B5),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                item.pangkat ?? "-",
                                style: TextStyle(
                                    color: Color(0xFFD8B005),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        );
                      },
                    ),
        ],
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return Container(
      color: Color(0xFFEEEFF3),
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: <Widget>[
          searchBox(),
          !isQueryExist()
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48.0),
                    child: Text(
                      "Silakan Lakukan Pencarian",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : !isDataReady()
                  ? isError
                      ? CustomErrorWidget(
                          onRetry: () => getData(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 48.0),
                          child: LoadingWidget(
                            colorPalette: widget.colorPalette,
                          ),
                        )
                  : items()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Search All Pejabat",
      body: (ctx) => mainWidget(context),
    );
  }
}
