import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/covid/covid_company_list.dart';
import 'package:bumn_eid/core/models/hc/hc_summary.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/covid/covid_company_list/covid_company_list_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_company_list/di/covid_company_list_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class CovidCompanyListPage extends StatefulWidget with InjectableWidget {
  final CovidCompanyListPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  CovidCompanyListActionMapper actionMapper;
  //injected
  CovidController covidController;
  //injected
  Store<AppState> store;

  @override
  CovidCompanyListPageGraph graph() => _graph;

  CovidCompanyListPage([type, graph])
      : this._graph = graph ?? CovidCompanyListPageGraph() {
    setup();
  }

  @override
  _CovidCompanyListPageState createState() => _CovidCompanyListPageState();
}

class _CovidCompanyListPageState extends State<CovidCompanyListPage>
    with AfterLayoutMixin<CovidCompanyListPage> {
  TextEditingController _searchController = TextEditingController();

  bool isError = false;
  List<CovidCompanyList> data;
  List<CovidCompanyList> filteredData;
  HcSummary hcSummary;

  List<String> sortByList = ["Ready", "Almost Ready", "Not Ready", "No Sort"];
  String currentSort = "No Sort";

  bool isDataReady() {
    return data != null;
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
      List<CovidCompanyList> companies =
          await widget.covidController.fetchCompanies();

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
      return company.namaLengkap.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      this.filteredData = filtered;
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

  Widget filterWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: FilterWidget(
        width: 120,
        title: "Sort By",
        items: sortByList,
        currentItem: currentSort,
        onChanged: (newSort) {
          setState(() {
            this.currentSort = newSort;
          });
        },
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

  Widget companyList(BuildContext context, List<CovidCompanyList> companies) {
    if (companies.isEmpty) return queryNotFoundError(context);
    final filteredCompanies = companies.toList()
      ..removeWhere((company) {
        switch (currentSort) {
          case "Ready":
            return company.jumlah < 100;
          case "Almost Ready":
            return company.jumlah < 80 || company.jumlah >= 100;
          case "Not Ready":
            return company.jumlah >= 80;
          default:
            return false;
        }
      });
    final sortedCompanies = filteredCompanies.toList()
      ..sort((a, b) => b.jumlah.compareTo(a.jumlah));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleListView<CovidCompanyList>(
        colorPalette: widget.colorPalette,
        onItemTap: (CovidCompanyList item) =>
            widget.actionMapper.openCompanyDetailPage(item.idAngka),
        items: sortedCompanies,
        totalText: "Rata-Rata",
        total: sortedCompanies.fold(0, (a, b) => a + b.jumlah) /
            sortedCompanies.length,
        totalPercentage: true,
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
            color: Color(0xFFEEEFF3),
            child: ListView(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: searchBar(context)),
                      filterWidget()
                    ],
                  ),
                  companyList(
                      context, filteredData != null ? filteredData : data)
                ]),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "#CovidSafe BUMN Readiness By Company",
      body: (ctx) => mainWidget(context),
    );
  }
}
