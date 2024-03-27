import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/jenis_perusahaan.dart';
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
import 'package:bumn_eid/ui/pages/business_portfolio/jenis/jenis_bumn_detailed_page/di/jenis_bumn_detailed_page_graph.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/jenis/jenis_bumn_detailed_page/jenis_bumn_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class JenisBumnDetailedPage extends StatefulWidget with InjectableWidget {
  final JenisBumnDetailedPageGraph _graph;

  final String jenisBumn;

  //injected
  ColorPalette colorPalette;
  //injected
  JenisController jenisController;
  //injected
  JenisBumnDetailedActionMapper actionMapper;
  //injected
  Store<AppState> store;

  JenisBumnDetailedPage(
      {@required this.jenisBumn, JenisBumnDetailedPageGraph graph})
      : this._graph = graph ?? JenisBumnDetailedPageGraph() {
    setup();
  }

  @override
  JenisBumnDetailedPageGraph graph() => _graph;

  @override
  _JenisBumnDetailedPageState createState() => _JenisBumnDetailedPageState();
}

class _JenisBumnDetailedPageState extends State<JenisBumnDetailedPage> {
  bool isError = false;

  Map<String, List<Summary>> summary;
  List<JenisPerusahaan> jenisPerusahaan;
  List<JenisPerusahaan> filteredJenisPerusahaan;
  TextEditingController _searchController = TextEditingController();

  bool isDataReady() {
    return jenisPerusahaan != null && summary != null;
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      final companies =
          await widget.jenisController.fetchJenis(jenisBumn: widget.jenisBumn);
      final summary = await widget.jenisController
          .fetchJenisSummary(type: widget.jenisBumn);
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
      this.filteredJenisPerusahaan = filtered;
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

  Widget tableWidget(BuildContext context, List<JenisPerusahaan> data) {
    return CustomTable(
      colorPalette: widget.colorPalette,
      data: data.asMap().map((k, v) => MapEntry(v.nama, v)),
      headers: [TableText(text: "Nama Perusahaan", flexColumnWidth: 240)],
      showTriliun: false,
      rowDescriptor: (key, value) => TableRow(children: [
        cell(
          text: widget.store.getNamaPendek(value.nama),
          onTap: () => widget.actionMapper.openCompanyDetailPage(value),
          textAlign: TextAlign.start,
        ),
      ]),
    );
  }

  Widget companyList(BuildContext context, List<JenisPerusahaan> companies) {
    if (companies.isEmpty) return queryNotFoundError(context);
    final sortedCompanies = companies.toList()
      ..sort((a, b) => a.nama.compareTo(b.nama));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleListView<JenisPerusahaan>(
        colorPalette: widget.colorPalette,
        onItemTap: (JenisPerusahaan item) =>
            widget.actionMapper.openCompanyDetailPage(item),
        items: sortedCompanies,
      ),
    );
  }

  Widget summaryWidget(BuildContext context) {
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
            data: summary,
            firstColumnWidth: 100,
            fontSize: 12.0,
          )
        ],
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
            child: ListView(padding: const EdgeInsets.all(16.0), children: [
              summaryWidget(context),
              searchBar(context),
              companyList(
                  context,
                  _searchController.text.isNotEmpty
                      ? filteredJenisPerusahaan
                      : jenisPerusahaan)
            ]),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "BUMN ${widget.jenisBumn}",
      body: (ctx) => mainWidget(ctx),
    );
  }
}
