import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_by_company.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_company_page/di/talent_pool_by_company_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_company_page/talent_pool_by_company_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TalentPoolByCompanyPage extends StatefulWidget with InjectableWidget {
  final TalentPoolByCompanyPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  TalentPoolByCompanyPageActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  TalentPoolByCompanyPageGraph graph() => _graph;

  TalentPoolByCompanyPage([graph])
      : this._graph = graph ?? TalentPoolByCompanyPageGraph() {
    setup();
  }

  @override
  _TalentPoolByCompanyPageState createState() =>
      _TalentPoolByCompanyPageState();
}

class _TalentPoolByCompanyPageState extends State<TalentPoolByCompanyPage>
    with AfterLayoutMixin<TalentPoolByCompanyPage> {
  List<TalentPoolByCompany> data;
  List<TalentPoolByCompany> filteredData = [];
  TextEditingController _searchController = TextEditingController();

  bool isError = false;

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
        isError = false;
      });
      final data = await widget.hcController.fetchTalentPoolByCompany();

      setState(() {
        this.data = data;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        isError = true;
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
    return TextField(
      controller: _searchController,
      onChanged: (query) => filterCompany(query),
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          filled: true,
          labelText: "Cari perusahaan disini",
          hintText: "Masukkan nama perusahaan. e.g. Mandiri"),
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

  Widget tableWidget(BuildContext context) {
    final tableData = _searchController.text.isNotEmpty ? filteredData : data;
    if (tableData.isEmpty) return queryNotFoundError(context);
    return CustomTable(
      data: tableData.asMap().map((k, v) => MapEntry(v.namaLengkap, v)),
      colorPalette: widget.colorPalette,
      headers: [
        TableText(text: "Nama Perusahaan", flexColumnWidth: 100),
        TableText(
            text: "Jumlah Talent",
            type: TableTextType.NUMBER,
            flexColumnWidth: 100)
      ],
      showTriliun: false,
      rowDescriptor: (String key, TalentPoolByCompany item) =>
          TableRow(children: [
        cell(
            text: key,
            onTap: () =>
                widget.actionMapper.openAdvanceFilter(companyId: item.idAngka)),
        cell(text: item.jumlah.toString(), textAlign: TextAlign.end),
      ]),
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
        : ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[searchBar(context), tableWidget(context)],
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Talent Pool By Company',
      body: (ctx) => mainWidget(ctx),
    );
  }
}
