import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/bod1_company.dart';
import 'package:bumn_eid/core/models/hc/hc_summary.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_company/bod_1_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_company/di/bod_1_company_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class BOD1CompanyPage extends StatefulWidget with InjectableWidget {
  final BOD1CompanyPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  BOD1CompanyActionMapper actionMapper;
  //injected
  HcController hcController;
  //injected
  Store<AppState> store;

  @override
  BOD1CompanyPageGraph graph() => _graph;

  BOD1CompanyPage([graph]) : this._graph = graph ?? BOD1CompanyPageGraph() {
    setup();
  }

  @override
  _BOD1CompanyPageState createState() => _BOD1CompanyPageState();
}

class _BOD1CompanyPageState extends State<BOD1CompanyPage>
    with AfterLayoutMixin<BOD1CompanyPage> {
  TextEditingController _searchController = TextEditingController();

  bool isError = false;
  List<BOD1Company> data;
  List<BOD1Company> filteredData;
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
      List<BOD1Company> companies =
          await widget.hcController.fetchBOD1Companies();

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
      return company.companyName.toLowerCase().contains(query.toLowerCase());
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

  Widget tableWidget(BuildContext context, List<BOD1Company> companies) {
    final sortedCompanies = companies.toList()
      ..sort((a, b) => a.companyName.compareTo(b.companyName));
    return CustomTable(
      colorPalette: widget.colorPalette,
      headers: [TableText(text: "Nama Perusahaan", flexColumnWidth: 200)],
      data: sortedCompanies.asMap().map((k, v) => MapEntry(v.companyName, v)),
      showTriliun: false,
      rowDescriptor: (key, BOD1Company data) => TableRow(children: [
        cell(
          text: data.companyName,
          textAlign: TextAlign.start,
          onTap: () => widget.actionMapper.openCompanyDetailPage(id: data.id),
        ),
      ]),
    );
  }

  Widget companyList(BuildContext context, List<BOD1Company> companies) {
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
                companyList(
                    context, filteredData != null ? filteredData : data),
                LastUpdateWidget(
                  store: StoreProvider.of<AppState>(context),
                  pageName: "hc",
                )
              ]);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "BOD-1",
      body: (ctx) => mainWidget(context),
    );
  }
}
