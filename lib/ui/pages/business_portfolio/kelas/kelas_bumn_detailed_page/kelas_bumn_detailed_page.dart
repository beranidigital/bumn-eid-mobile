import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/general_company.dart';
import 'package:bumn_eid/core/models/business_portfolio/summary.dart';
import 'package:bumn_eid/core/models/hc/hc_summary.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/bigger_custom_table.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_expansion_tile.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_detailed_page/di/kelas_bumn_detailed_page_graph.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_detailed_page/kelas_bumn_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_page/kelas_bumn_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class KelasBumnDetailedPage extends StatefulWidget with InjectableWidget {
  final KelasBumnDetailedPageGraph _graph;

  final int kelas;
  final KelasBumnPageType type;

  //injected
  ColorPalette colorPalette;
  //injected
  CompaniesController companiesController;
  //injected
  HcController hcController;
  //injected
  KelasBumnDetailedActionMapper actionMapper;
  //injected
  Store<AppState> store;

  KelasBumnDetailedPage(
      {@required this.kelas,
      this.type = KelasBumnPageType.BUSINESS_PORTFOLIO,
      KelasBumnDetailedPageGraph graph})
      : this._graph = graph ?? KelasBumnDetailedPageGraph() {
    setup();
  }

  @override
  KelasBumnDetailedPageGraph graph() => _graph;

  @override
  _KelasBumnDetailedPageState createState() => _KelasBumnDetailedPageState();
}

class _KelasBumnDetailedPageState extends State<KelasBumnDetailedPage>
    with AfterLayoutMixin<KelasBumnDetailedPage> {
  bool isError = false;

  final optionsList = ["Total", "Gender", "Age"];

  String currentOption = "Total";

  HcSummary hcSummary;
  Map<String, List<Summary>> businessSummary;
  List<GeneralCompany> jenisPerusahaan = [];
  List<GeneralCompany> filteredProfilPerusahaan = [];
  TextEditingController _searchController = TextEditingController();

  bool isDataReady() {
    bool summaryReady = false;
    if (widget.type == KelasBumnPageType.HC_EMPLOYEE ||
        widget.type == KelasBumnPageType.HC_DEKOM ||
        widget.type == KelasBumnPageType.HC_BOD) {
      summaryReady = hcSummary != null;
    } else {
      summaryReady = businessSummary != null;
    }
    return jenisPerusahaan != null && summaryReady;
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
      if (widget.type == KelasBumnPageType.BUSINESS_PORTFOLIO) {
        companies = widget.store.state.companiesState.companies.toList()
          ..removeWhere((a) => a.kelasBumn != widget.kelas);
      } else {
        companies = await widget.hcController
            .fetchHcCompaniesByClass(kelas: widget.kelas.toString());
      }
      if (widget.type == KelasBumnPageType.BUSINESS_PORTFOLIO) {
        final businessSummary = await widget.companiesController
            .fetchKelasSummary(kelasName: widget.kelas.toString());
        Map<String, List<Summary>> summaries = {};

        businessSummary.forEach((item) {
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
        final hcSummary = await widget.hcController
            .fetchHcSummaryClass(kelas: widget.kelas.toString());

        setState(() {
          this.hcSummary = hcSummary;
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
    _searchController?.dispose();
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
        onItemTap: (GeneralCompany item) => widget.actionMapper
            .openCompanyDetailPage(item.getId(), widget.type),
        items: sortedCompanies,
      ),
    );
  }

  Widget businessSummaryWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        text: "Business Summary",
        icon: Icons.business_center,
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        children: <Widget>[
          BiggerCustomTable(
            colorPalette: widget.colorPalette,
            color: Color(0xffFF4200),
            title: "Akun",
            data: businessSummary,
            firstColumnWidth: 100,
            fontSize: 16.0,
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
              count: hcSummary.getLaki2(convertClassToSummaryType(widget.type)),
              color: Color(0xFF5FD0F3)),
        ),
        Expanded(
          child: summaryItem(
              key: "Perempuan",
              count: hcSummary
                  .getPerempuan(convertClassToSummaryType(widget.type)),
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
                      .getUmurA(convertClassToSummaryType(widget.type)),
                  color: Color(0xFF5FD0F3),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.getUmurAPercent(convertClassToSummaryType(widget.type)))}%",
                  height: 120),
            ),
            Expanded(
              child: summaryItem(
                  key: "Usia diantara 46-55",
                  count: hcSummary
                      .getUmurB(convertClassToSummaryType(widget.type)),
                  color: Color(0xffB934A4),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.getUmurBPercent(convertClassToSummaryType(widget.type)))}%",
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
                      .getUmurC(convertClassToSummaryType(widget.type)),
                  color: Color(0xFF76B758),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.getUmurCPercent(convertClassToSummaryType(widget.type)))}%"),
            ),
            Expanded(
              child: summaryItem(
                  key: "Usia diantara 26-35",
                  count: hcSummary
                      .getUmurD(convertClassToSummaryType(widget.type)),
                  color: Color(0xFFA8BFFF),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.getUmurDPercent(convertClassToSummaryType(widget.type)))}%"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            summaryItem(
                key: "Usia dibawah 25",
                count:
                    hcSummary.getUmurE(convertClassToSummaryType(widget.type)),
                textColor: Colors.black,
                color: Color(0xFFFFF1A8),
                contentTextSize: 14,
                extraData:
                    " | ${formatNumber(hcSummary.getUmurEPercent(convertClassToSummaryType(widget.type)))}%"),
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
      case KelasBumnPageType.HC_EMPLOYEE:
        return totalEmployeeSummary();
      case KelasBumnPageType.HC_DEKOM:
        return totalBOCSummary();
      case KelasBumnPageType.HC_BOD:
        return totalBODSummary();
      default:
        return totalEmployeeSummary();
    }
  }

  Widget hcSummaryFilterWidget() {
    if (widget.type == KelasBumnPageType.BUSINESS_PORTFOLIO) return Container();
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

  Widget hcSummaryWidget() {
    if (widget.type == KelasBumnPageType.BUSINESS_PORTFOLIO) return Container();

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
    return widget.type == KelasBumnPageType.HC_EMPLOYEE ||
            widget.type == KelasBumnPageType.HC_DEKOM ||
            widget.type == KelasBumnPageType.HC_BOD
        ? hcSummaryWidget()
        : businessSummaryWidget();
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
            child: ListView(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                children: [
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
      title: "BUMN Kelas ${widget.kelas}",
      body: (ctx) => mainWidget(context),
    );
  }
}
