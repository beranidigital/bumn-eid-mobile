import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/bod1_company.dart';
import 'package:bumn_eid/core/models/hc/hc_summary.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_kelas/bod_1_kelas_detailed/bod_1_kelas_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_kelas/bod_1_kelas_detailed/di/bod_1_kelas_detailed_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class BOD1KelasDetailedPage extends StatefulWidget with InjectableWidget {
  final BOD1KelasDetailedPageGraph _graph;
  final String kelas;

  //injected
  ColorPalette colorPalette;
  //injected
  BOD1KelasDetailedActionMapper actionMapper;
  //injected
  HcController hcController;
  //injected
  Store<AppState> store;

  @override
  BOD1KelasDetailedPageGraph graph() => _graph;

  BOD1KelasDetailedPage(this.kelas, [graph])
      : this._graph = graph ?? BOD1KelasDetailedPageGraph() {
    setup();
  }

  @override
  _BOD1KelasDetailedPageState createState() => _BOD1KelasDetailedPageState();
}

class _BOD1KelasDetailedPageState extends State<BOD1KelasDetailedPage>
    with AfterLayoutMixin<BOD1KelasDetailedPage> {
  TextEditingController _searchController = TextEditingController();

  bool isError = false;
  List<BOD1Company> data;
  List<BOD1Company> filteredData;
  HcSummary hcSummary;
  final optionsList = ["Total", "Gender", "Age"];

  String currentOption = "Total";

  bool isDataReady() {
    return data != null && hcSummary != null;
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
      List<BOD1Company> companies = await widget.hcController
          .fetchBOD1CompaniesByClass(kelas: widget.kelas);
      HcSummary summary = await widget.hcController
          .fetchHcSummary(filter: "kelas", query: widget.kelas);

      setState(() {
        this.data = companies;
        this.hcSummary = summary;
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

  void filterKelasDetailed(String query) {
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
        onChanged: (query) => filterKelasDetailed(query),
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

  Widget title() {
    return Text(
      "Kelas ${widget.kelas}",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    );
  }

  Widget genderSummary() {
    return Row(
      children: <Widget>[
        Expanded(
          child: summaryItem(
              key: "Laki-Laki",
              count: hcSummary.bod1Laki,
              color: Color(0xFF5FD0F3)),
        ),
        Expanded(
          child: summaryItem(
              key: "Perempuan",
              count: hcSummary.bod1Perempuan,
              color: Color(0xFFFFACAC)),
        ),
      ],
    );
  }

  Widget ageSummary() {
    final total = hcSummary.umurA +
        hcSummary.umurB +
        hcSummary.umurC +
        hcSummary.umurD +
        hcSummary.umurE;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: summaryItem(
                  key: "Usia diatas 56",
                  count: hcSummary.bod1UmurA,
                  color: Color(0xFF5FD0F3),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.bod1UmurA / total * 100)}%",
                  height: 120),
            ),
            Expanded(
              child: summaryItem(
                  key: "Usia diantara 46-55",
                  count: hcSummary.bod1UmurB,
                  color: Color(0xffB934A4),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.bod1UmurB / total * 100)}%",
                  height: 120),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: summaryItem(
                  key: "Usia diantara 36-45",
                  count: hcSummary.bod1UmurC,
                  color: Color(0xFF76B758),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.bod1UmurC / total * 100)}%"),
            ),
            Expanded(
              child: summaryItem(
                  key: "Usia diantara 26-35",
                  count: hcSummary.bod1UmurD,
                  color: Color(0xFFA8BFFF),
                  contentTextSize: 14,
                  extraData:
                      " | ${formatNumber(hcSummary.bod1UmurD / total * 100)}%"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            summaryItem(
                key: "Usia dibawah 25",
                count: hcSummary.bod1UmurE,
                textColor: Colors.black,
                color: Color(0xFFFFF1A8),
                contentTextSize: 14,
                extraData:
                    " | ${formatNumber(hcSummary.bod1UmurE / total * 100)}%"),
          ],
        ),
      ],
    );
  }

  Widget totalSummary() {
    return Row(
      children: <Widget>[
        Expanded(
          child: summaryItem(
            key: "Total",
            count: hcSummary.bod1Total,
          ),
        ),
      ],
    );
  }

  Widget hcSummaryFilterWidget() {
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
        withTitle: false,
      ),
    );
  }

  Widget hcSummaryWidget() {
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
        : ListView(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            children: [
                title(),
                hcSummaryFilterWidget(),
                hcSummaryWidget(),
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
