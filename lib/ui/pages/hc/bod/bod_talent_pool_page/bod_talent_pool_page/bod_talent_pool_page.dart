import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/exceptions/api_exception.dart';
import 'package:bumn_eid/core/models/hc/bod_talent.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_talent_pool_page/bod_talent_pool_page/bod_talent_pool_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_talent_pool_page/bod_talent_pool_page/di/bod_talent_pool_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class BODTalentPoolPageData {
  final String nama;
  final int namaPerusahaan;

  BODTalentPoolPageData({@required this.nama, @required this.namaPerusahaan});
}

// ignore: must_be_immutable
class BODTalentPoolPage extends StatefulWidget with InjectableWidget {
  final BODTalentPoolPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  BODTalentPoolActionMapper actionMapper;
  //injected
  HcController hcController;
  //injected
  Store<AppState> store;

  @override
  BODTalentPoolPageGraph graph() => _graph;

  BODTalentPoolPage([graph]) : this._graph = graph ?? BODTalentPoolPageGraph() {
    setup();
  }

  @override
  _BODTalentPoolPageState createState() => _BODTalentPoolPageState();
}

class _BODTalentPoolPageState extends State<BODTalentPoolPage>
    with AfterLayoutMixin<BODTalentPoolPage> {
  String currentKelas;
  List<String> kelasList;
  String currentCluster;
  List<String> clusterList;
  String currentJabatan;
  List<String> jabatanList;
  bool isError = false;

  List<BODTalent> data;

  bool isDataReady() {
    return kelasList != null && clusterList != null && jabatanList != null;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      final List<String> kelasList = [];
      final List<String> clusterList = [];
      final companies = widget.store.state.companiesState.companies;
      companies.forEach((company) {
        if (!kelasList.contains(company.kelasBumn.toString()))
          kelasList.add(company.kelasBumn.toString());
        if (!clusterList.contains(company.cluster))
          clusterList.add(company.cluster);
      });

      final data = await widget.hcController.fetchTalentFungsi();
      final jabatanList = data.values.map((e) => e.toString()).toList();
      kelasList.add("");
      jabatanList.add("");
      clusterList.add("");

      setState(() {
        this.kelasList = kelasList;
        this.clusterList = clusterList;
        this.jabatanList = jabatanList;
      });
    } catch (ex) {
      setState(() {
        isError = true;
      });
    }
  }

  searchData() async {
    try {
      final kelas = currentKelas == null ? "0" : currentKelas;
      final cluster = currentCluster ?? "0";
      final jabatan = currentJabatan == null
          ? "0"
          : (jabatanList.indexOf(currentJabatan) + 1).toString();

      widget.store.dispatch(ShowDialogAction(
          destination: LoadingDialogDestination(), barrierDismissible: false));

      final data = await widget.hcController
          .fetchTalent(kelas: kelas, cluster: cluster, jabatan: jabatan);

      setState(() {
        this.data = data;
      });

      widget.store.dispatch(NavigateBackAction());
    } on ApiException catch (ex) {
      widget.store.dispatch(NavigateBackAction());
      widget.store.dispatch(ShowDialogAction(
          destination: FailedDialogDestination(
              title: "Error",
              errorMessage: ex.statusCode == 404
                  ? "Data Tidak Ditemukan"
                  : "Terjadi Kesalahan, Mohon ulangi pencarian.")));
    }
  }

  Widget filterKelas() {
    return FilterWidget(
      title: "Kelas",
      currentItem: currentKelas ?? "",
      items: kelasList,
      onChanged: (newKelas) {
        setState(() {
          this.currentKelas = newKelas.isEmpty ? null : newKelas;
        });
      },
    );
  }

  Widget filterCluster() {
    return FilterWidget(
      title: "Cluster",
      currentItem: currentCluster ?? "",
      items: clusterList,
      onChanged: (newCluster) {
        setState(() {
          this.currentCluster = newCluster.isEmpty ? null : newCluster;
        });
      },
    );
  }

  Widget filterJabatan() {
    return FilterWidget(
      title: "Jabatan",
      currentItem: currentJabatan ?? "",
      items: jabatanList,
      onChanged: (newJabatan) {
        setState(() {
          this.currentJabatan = newJabatan.isEmpty ? null : newJabatan;
        });
      },
    );
  }

  Widget filters() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        filterKelas(),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: filterCluster(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: filterJabatan(),
        ),
      ],
    );
  }

  Widget searchBtn() {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(vertical: 16.0),
      padding: EdgeInsets.symmetric(horizontal: 64.0),
      child: RaisedButton(
        onPressed: () => searchData(),
        color: Color(0xFFFBD300),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Text(
          "Cari",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget titleWidget(BuildContext context) {
    return Text(
      "Posisi BOD Saat Ini",
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
    );
  }

  Widget itemWidget(BODTalent item) {
    return GestureDetector(
      onTap: () => widget.actionMapper.openDetailPage(item.id),
      child: Container(
        height: 120.0,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Text(
                            item.name,
                            style: TextStyle(fontWeight: FontWeight.w700),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(
                            item.companyName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(
                            item.bidang ?? item.pangkat,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: widget.colorPalette.primary,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Center(
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> actualData(List<BODTalent> data) {
    return List.generate(data.length, (idx) {
      return itemWidget(data[idx]);
    });
  }

  List<Widget> dataWidget() {
    return data == null || data.isEmpty ? [Container()] : actualData(data);
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        titleWidget(context),
        filters(),
        searchBtn(),
      ]
        ..addAll(dataWidget())
        ..add(LastUpdateWidget(
          store: StoreProvider.of<AppState>(context),
          pageName: "hc",
        )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "BOD",
      body: (ctx) => SafeArea(
        child: !isDataReady()
            ? isError
                ? CustomErrorWidget(
                    onRetry: () => getData(),
                  )
                : LoadingWidget(
                    colorPalette: widget.colorPalette,
                  )
            : mainWidget(context),
      ),
    );
  }
}
