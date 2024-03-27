import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/api/response/covid/covid_company_list_response.dart';
import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/covid/covid_company_list.dart';
import 'package:bumn_eid/core/models/covid/covid_summary_review_cluster.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_detailed_page/covid_cluster_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_detailed_page/di/covid_cluster_detailed_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class CovidClusterDetailedPage extends StatefulWidget with InjectableWidget {
  final CovidClusterDetailedPageGraph _graph;

  final String cluster;

  //injected
  ColorPalette colorPalette;
  //injected
  CovidController covidController;
  //injected
  HcController hcController;
  //injected
  CovidClusterDetailedActionMapper actionMapper;
  //injected
  Store<AppState> store;

  CovidClusterDetailedPage(
      {@required this.cluster, CovidClusterDetailedPageGraph graph})
      : this._graph = graph ?? CovidClusterDetailedPageGraph() {
    setup();
  }

  @override
  CovidClusterDetailedPageGraph graph() => _graph;

  @override
  _CovidClusterDetailedPageState createState() =>
      _CovidClusterDetailedPageState();
}

class _CovidClusterDetailedPageState extends State<CovidClusterDetailedPage>
    with AfterLayoutMixin<CovidClusterDetailedPage> {
  bool isError = false;

  List<CovidSummaryReviewCluster> reviews;
  List<CovidCompanyList> jenisPerusahaan = [];
  List<CovidCompanyList> filteredProfilPerusahaan = [];
  TextEditingController _searchController = TextEditingController();

  String currentSelectedTimeline;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return jenisPerusahaan != null &&
        jenisPerusahaan.isNotEmpty &&
        reviews != null &&
        currentSelectedTimeline != null;
  }

  void getData({String date}) async {
    try {
      setState(() {
        jenisPerusahaan = null;
        this.isError = false;
      });
      CovidCompanyListResponse companies = await widget.covidController
          .fetchCompaniesByCluster(cluster: widget.cluster, date: date);

      setState(() {
        this.jenisPerusahaan = companies.data;
        this.reviews = companies.review.toList();
        this.currentSelectedTimeline = date ?? this.reviews.first.tanggalReview;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        this.isError = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void filterCompany(String query) {
    if (jenisPerusahaan.isEmpty) return;
    final filtered = jenisPerusahaan.where((company) {
      return company.namaLengkap.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      this.filteredProfilPerusahaan = filtered;
    });
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SearchBar(
          colorPalette: widget.colorPalette,
          controller: _searchController,
          onChanged: (query) => filterCompany(query),
          labelText: "Cari perusahaan disini",
          hintText: "Masukkan nama perusahaan."),
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

  Widget companyList(BuildContext context, List<CovidCompanyList> companies) {
    if (companies.isEmpty) return queryNotFoundError(context);
    final sortedCompanies = companies.toList()
      ..sort((a, b) => b.jumlah.compareTo(a.jumlah));

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SingleListView<CovidCompanyList>(
        colorPalette: widget.colorPalette,
        onItemTap: (CovidCompanyList item) =>
            widget.actionMapper.openCompanyDetailPage(item.idAngka),
        items: sortedCompanies,
        leadingWidget: (CovidCompanyList item) => SumTypeText(
          sumText: "Pencapaian",
          percentage: true,
          colorPalette: widget.colorPalette,
          sum: item.jumlah,
          sumColor: item.getColor(),
        ),
      ),
    );
  }

  Widget timelineWidget() {
    final selectedData = reviews.firstWhere((datum) {
      return datum.tanggalReview == this.currentSelectedTimeline;
    });
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Review Timeline",
            style: TextStyle(
                color: Color(0xFF264E6E),
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 8.0),
            margin: EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FilterWidget(
                  title: "",
                  withTitle: false,
                  items: reviews.map((review) {
                    return review.tanggalReview;
                  }).toList(),
                  width: 150,
                  currentItem: currentSelectedTimeline,
                  onChanged: (newTimeline) {
                    setState(() {
                      this.currentSelectedTimeline = newTimeline;
                    });
                    getData(date: newTimeline);
                  },
                ),
                Container(
                  child: CustomPieChart(
                    colorPalette: widget.colorPalette,
                    tableData: {
                      "100 %": [selectedData.timelineGreen],
                      "81 - 99 %": [selectedData.timelineYellow],
                      "0 - 80 %": [selectedData.timelineRed],
                    },
                    colorMap: {
                      "100 %": Color(0xFF39A952),
                      "81 - 99 %": Color(0xFFD8B005),
                      "0 - 80 %": Color(0xFF94171F),
                    },
                    sortKeys: false,
                    customTotalCount: selectedData.timelineAll,
                    customCountFunction: (List datas) {
                      return datas.first;
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () => widget.actionMapper.openTimeline(widget.cluster),
                  child: Container(
                    decoration: BoxDecoration(
                        color: widget.colorPalette.primary,
                        borderRadius: BorderRadius.circular(4.0)),
                    margin: EdgeInsets.only(top: 8.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                    child: Center(
                      child: Text(
                        "Detail",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return !isDataReady()
        ? isError
            ? CustomErrorWidget(
                onRetry: () => getData(),
              )
            : LoadingWidget(
                colorPalette: widget.colorPalette,
              )
        : Container(
            color: widget.colorPalette.defaultBg,
            child: ListView(padding: const EdgeInsets.all(16.0), children: [
              searchBar(context),
              timelineWidget(),
              companyList(
                  context,
                  _searchController.text.isNotEmpty
                      ? filteredProfilPerusahaan
                      : jenisPerusahaan)
            ]),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Cluster ${widget.cluster}",
      body: (ctx) => mainWidget(context),
    );
  }
}
