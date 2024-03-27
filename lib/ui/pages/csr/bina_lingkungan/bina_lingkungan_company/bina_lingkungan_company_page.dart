import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/csr/csr_company.dart';
import 'package:bumn_eid/core/models/hc/hc_summary.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bina_lingkungan_company/bina_lingkungan_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bina_lingkungan_company/di/bina_lingkungan_company_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class BLCompanyPage extends StatefulWidget with InjectableWidget {
  final BLCompanyPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  BLCompanyActionMapper actionMapper;
  //injected
  CsrController csrController;
  //injected
  Store<AppState> store;

  @override
  BLCompanyPageGraph graph() => _graph;

  BLCompanyPage([graph]) : this._graph = graph ?? BLCompanyPageGraph() {
    setup();
  }

  @override
  _BLCompanyPageState createState() => _BLCompanyPageState();
}

class _BLCompanyPageState extends State<BLCompanyPage>
    with AfterLayoutMixin<BLCompanyPage> {
  TextEditingController _searchController = TextEditingController();

  bool isError = false;
  List<CsrCompany> data;
  List<CsrCompany> filteredData;
  HcSummary hcSummary;

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
      List<CsrCompany> companies =
          await widget.csrController.fetchPkCompanies();

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
      final nama = company.namaPendek ?? company.nama;
      return nama.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      this.filteredData = filtered;
    });
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: _searchController,
        onChanged: (query) => filterCompany(query),
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            filled: true,
            labelText: "Cari perusahaan disini",
            hintText: "Masukkan nama perusahaan. e.g. Mandiri"),
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

  Widget tableWidget(BuildContext context, List<CsrCompany> companies) {
    final sortedCompanies = companies.toList()
      ..sort((a, b) {
        final aName = a.namaPendek ?? a.nama;
        final bName = b.namaPendek ?? b.nama;
        return aName.compareTo(bName);
      });
    return CustomTable(
      colorPalette: widget.colorPalette,
      headers: [TableText(text: "Nama Perusahaan", flexColumnWidth: 200)],
      data: sortedCompanies.asMap().map((k, v) => MapEntry(v.namaPendek, v)),
      showTriliun: false,
      rowDescriptor: (key, CsrCompany data) => TableRow(children: [
        cell(
          text: data.namaPendek ?? data.nama,
          textAlign: TextAlign.start,
          onTap: () {
            ApiStatistic().insertStatistic("CSR",
                "Level 4 ${data.id} Company BL By Company Bina Lingkungan");
            widget.actionMapper.openCompanyDetailPage(id: data.id);
          },
        ),
      ]),
    );
  }

  Widget companyList(BuildContext context, List<CsrCompany> companies) {
    if (companies.isEmpty) return queryNotFoundError(context);

    return tableWidget(context, companies);
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
        : ListView(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            children: [
                searchBar(context),
                companyList(context, filteredData != null ? filteredData : data)
              ]);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Bina Lingkungan',
      body: (ctx) => mainWidget(context),
    );
  }
}
