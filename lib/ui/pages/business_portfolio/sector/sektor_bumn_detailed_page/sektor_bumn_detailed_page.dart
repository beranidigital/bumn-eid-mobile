import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/general_company.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/models/business_portfolio/summary.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/bigger_custom_table.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_expansion_tile.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/sector/sektor_bumn_detailed_page/di/sektor_bumn_detailed_page_graph.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/sector/sektor_bumn_detailed_page/sektor_bumn_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/sector/sektor_bumn_page/sektor_bumn_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class SektorBumnDetailedPage extends StatefulWidget with InjectableWidget {
  final SektorBumnDetailedPageGraph _graph;

  final SektorBumnPageType type;
  final String sektor;

  //injected
  ColorPalette colorPalette;
  //injected
  CompaniesController companiesController;
  //injected
  SektorBumnDetailedActionMapper actionMapper;
  //injected
  Store<AppState> store;

  SektorBumnDetailedPage(
      {@required this.sektor,
      @required this.type,
      SektorBumnDetailedPageGraph graph})
      : this._graph = graph ?? SektorBumnDetailedPageGraph() {
    setup();
  }

  @override
  SektorBumnDetailedPageGraph graph() => _graph;

  @override
  _SektorBumnDetailedPageState createState() => _SektorBumnDetailedPageState();
}

class _SektorBumnDetailedPageState extends State<SektorBumnDetailedPage>
    with AfterLayoutMixin<SektorBumnDetailedPage> {
  bool isError = false;

  Map<String, List<Summary>> summary;
  List<ProfilPerusahaan> jenisPerusahaan = [];
  List<ProfilPerusahaan> filteredProfilPerusahaan = [];
  TextEditingController _searchController = TextEditingController();

  bool isDataReady() {
    return jenisPerusahaan != null && summary != null;
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
      final companies = await widget.companiesController
          .fetchBpsSectorCompanies(sector: widget.sektor);
      final summary = await widget.companiesController
          .fetchSectorSummary(sectorName: widget.sektor);
      Map<String, List<Summary>> summaries = {};

      summary.forEach((item) {
        if (summaries.containsKey(item.jenisAkun)) {
          summaries[item.jenisAkun].add(item);
        } else {
          summaries[item.jenisAkun] = [item];
        }
      });
      setState(() {
        this.jenisPerusahaan = companies;
        this.summary = summaries;
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
      return company.nama.toLowerCase().contains(query.toLowerCase());
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

  Widget tableWidget(BuildContext context, List<ProfilPerusahaan> companies) {
    final sortedCompanies = companies.toList()
      ..sort((a, b) => a.nama.compareTo(b.nama));
    return CustomTable(
      colorPalette: widget.colorPalette,
      data: sortedCompanies.asMap().map((k, v) => MapEntry(v.nama, v)),
      headers: [TableText(text: "Nama Perusahaan", flexColumnWidth: 240)],
      showTriliun: false,
      rowDescriptor: (key, value) => TableRow(children: [
        cell(
          text: widget.store.getNamaPendek(value.nama),
          onTap: () =>
              widget.actionMapper.openCompanyDetailPage(value, widget.type),
        ),
      ]),
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
        onItemTap: (GeneralCompany item) =>
            widget.actionMapper.openCompanyDetailPage(item, widget.type),
        items: sortedCompanies,
      ),
    );
  }

  Widget summaryWidget(BuildContext context) {
    return widget.type == SektorBumnPageType.HC
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
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
                  data: summary,
                  firstColumnWidth: 100,
                  fontSize: 13.0,
                )
              ],
            ),
          );
  }

  Widget sectorTitle(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Text(
          widget.sektor,
          style: TextStyle(
              color: widget.colorPalette.black,
              fontSize: 24.0,
              fontWeight: FontWeight.w700),
        ));
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
                  sectorTitle(context),
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
      title: 'Sektor BUMN',
      body: (ctx) => mainWidget(context),
    );
  }
}
