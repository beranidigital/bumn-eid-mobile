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
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_page/cluster_bumn_action_mapper.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_page/di/cluster_bumn_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

enum ClusterBumnPageType { BUSINESS_PORTFOLIO, HC_EMPLOYEE, HC_DEKOM, HC_BOD }

class ClusterBumnPageModel with SingleListItem {
  final String cluster;
  final int total;

  ClusterBumnPageModel({
    @required this.cluster,
    @required this.total,
  });

  @override
  String getTitle() {
    return cluster;
  }
}

// ignore: must_be_immutable
class ClusterBumnPage extends StatefulWidget with InjectableWidget {
  final ClusterBumnPageGraph _graph;

  final ClusterBumnPageType type;
  final String wamen;

  //injected
  ColorPalette colorPalette;
  //injected
  ClusterBumnActionMapper actionMapper;
  //injected
  HcController hcController;
  //injected
  CompaniesController companiesController;
  //injected
  Store<AppState> store;

  @override
  ClusterBumnPageGraph graph() => _graph;

  ClusterBumnPage([type, graph, wamen])
      : this._graph = graph ?? ClusterBumnPageGraph(),
        this.type = type ?? ClusterBumnPageType.BUSINESS_PORTFOLIO,
        this.wamen = wamen ?? 'WAMEN I' {
    setup();
  }

  @override
  _ClusterBumnPageState createState() => _ClusterBumnPageState();
}

class _ClusterBumnPageState extends State<ClusterBumnPage>
    with AfterLayoutMixin<ClusterBumnPage> {
  final optionsList = ["Total", "Gender", "Age"];

  String currentOption = "Total";
  HcSummary hcSummary;

  Map<String, List<Summary>> businessSummary;
  Map<String, List<GeneralCompany>> tableData;
  String currentWamen = "WAMEN I";
  List<String> wamenList = ['WAMEN I', 'WAMEN II'];
  int totalCompany;
  bool isError = false;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
    if (widget.wamen != null) {
      currentWamen = widget.wamen;
      setState(() {});
    }
  }

  bool isDataReady() {
    bool summaryReady = true;
    if (widget.type == ClusterBumnPageType.HC_EMPLOYEE ||
        widget.type == ClusterBumnPageType.HC_DEKOM ||
        widget.type == ClusterBumnPageType.HC_BOD) {
      summaryReady = hcSummary != null;
    }
    return tableData != null && summaryReady;
  }

  void getData() async {
    try {
      setState(() {
        isError = false;
        this.hcSummary = null;
        this.tableData = null;
      });
      Map<String, List<GeneralCompany>> categorizedCompanies = {};
      List<GeneralCompany> companiesList;
      if (widget.type == ClusterBumnPageType.BUSINESS_PORTFOLIO) {
        companiesList = widget.store.state.companiesState.companies;
      } else {
        companiesList = await widget.hcController.fetchHcCompanies();
      }
      if (companiesList.isEmpty) throw Exception();

      companiesList.forEach((company) {
        if (!categorizedCompanies.containsKey(company.getCluster())) {
          categorizedCompanies[company.getCluster()] = [company];
        } else {
          categorizedCompanies[company.getCluster()] =
              categorizedCompanies[company.getCluster()]..add(company);
        }
      });

      if (widget.type == ClusterBumnPageType.HC_EMPLOYEE ||
          widget.type == ClusterBumnPageType.HC_DEKOM ||
          widget.type == ClusterBumnPageType.HC_BOD) {
        final hcSummary =
            await widget.hcController.fetchHcSummaryWamen(wamen: currentWamen);

        setState(() {
          this.hcSummary = hcSummary;
        });
      } else {
        final summary = await widget.companiesController
            .fetchWamenSummary(wamen: currentWamen);
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
      }

      setState(() {
        this.tableData = categorizedCompanies;
        this.totalCompany = companiesList.length;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        isError = true;
      });
    }
  }

  Widget companyList(BuildContext context) {
    final filteredData = tableData
        .sortBasedOnCount()
        .map((k, v) => MapEntry(k, v))
          ..removeWhere((k, v) => v.first.getWamen() != currentWamen);
    final List<ClusterBumnPageModel> convertedData = [];
    filteredData.keys.forEach(
      (cluster) {
        convertedData.add(
          ClusterBumnPageModel(
              cluster: cluster, total: filteredData[cluster].length),
        );
      },
    );
    print(widget.type);
    // print("hasil : ${filteredData.length.toString()}");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleListView<ClusterBumnPageModel>(
        colorPalette: widget.colorPalette,
        onItemTap: (ClusterBumnPageModel item) {
          ApiStatistic().insertStatistic("Business Portofolio",
              "List Detail Name Cluster ${item.cluster} Wamen 1/2 & Cluster ");
          widget.actionMapper
              .openDetailedJenisPage(item.getTitle(), widget.type);
        },
        items: convertedData,
        leadingWidget: (ClusterBumnPageModel item) => SumTypeText(
          colorPalette: widget.colorPalette,
          sum: item.total,
          sumText: 'BUMN',
        ),
      ),
    );
  }

  Widget filterWidget(BuildContext context) {
    List<GeneralCompany> data = tableData.values
        .toList()
        .fold([], (a, b) => a == null ? b : [...a, ...b]);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              setState(() {
                currentWamen = 'WAMEN I';
              });

              getData();
            },
            child: Container(
              decoration: BoxDecoration(
                color: currentWamen == 'WAMEN I'
                    ? Color(0xFF1FA4CA)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.0,
                    blurRadius: 4,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'res/images/ic_wamen_2.png',
                        height: 18.0,
                        color: currentWamen == 'WAMEN I'
                            ? Colors.white
                            : Color(0xFF1FA4CA),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'Wamen I',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: currentWamen == 'WAMEN I'
                              ? Colors.white
                              : Color(0xFF1FA4CA),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    data
                        .where((a) => a.getWamen() == 'WAMEN I')
                        .length
                        .toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'poppins',
                      color: currentWamen == 'WAMEN I'
                          ? Colors.white
                          : Color(0xFF1FA4CA),
                    ),
                  ),
                  Text(
                    'BUMN',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'poppins',
                      color: currentWamen == 'WAMEN I'
                          ? Colors.white
                          : Color(0xFF1FA4CA),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              setState(() {
                currentWamen = 'WAMEN II';
              });

              getData();
            },
            child: Container(
              decoration: BoxDecoration(
                color: currentWamen == 'WAMEN II'
                    ? Color(0xFF1FA4CA)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.0,
                    blurRadius: 4,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'res/images/ic_wamen_2.png',
                        color: currentWamen == 'WAMEN II'
                            ? Colors.white
                            : Color(0xFF1FA4CA),
                        height: 18.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'Wamen II',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: currentWamen == 'WAMEN II'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    data
                        .where((a) => a.getWamen() == 'WAMEN II')
                        .length
                        .toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'poppins',
                      color: currentWamen == 'WAMEN II'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Text(
                    'BUMN',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'poppins',
                      color: currentWamen == 'WAMEN II'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
    return FilterWidget(
      title: "Filter Wamen",
      items: wamenList,
      currentItem: currentWamen,
      onChanged: (wamen) {
        setState(() {
          currentWamen = wamen;
        });

        getData();
      },
    );
  }

  Widget businessSummaryWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        text: "Kinerja Keuangan",
        iconWidget: Image.asset(
          'res/images/ic_building.png',
          height: 35.0,
          color: Colors.white,
        ),
        color: Color(0xFFF19857),
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        children: <Widget>[
          BiggerCustomTable(
            colorPalette: widget.colorPalette,
            color: Color(0xffFF4200),
            title: "Akun",
            data: businessSummary,
            fontSize: isSmallDevice(context) ? 12.0 : 13.0,
          )
        ],
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
        return totalBOCSummary();
      case ClusterBumnPageType.HC_BOD:
        return totalBODSummary();
      default:
        return totalEmployeeSummary();
    }
  }

  Widget hcSummaryFilterWidget() {
    if (widget.type == ClusterBumnPageType.BUSINESS_PORTFOLIO) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 16.0,
          ),
          businessSummaryWidget(),
        ],
      );
    }
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

  Widget summaryWidget(BuildContext context) {
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

  Widget mainWidget(BuildContext context) {
    return Container(
      color: Color(0xFFEEEFF3),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          filterWidget(context),
          hcSummaryFilterWidget(),
          summaryWidget(context),
          SizedBox(
            height: 16.0,
          ),
          Center(
            child: Text(
              'Nama Cluster',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'poppins',
              ),
            ),
          ),
          companyList(context)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Wamen & Cluster',
      body: (ctx) => !isDataReady()
          ? isError
              ? CustomErrorWidget(
                  onRetry: () => getData(),
                )
              : LoadingWidget(
                  colorPalette: widget.colorPalette,
                )
          : mainWidget(context),
    );
  }
}
