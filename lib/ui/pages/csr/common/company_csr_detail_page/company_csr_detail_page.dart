import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/models/csr/csr_item.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/csr/common/company_csr_detail_page/company_csr_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/common/company_csr_detail_page/di/company_csr_detail_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class CompanyCsrDetailPage extends StatefulWidget with InjectableWidget {
  final CompanyCsrDetailPageGraph _graph;

  final String id;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;
  //injected
  CsrController csrController;
  //injected
  CompanyCsrDetailActionMapper actionMapper;

  CompanyCsrDetailPage({@required this.id, CompanyCsrDetailPageGraph graph})
      : this._graph = graph ?? CompanyCsrDetailPageGraph() {
    setup();
  }

  @override
  CompanyCsrDetailPageGraph graph() => _graph;

  @override
  _CompanyCsrDetailPageState createState() => _CompanyCsrDetailPageState();
}

class _CompanyCsrDetailPageState extends State<CompanyCsrDetailPage>
    with AfterLayoutMixin<CompanyCsrDetailPage> {
  bool isError = false;

  List<int> tahunList = Constants.tahunList;
  int currentTahun = int.parse(Constants.latestDataYear);
  List<CsrItem> data;
  List<CsrItem> filteredData;
  ProfilPerusahaan company;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return company != null && data != null;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      final fetchedCompany = widget.store.state.companiesState.companies
          .firstWhere((a) => a.id == widget.id);
      final data = await widget.csrController
          .fetchCsrDetail(tahun: "2019", companyId: widget.id);
      final data2018 = await widget.csrController
          .fetchCsrDetail(tahun: "2018", companyId: widget.id);
      final data2017 = await widget.csrController
          .fetchCsrDetail(tahun: "2017", companyId: widget.id);

      data..addAll(data2018)..addAll(data2017);

      setState(() {
        this.company = fetchedCompany;
        this.data = data;
      });

      processData();
    } catch (ex) {
      print(ex.toString());
      setState(() {
        this.isError = true;
      });
    }
  }

  void processData() {
    List<CsrItem> filteredData = [];
    data.forEach((item) {
      if (item.tahun != currentTahun) return;
      filteredData.add(item);
    });

    setState(() {
      this.filteredData = filteredData;
    });
  }

  Widget companyImage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 84.0,
      width: 84.0,
      child: CachedNetworkImage(
        imageUrl: company.logo,
        placeholder: (context, _) => CircularProgressIndicator(
          valueColor:
              new AlwaysStoppedAnimation<Color>(widget.colorPalette.primary),
        ),
      ),
    );
  }

  Widget emptyText() {
    return Center(
      child: Text(
        "Data tidak ditemukan",
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget tableWidget(BuildContext context) {
    if (filteredData.length == 0) return emptyText();
    return CustomTable(
      data: filteredData.asMap().map((k, v) => MapEntry(v.bentukCsr, v)),
      colorPalette: widget.colorPalette,
      headers: [
        TableText(text: "Bentuk CSR", flexColumnWidth: 100),
      ],
      showTriliun: false,
      rowDescriptor: (String key, CsrItem item) {
        return TableRow(children: [
          cell(
              text: key,
              onTap: () => widget.actionMapper.openCsrItemPage(item)),
        ]);
      },
    );
  }

  Widget filterWidget(BuildContext context) {
    return FilterWidget(
      items: tahunList.map((a) => a.toString()).toList(),
      title: "Tahun",
      currentItem: currentTahun.toString(),
      onChanged: (newTahun) {
        setState(() {
          this.currentTahun = int.parse(newTahun);
        });
        processData();
      },
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
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              companyImage(context),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Center(
                  child: Text(
                    company.nama,
                    style: TextStyle(
                        color: widget.colorPalette.black, fontSize: 18.0),
                  ),
                ),
              ),
              filterWidget(context),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: tableWidget(context),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Detail CSR BUMN",
      body: (ctx) => mainWidget(context),
    );
  }
}
