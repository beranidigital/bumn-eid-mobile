import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/general_company.dart';
import 'package:bumn_eid/core/models/business_portfolio/summary.dart';
import 'package:bumn_eid/core/models/hc/hc_summary.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/bigger_custom_table.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_expansion_tile.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_detailed_page/cluster_bumn_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_detailed_page/di/cluster_bumn_detailed_page_graph.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_page/cluster_bumn_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class ClusterBumnDetailedPage extends StatefulWidget with InjectableWidget {
  final ClusterBumnDetailedPageGraph _graph;

  final ClusterBumnPageType type;
  final String cluster;

  //injected
  ColorPalette colorPalette;
  //injected
  CompaniesController companiesController;
  //injected
  HcController hcController;
  //injected
  ClusterBumnDetailedActionMapper actionMapper;
  //injected
  Store<AppState> store;

  ClusterBumnDetailedPage(
      {@required this.cluster,
      @required this.type,
      ClusterBumnDetailedPageGraph graph})
      : this._graph = graph ?? ClusterBumnDetailedPageGraph() {
    setup();
  }

  @override
  ClusterBumnDetailedPageGraph graph() => _graph;

  @override
  _ClusterBumnDetailedPageState createState() =>
      _ClusterBumnDetailedPageState();
}

class _ClusterBumnDetailedPageState extends State<ClusterBumnDetailedPage>
    with AfterLayoutMixin<ClusterBumnDetailedPage> {
  final optionsList = ["Total", "Gender", "Age"];

  String currentOption = "Total";
  HcSummary hcSummary;

  bool isError = false;

  Map<String, List<Summary>> businessSummary;
  List<GeneralCompany> jenisPerusahaan = [];
  List<GeneralCompany> filteredProfilPerusahaan = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    bool isSummaryReady = false;
    if (widget.type == ClusterBumnPageType.BUSINESS_PORTFOLIO) {
      isSummaryReady = businessSummary != null;
    } else {
      isSummaryReady = hcSummary != null;
    }
    return jenisPerusahaan != null && isSummaryReady;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      List<GeneralCompany> companies;
      if (widget.type == ClusterBumnPageType.BUSINESS_PORTFOLIO) {
        companies = await widget.companiesController
            .fetchClusterCompanies(cluster: widget.cluster);
      } else {
        companies = await widget.hcController
            .fetchHcCompaniesByCluster(cluster: widget.cluster);
      }

      if (widget.type == ClusterBumnPageType.BUSINESS_PORTFOLIO) {
        final summary = await widget.companiesController
            .fetchClusterSummary(clusterName: widget.cluster);
        Map<String, List<Summary>> summaries = {};

        summary.forEach((item) {
          if (summaries.containsKey(item.jenisAkun)) {
            summaries[item.jenisAkun].add(item);
          } else {
            summaries[item.jenisAkun] = [item];
          }
        });
        setState(() {
          this.businessSummary = summaries;
        });
      } else {
        final summary = await widget.hcController
            .fetchHcSummaryCluster(cluster: widget.cluster);

        setState(() {
          this.hcSummary = summary;
        });
      }
      setState(() {
        this.jenisPerusahaan = companies;
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
      return company.getName().toLowerCase().contains(query.toLowerCase());
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

  Widget companyList(BuildContext context, List<GeneralCompany> companies) {
    if (companies.isEmpty) return queryNotFoundError(context);
    final sortedCompanies = companies.toList()
      ..sort((a, b) => a.getShortName().compareTo(b.getShortName()));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleListView<GeneralCompany>(
        colorPalette: widget.colorPalette,
        onItemTap: (GeneralCompany item) {
          ApiStatistic().insertStatistic("Business Portofolio",
              "Detail Profil BUMN ${item.getName()} Name Cluster  ${item.getCluster()} Wamen 1/2 & Cluster ");
          widget.actionMapper.openCompanyDetailPage(item.getId(), widget.type);
        },
        items: sortedCompanies,
      ),
    );
  }

  Widget clusterTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Text(
        widget.cluster,
        style: TextStyle(
          color: widget.colorPalette.black,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget genderSummary() {
    return Row(
      children: <Widget>[
        Expanded(
          child: summaryItem(
              key: "Laki-Laki",
              count:
                  hcSummary.getLaki2(convertClusterToSummaryType(widget.type)),
              color: Color(0xFF5FD0F3)),
        ),
        Expanded(
          child: summaryItem(
              key: "Perempuan",
              count: hcSummary
                  .getPerempuan(convertClusterToSummaryType(widget.type)),
              color: Color(0xFFFFACAC)),
        ),
      ],
    );
  }

  Widget ageSummary() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: summaryItem(
                  key: "Usia diatas 56",
                  count: hcSummary
                      .getUmurA(convertClusterToSummaryType(widget.type)),
                  color: Color(0xFF5FD0F3),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.getUmurAPercent(convertClusterToSummaryType(widget.type)))}%",
                  height: 120),
            ),
            Expanded(
              child: summaryItem(
                  key: "Usia diantara 46-55",
                  count: hcSummary
                      .getUmurB(convertClusterToSummaryType(widget.type)),
                  color: Color(0xffB934A4),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.getUmurBPercent(convertClusterToSummaryType(widget.type)))}%",
                  height: 120),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: summaryItem(
                  key: "Usia diantara 36-45",
                  count: hcSummary
                      .getUmurC(convertClusterToSummaryType(widget.type)),
                  color: Color(0xFF76B758),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.getUmurCPercent(convertClusterToSummaryType(widget.type)))}%"),
            ),
            Expanded(
              child: summaryItem(
                  key: "Usia diantara 26-35",
                  count: hcSummary
                      .getUmurD(convertClusterToSummaryType(widget.type)),
                  color: Color(0xFFA8BFFF),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.getUmurDPercent(convertClusterToSummaryType(widget.type)))}%"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            summaryItem(
                key: "Usia dibawah 25",
                count: hcSummary
                    .getUmurE(convertClusterToSummaryType(widget.type)),
                textColor: Colors.black,
                color: Color(0xFFFFF1A8),
                contentTextSize: 14,
                extraData:
                    " | ${formatNumber(hcSummary.getUmurEPercent(convertClusterToSummaryType(widget.type)))}%"),
          ],
        ),
      ],
    );
  }

  Widget totalEmployeeSummary() {
    return Row(
      children: <Widget>[
        Expanded(
          child: summaryItem(
            key: "PKWTT",
            count: hcSummary.pegawaiTetap,
          ),
        ),
        Expanded(
          child: summaryItem(key: "PKWT", count: hcSummary.pegawaiKontrak),
        ),
      ],
    );
  }

  Widget totalBOCSummary() {
    return Row(
      children: <Widget>[
        Expanded(
          child: summaryItem(
            key: "BOC",
            count: hcSummary.bocTotal,
          ),
        ),
      ],
    );
  }

  Widget totalBODSummary() {
    return Row(
      children: <Widget>[
        Expanded(
          child: summaryItem(
            key: "BOD",
            count: hcSummary.bodTotal,
          ),
        ),
      ],
    );
  }

  Widget totalSummary() {
    switch (widget.type) {
      case ClusterBumnPageType.HC_EMPLOYEE:
        return totalEmployeeSummary();
      case ClusterBumnPageType.HC_DEKOM:
        return totalEmployeeSummary();
      case ClusterBumnPageType.HC_BOD:
        return totalEmployeeSummary();
      default:
        return totalEmployeeSummary();
    }
  }

  Widget hcSummaryFilterWidget() {
    if (widget.type == ClusterBumnPageType.BUSINESS_PORTFOLIO)
      return Container();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: FilterWidget(
        title: "Summary",
        currentItem: currentOption,
        items: optionsList,
        onChanged: (newOption) {
          setState(() {
            this.currentOption = newOption;
          });
        },
      ),
    );
  }

  Widget hcSummaryWidget() {
    if (widget.type == ClusterBumnPageType.BUSINESS_PORTFOLIO)
      return Container();

    switch (currentOption) {
      case "Total":
        return totalSummary();
      case "Gender":
        return genderSummary();
      case "Age":
        return ageSummary();
      default:
        return totalSummary();
    }
  }

  Widget summaryWidget(BuildContext context) {
    return widget.type == ClusterBumnPageType.HC_EMPLOYEE ||
            widget.type == ClusterBumnPageType.HC_DEKOM ||
            widget.type == ClusterBumnPageType.HC_BOD
        ? hcSummaryWidget()
        : businessSummaryWidget();
  }

  Widget businessSummaryWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        iconWidget: Image.asset(
          'res/images/ic_building.png',
          height: 35.0,
          color: Colors.white,
        ),
        color: Color(0xFFF19857),
        text: "Kinerja Keuangan",
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        children: <Widget>[
          BiggerCustomTable(
            colorPalette: widget.colorPalette,
            color: Color(0xffFF4200),
            title: "Akun",
            data: businessSummary,
            fontSize: 13.0,
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
              clusterTitle(context),
              hcSummaryFilterWidget(),
              summaryWidget(context),
              searchBar(context),
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
      title: 'Cluster BUMN',
      body: (ctx) => mainWidget(ctx),
    );
  }
}
