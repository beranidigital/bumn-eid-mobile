import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/covid/covid_company_list.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_class/covid_by_class_detailed_page/covid_by_class_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_class/covid_by_class_detailed_page/di/covid_by_class_detailed_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class CovidByClassDetailedPage extends StatefulWidget with InjectableWidget {
  final CovidByClassDetailedPageGraph _graph;

  final int kelas;

  //injected
  ColorPalette colorPalette;
  //injected
  CompaniesController companiesController;
  //injected
  CovidController covidController;
  //injected
  CovidByClassDetailedActionMapper actionMapper;
  //injected
  Store<AppState> store;

  CovidByClassDetailedPage(
      {@required this.kelas, CovidByClassDetailedPageGraph graph})
      : this._graph = graph ?? CovidByClassDetailedPageGraph() {
    setup();
  }

  @override
  CovidByClassDetailedPageGraph graph() => _graph;

  @override
  _CovidByClassDetailedPageState createState() =>
      _CovidByClassDetailedPageState();
}

class _CovidByClassDetailedPageState extends State<CovidByClassDetailedPage>
    with AfterLayoutMixin<CovidByClassDetailedPage> {
  bool isError = false;

  List<CovidCompanyList> jenisPerusahaan = [];
  List<CovidCompanyList> filteredProfilPerusahaan = [];
  TextEditingController _searchController = TextEditingController();

  bool isDataReady() {
    return jenisPerusahaan != null && jenisPerusahaan.isNotEmpty;
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
      List<CovidCompanyList> companies = await widget.covidController
          .fetchCompaniesByClass(kelas: widget.kelas.toString());

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
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleListView<CovidCompanyList>(
        colorPalette: widget.colorPalette,
        onItemTap: (CovidCompanyList item) =>
            widget.actionMapper.openCompanyDetailPage(item.idAngka),
        items: sortedCompanies,
        leadingWidget: (CovidCompanyList item) => SumTypeText(
          percentage: true,
          colorPalette: widget.colorPalette,
          sum: item.jumlah,
          sumColor: item.getColor(),
        ),
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
            child: ListView(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                children: [
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
      title: "#CovidSafe BUMN Readiness Class ${widget.kelas}",
      body: (ctx) => mainWidget(context),
    );
  }
}
