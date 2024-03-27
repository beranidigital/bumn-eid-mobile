import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_item.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/mobility/talent_mobility_page/di/talent_mobility_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/mobility/talent_mobility_page/talent_mobility_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TalentMobilityPage extends StatefulWidget with InjectableWidget {
  final TalentMobilityPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  TalentMobilityPageActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  TalentMobilityPageGraph graph() => _graph;

  TalentMobilityPage([graph])
      : this._graph = graph ?? TalentMobilityPageGraph() {
    setup();
  }

  @override
  _TalentMobilityPageState createState() => _TalentMobilityPageState();
}

class _TalentMobilityPageState extends State<TalentMobilityPage>
    with AfterLayoutMixin<TalentMobilityPage> {
  String currentStatus = "All";

  List<TalentPoolItem> data;
  List<TalentPoolItem> filteredData = [];
  TextEditingController searchController = TextEditingController();

  List<String> mobility;

  bool isError = false;

  bool isDataReady() {
    return data != null && mobility != null;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getData() async {
    try {
      setState(() {
        isError = false;
      });
      final data = await widget.hcController.fetchTalentMobility();

      List<String> mobility = [];
      data.forEach((element) {
        if (element.mobility != null && !mobility.contains(element.mobility))
          mobility.add(element.mobility);
      });

      setState(() {
        this.data = data;
        this.mobility = mobility;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        isError = true;
      });
    }
  }

  @override
  void dispose() {
    searchController?.dispose();
    super.dispose();
  }

  void filterCompany({String query, String status = "All"}) {
    if (data.isEmpty) return;
    final filtered = data.where((company) {
      bool nameBool = query == null || query.isEmpty
          ? true
          : company.nama.toLowerCase().contains(query.toLowerCase());
      bool statusBool = status == "All"
          ? true
          : company.mobility.toLowerCase() == status.toLowerCase();
      return nameBool && statusBool;
    }).toList();
    setState(() {
      this.filteredData = filtered;
    });
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

  Widget topText() {
    List<Widget> mobilities = [];
    mobilities.add(Expanded(
      child: optionsItem(name: "All", selected: currentStatus == "All"),
    ));
    mobility.forEach((element) {
      mobilities.add(Expanded(
        child: optionsItem(name: element, selected: currentStatus == element),
      ));
    });
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Talent Mobility:",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: mobilities,
          )
        ],
      ),
    );
  }

  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Talent:",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ),
          SearchBar(
            colorPalette: widget.colorPalette,
            controller: searchController,
            hintText: "Cari Nama Talent Disini",
            labelText: "Cari Nama Talent Disini",
            onChanged: (newString) {
              filterCompany(status: currentStatus, query: newString);
            },
          )
        ],
      ),
    );
  }

  Widget optionsItem({String name, bool selected = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          this.currentStatus = name;
        });
        String query = searchController.text;
        filterCompany(query: query, status: name);
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color:
                  selected ? widget.colorPalette.primary : Color(0xFFFBFBFB)),
          padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
          child: Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: selected ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget items() {
    final tableData = searchController.text.isNotEmpty || currentStatus != "All"
        ? filteredData
        : data;
    if (tableData.isEmpty) return queryNotFoundError(context);

    return ListView.builder(
        padding: EdgeInsets.only(top: 16),
        itemCount: tableData.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          TalentPoolItem datum = tableData[index];
          return GestureDetector(
            onTap: () => widget.actionMapper.goToDetail(datum),
            child: item(
                name: datum.nama,
                nik: datum.nik,
                jabatan: datum.jabatan,
                companyName: datum.namaPerusahaan,
                status: datum.mobility),
          );
        });
  }

  Widget item({
    String name,
    String companyName,
    String nik,
    String jabatan,
    String status,
  }) {
    String imageRes;
    Color color;
    Color textColor;
    switch (status) {
      case "not ready":
        imageRes = "ic_not_ready.png";
        color = Color(0xFFC2F1E9);
        textColor = Colors.black;
        break;
      case "not eligible":
        imageRes = "ic_not_eligible.png";
        color = Color(0xFFEAA994);
        textColor = Colors.white;
        break;
      case "not nominated":
        imageRes = "ic_not_nominated.png";
        color = Color(0xFFB4C3E0);
        textColor = Colors.black;
        break;
      case "not selected":
        imageRes = "ic_not_selected.png";
        color = Color(0xFFAFAFB0);
        textColor = Colors.white;
        break;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
      child: Card(
        elevation: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.colorPalette.primary),
                      child: Center(
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            jabatan,
                          ),
                          Text(
                            companyName,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: color,
              width: 100,
              padding: EdgeInsets.only(bottom: 8, left: 8, right: 8, top: 8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      status,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: textColor),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return Container(
      color: Color(0xFFEEEFF3),
      height: MediaQuery.of(context).size.height,
      child: !isDataReady()
          ? isError
              ? CustomErrorWidget(
                  onRetry: () => getData(),
                )
              : LoadingWidget(
                  colorPalette: widget.colorPalette,
                )
          : ListView(
              children: <Widget>[topText(), searchBox(), items()],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Talent Mobility",
      body: (ctx) => mainWidget(context),
    );
  }
}
