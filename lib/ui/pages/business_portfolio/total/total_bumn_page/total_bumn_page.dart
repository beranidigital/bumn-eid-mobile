import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/general_company.dart';
import 'package:bumn_eid/core/models/hc/hc_summary.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_filter.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/total/total_bumn_page/di/total_bumn_page_graph.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/total/total_bumn_page/total_bumn_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

enum TotalBumnPageType { BUSINESS_PORTFOLIO, HC_EMPLOYEE, HC_DEKOM, HC_BOD }

// ignore: must_be_immutable
class TotalBumnPage extends StatefulWidget with InjectableWidget {
  final TotalBumnPageGraph _graph;

  final TotalBumnPageType type;

  //injected
  ColorPalette colorPalette;
  //injected
  TotalBumnActionMapper actionMapper;
  //injected
  HcController hcController;
  //injected
  Store<AppState> store;

  @override
  TotalBumnPageGraph graph() => _graph;

  TotalBumnPage([type, graph])
      : this._graph = graph ?? TotalBumnPageGraph(),
        this.type = type ?? TotalBumnPageType.BUSINESS_PORTFOLIO {
    setup();
  }

  @override
  _TotalBumnPageState createState() => _TotalBumnPageState();
}

class _TotalBumnPageState extends State<TotalBumnPage>
    with AfterLayoutMixin<TotalBumnPage> {
  TextEditingController _searchController = TextEditingController();

  final optionsList = ["Total", "Gender", "Age"];

  String currentOption = "Total";

  bool isError = false;
  List<GeneralCompany> data;
  List<GeneralCompany> filteredData;
  HcSummary hcSummary;

  bool isDataReady() {
    bool hcSummaryCheck = true;
    if (widget.type == TotalBumnPageType.HC_EMPLOYEE ||
        widget.type == TotalBumnPageType.HC_DEKOM ||
        widget.type == TotalBumnPageType.HC_BOD)
      hcSummaryCheck = hcSummary != null;
    return data != null && hcSummaryCheck;
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
      List<GeneralCompany> companies;
      if (widget.type == TotalBumnPageType.BUSINESS_PORTFOLIO) {
        companies = widget.store.state.companiesState.companies;
      } else {
        companies = await widget.hcController.fetchHcCompanies();
      }

      if (widget.type == TotalBumnPageType.HC_EMPLOYEE ||
          widget.type == TotalBumnPageType.HC_DEKOM ||
          widget.type == TotalBumnPageType.HC_BOD) {
        final summary = await widget.hcController.fetchHcSummary();
        setState(() {
          this.hcSummary = summary;
        });
      }

      setState(() {
        this.data = companies;
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
    _searchController?.dispose();
    super.dispose();
  }

  void filterCompany(String query) {
    if (data.isEmpty) return;
    final filtered = data.where((company) {
      return company.getShortName().toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      this.filteredData = filtered;
    });
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pencarian',
            style: TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          SearchBar(
            colorPalette: widget.colorPalette,
            controller: _searchController,
            onChanged: (query) => filterCompany(query),
            labelText: "",
            hintText: "Masukkan nama perusahaan.",
          ),
        ],
      ),
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
              "Detail Company ${item.getName()} Total BUMN");
          widget.actionMapper.openCompanyDetailPage(item.getId(), widget.type);
        },
        items: sortedCompanies.where((a) {
          final wamen =
              currentWamen == null ? true : a.getWamen() == currentWamen;
          final kelas = currentKelas == null
              ? true
              : a.getKelas() == currentKelas.split(' ').last;
          final cluster =
              currentCluster == null ? true : a.getCluster() == currentCluster;
          return wamen && kelas && cluster;
        }).toList(),
      ),
    );
  }

  Widget genderSummary() {
    return Row(
      children: <Widget>[
        Expanded(
          child: summaryItem(
              key: "Laki-Laki",
              count: hcSummary.getLaki2(convertToSummaryType(widget.type)),
              color: Color(0xFF5FD0F3)),
        ),
        Expanded(
          child: summaryItem(
              key: "Perempuan",
              count: hcSummary.getPerempuan(convertToSummaryType(widget.type)),
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
                  count: hcSummary.getUmurA(convertToSummaryType(widget.type)),
                  color: Color(0xFF5FD0F3),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.getUmurAPercent(convertToSummaryType(widget.type)))}%",
                  height: 120),
            ),
            Expanded(
              child: summaryItem(
                  key: "Usia diantara 46-55",
                  count: hcSummary.getUmurB(convertToSummaryType(widget.type)),
                  color: Color(0xffB934A4),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.getUmurBPercent(convertToSummaryType(widget.type)))}%",
                  height: 120),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: summaryItem(
                  key: "Usia diantara 36-45",
                  count: hcSummary.getUmurC(convertToSummaryType(widget.type)),
                  color: Color(0xFF76B758),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.getUmurCPercent(convertToSummaryType(widget.type)))}%"),
            ),
            Expanded(
              child: summaryItem(
                  key: "Usia diantara 26-35",
                  count: hcSummary.getUmurD(convertToSummaryType(widget.type)),
                  color: Color(0xFFA8BFFF),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.getUmurDPercent(convertToSummaryType(widget.type)))}%"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            summaryItem(
                key: "Usia dibawah 25",
                count: hcSummary.getUmurE(convertToSummaryType(widget.type)),
                textColor: Colors.black,
                color: Color(0xFFFFF1A8),
                contentTextSize: 14,
                extraData:
                    " | ${formatNumber(hcSummary.getUmurEPercent(convertToSummaryType(widget.type)))}%"),
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
      case TotalBumnPageType.HC_EMPLOYEE:
        return totalEmployeeSummary();
      case TotalBumnPageType.HC_DEKOM:
        return totalBOCSummary();
      case TotalBumnPageType.HC_BOD:
        return totalBODSummary();
      default:
        return totalEmployeeSummary();
    }
  }

  String currentWamen;
  String currentKelas;
  String currentCluster;

  Widget filterWidget() {
    if (widget.type == TotalBumnPageType.BUSINESS_PORTFOLIO) {
      return BaseFilter(
        companiesList: data,
        onWamenChanged: (a) {
          print('AB $a');
          setState(() {
            this.currentWamen = a;
          });
        },
        onKelasChanged: (a) {
          setState(() {
            this.currentKelas = a;
          });
        },
        onClusterChanged: (a) {
          setState(() {
            this.currentCluster = a;
          });
        },
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
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

  Widget summaryWidget() {
    if (widget.type == TotalBumnPageType.BUSINESS_PORTFOLIO) return Container();

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
    return !isDataReady()
        ? isError
            ? CustomErrorWidget(
                onRetry: () => getData(),
              )
            : LoadingWidget(
                colorPalette: widget.colorPalette,
              )
        : Container(
            color: Color(0xFFEEEFF3),
            child: ListView(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              children: [
                filterWidget(),
                summaryWidget(),
                searchBar(context),
                companyList(
                  context,
                  filteredData != null ? filteredData : data,
                )
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'BUMN',
      body: (ctx) => mainWidget(context),
    );
  }
}
