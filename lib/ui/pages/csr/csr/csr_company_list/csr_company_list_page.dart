import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/redux/actions/companies/companies_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/pages/csr/csr/csr_company_list/csr_company_list_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/csr/csr_company_list/di/csr_company_list_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class CsrCompanyListPage extends StatefulWidget with InjectableWidget {
  final CsrCompanyListPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  CsrCompanyListActionMapper actionMapper;
  //injected
  JenisController jenisController;
  //injected
  Store<AppState> store;

  @override
  CsrCompanyListPageGraph graph() => _graph;

  CsrCompanyListPage([graph])
      : this._graph = graph ?? CsrCompanyListPageGraph() {
    setup();
  }

  @override
  _CsrCompanyListPageState createState() => _CsrCompanyListPageState();
}

class _CsrCompanyListPageState extends State<CsrCompanyListPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController?.dispose();
    super.dispose();
  }

  Widget searchBar(BuildContext context) {
    return SearchBar(
      colorPalette: ColorPalette(),
      controller: _searchController,
      onChanged: (query) =>
          widget.store.dispatch(FilterTotalCompaniesAction(query: query)),
      labelText: "Cari perusahaan disini",
      hintText: "Masukkan nama perusahaan. e.g. Mandiri",
    );
  }

  Widget dataEmptyError(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: Text(
          "Mohon maaf, data tidak tersedia. Silakan tutup lalu buka kembali aplikasi ini.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
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

  Widget tableWidget(BuildContext context, List<ProfilPerusahaan> companies) {
    final sortedCompanies = companies.toList()
      ..sort((a, b) => a.nama.compareTo(b.nama));
    return SingleListView(
      colorPalette: ColorPalette(),
      items: sortedCompanies,
      onItemTap: (data) {
        ApiStatistic().insertStatistic(
            "CSR", "Level 3 ${data.toString()} Detail BUMN CSR Summary");
        widget.actionMapper.openCompanyDetailPage(data);
      },
    );
  }

  Widget companyList(BuildContext context, List<ProfilPerusahaan> companies) {
    if (companies.isEmpty) return queryNotFoundError(context);

    return tableWidget(context, companies);
  }

  Widget mainWidget(BuildContext context) {
    return StoreConnector<AppState, List<ProfilPerusahaan>>(
      converter: (store) => _searchController.text.isEmpty
          ? store.state.companiesState.companies
          : store.state.companiesState.filteredTotalCompanies,
      builder: (context, companies) {
        return companies.isEmpty && _searchController.text.isEmpty
            ? dataEmptyError(context)
            : ListView(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                children: [
                    searchBar(context),
                    SizedBox(
                      height: 16.0,
                    ),
                    companyList(context, companies)
                  ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'CSR By Company',
      body: (ctx) => mainWidget(context),
    );
  }
}
