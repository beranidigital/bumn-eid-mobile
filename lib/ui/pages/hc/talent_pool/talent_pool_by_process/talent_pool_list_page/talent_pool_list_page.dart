import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_by_company.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_item.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_list_page/di/talent_pool_list_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_list_page/talent_pool_list_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class TalentPoolListPage extends StatefulWidget with InjectableWidget {
  final TalentPoolListPageGraph _graph;

  final String kelas;
  final String cluster;
  final String companyId;

  //injected
  ColorPalette colorPalette;
  //injected
  TalentPoolListPageActionMapper actionMapper;
  //injected
  HcController hcController;
  //injected
  Store<AppState> store;

  @override
  TalentPoolListPageGraph graph() => _graph;

  TalentPoolListPage(
      {this.kelas, this.cluster, this.companyId, TalentPoolListPageGraph graph})
      : this._graph = graph ?? TalentPoolListPageGraph() {
    setup();
  }

  @override
  _TalentPoolListPageState createState() => _TalentPoolListPageState();
}

class _TalentPoolListPageState extends State<TalentPoolListPage>
    with AfterLayoutMixin<TalentPoolListPage> {
  final kelasList = ["1", "2", "3", "4", "5", "-"];
  String currentKelas = "-";

  List<String> clusterList = [];
  String currentCluster = "-";

  List<TalentPoolByCompany> companiesList = [];
  TalentPoolByCompany currentCompany;

  final statusList = ["Ready", "Eligible", "Nominated", "Selected", "-"];
  String currentStatus = "-";

  List<TalentPoolItem> data;
  List<TalentPoolItem> filteredData;

  TextEditingController _searchController = TextEditingController();

  bool isError = false;

  bool isDataReady() {
    return data != null &&
        clusterList != null &&
        currentCluster != null &&
        companiesList != null;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getData({String kelas, String cluster, String companyId}) async {
    try {
      final companies = await widget.hcController.fetchTalentPoolByCompany();
      final sortedCompanies = companies.toList()
        ..sort((a, b) => a.namaLengkap.compareTo(b.namaLengkap));
      setState(() {
        this.companiesList = sortedCompanies;
      });
      setState(() {
        this.currentKelas = widget.kelas;
      });
      setState(() {
        this.currentCluster = widget.cluster;
      });
      if (widget.companyId != null)
        setState(() {
          this.currentCompany =
              companies.firstWhere((item) => item.idAngka == widget.companyId);
        });

      kelas = kelas ?? currentKelas;
      cluster = cluster ?? currentCluster;
      companyId = companyId ?? currentCompany?.idAngka;
      setState(() {
        this.data = null;
        this.filteredData = null;
        this.isError = false;
      });
      final List<TalentPoolItem> data = await widget.hcController
          .fetchTalentPoolList(
              kelas: kelas, cluster: cluster, companyId: companyId);

      final clusterList = widget.store.getClusterList();
      clusterList..add("-");

      if (this.currentCluster == null)
        setState(() {
          this.currentCluster = "-";
        });

      setState(() {
        this.data = data;
        this.clusterList = clusterList;
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
    _searchController?.dispose();
    super.dispose();
  }

  void filterCompany(String query) {
    if (data.isEmpty) return;
    final filtered = data.where((company) {
      return company.nama.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      this.filteredData = filtered;
    });
  }

  Widget searchBar(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: (query) => filterCompany(query),
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          filled: true,
          labelText: "Cari talent disini",
          hintText: "Masukkan nama talent."),
    );
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

  Widget listItem(TalentPoolItem data) {
    return GestureDetector(
      onTap: () => widget.actionMapper.openTalentPage(profile: data),
      child: Container(
        height: 120.0,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          elevation: 16.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data.nama,
                        maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        data.jabatan ?? "-",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        data.namaPerusahaan,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  color: data.getColor(),
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Image(
                          image: AssetImage(data.getImagePath()),
                        ),
                      ),
                      Text(
                        capitalize(data.status),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> listWidget(BuildContext context) {
    List<TalentPoolItem> data =
        _searchController.text.isNotEmpty ? this.filteredData : this.data;
    data = currentStatus == "-"
        ? data
        : data.where((a) => a.status == currentStatus.toLowerCase()).toList();
    return data.isEmpty
        ? [queryNotFoundError(context)]
        : List.generate(data.length, (idx) {
            return listItem(data[idx]);
          });
  }

  Widget statusFilter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: FilterWidget(
        title: "Status",
        currentItem: currentStatus,
        items: statusList,
        onChanged: (newStatus) {
          setState(() {
            this.currentStatus = newStatus;
          });
        },
      ),
    );
  }

  Widget kelasFilter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: FilterWidget(
        title: "Kelas",
        currentItem: currentKelas,
        items: kelasList,
        onChanged: (newKelas) {
          setState(() {
            this.currentKelas = newKelas;
          });

          getData(kelas: newKelas == "-" ? null : newKelas);
        },
      ),
    );
  }

  Widget clusterFilter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: FilterWidget(
        title: "Cluster",
        currentItem: currentCluster,
        items: clusterList,
        onChanged: (newCluster) {
          setState(() {
            this.currentCluster = newCluster;
          });

          getData(cluster: newCluster == "-" ? null : newCluster);
        },
      ),
    );
  }

  Widget companyFilter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: FilterWidget(
        title: "Perusahaan",
        currentItem: currentCompany?.namaLengkap ?? "-",
        items: companiesList.map((item) => item.namaLengkap).toList()..add("-"),
        onChanged: (newCompany) {
          final company =
              companiesList.firstWhere((it) => it.namaLengkap == newCompany);
          setState(() {
            this.currentCompany = company;
          });

          getData(companyId: newCompany == "-" ? null : company.idAngka);
        },
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return !isDataReady()
        ? isError
            ? CustomErrorWidget(
                customText: "Data Tidak Tersedia",
                onRetry: () => getData(),
              )
            : LoadingWidget(
                colorPalette: widget.colorPalette,
              )
        : ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              statusFilter(),
              kelasFilter(),
              clusterFilter(),
              companyFilter(),
              searchBar(context),
            ]..addAll(listWidget(context)),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Talent Pool List',
      body: (ctx) => mainWidget(ctx),
    );
  }
}
