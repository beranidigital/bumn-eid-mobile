import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/csr/bl_item_area.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bl_company_area/bl_company_area_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bl_company_area/di/bl_company_area_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class BlCompanyAreaPage extends StatefulWidget with InjectableWidget {
  final BlCompanyAreaPageGraph _graph;

  final String companyId;
  final String provinsi;

  //injected
  ColorPalette colorPalette;
  //injected
  BlCompanyAreaActionMapper actionMapper;
  //injected
  CsrController csrController;
  //injected
  Store<AppState> store;

  @override
  BlCompanyAreaPageGraph graph() => _graph;

  BlCompanyAreaPage(
      {@required this.companyId,
      @required this.provinsi,
      BlCompanyAreaPageGraph graph})
      : this._graph = graph ?? BlCompanyAreaPageGraph() {
    setup();
  }

  @override
  _BlCompanyAreaPageState createState() => _BlCompanyAreaPageState();
}

class _BlCompanyAreaPageState extends State<BlCompanyAreaPage>
    with AfterLayoutMixin<BlCompanyAreaPage> {
  List<int> tahunList = Constants.tahunList;
  int currentTahun = int.parse(Constants.latestDataYear);
  List<BlItemArea> data;
  Map<String, BlItemArea> filteredData;
  bool isError = false;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getData() async {
    try {
      setState(() {
        isError = false;
      });
      final companiesList = await widget.csrController.fetchBlItemByArea(
          companyId: widget.companyId, provinsi: widget.provinsi);
      if (companiesList.isEmpty) throw Exception();

      setState(() {
        this.data = companiesList;
      });

      processData();
    } catch (ex) {
      print(ex);
      setState(() {
        isError = true;
      });
    }
  }

  void processData() {
    Map<String, BlItemArea> categorizedCompanies = {};
    data.forEach((company) {
      if (company.tahun != currentTahun) return;
      if (!categorizedCompanies.containsKey(company.jenisBantuan)) {
        categorizedCompanies[company.jenisBantuan] = company;
      }
    });

    setState(() {
      this.filteredData = categorizedCompanies;
    });
  }

  Widget chartWidget(BuildContext context) {
    return filteredData.isEmpty
        ? Container()
        : CustomPieChart<BlItemArea>(
            tableData: filteredData.map((k, v) {
              return MapEntry(v.jenisBantuan, [v]);
            }),
            colorPalette: widget.colorPalette,
            maxItemToShowLabel: 3,
            customTotalCount: filteredData.values
                .fold(0, (a, b) => a + b.totalDana().truncate()),
            customCountFunction: (List items) {
              return items.first.totalDana().truncate();
            },
          );
  }

  Widget tableWidget(BuildContext context) {
    return filteredData.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: Text(
                "Data Tidak Tersedia",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          )
        : CustomTable(
            data: filteredData.sortBasedOnValue(),
            colorPalette: widget.colorPalette,
            headers: [
              TableText(text: "Jenis Bantuan", flexColumnWidth: 100),
              TableText(
                  text: "Dana Tersalur (Miliar Rupiah)",
                  type: TableTextType.NUMBER,
                  flexColumnWidth: 100),
            ],
            showTriliun: false,
            rowDescriptor: (String key, BlItemArea items) {
              final jumlah = items.totalDana() / Constants.billion;
              return TableRow(children: [
                cell(
                  text: key,
                ),
                cell(text: formatNumber(jumlah), textAlign: TextAlign.end),
              ]);
            },
          );
  }

  Widget filterWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: FilterWidget(
        items: tahunList.map((a) => a.toString()).toList(),
        title: "Tahun",
        currentItem: currentTahun.toString(),
        onChanged: (newTahun) {
          setState(() {
            this.currentTahun = int.parse(newTahun);
          });
          processData();
        },
      ),
    );
  }

  Widget titleWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Detail Provinsi ${widget.provinsi}",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        Text(
          widget.store.getNamaPendekById(widget.companyId),
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ],
    );
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      children: <Widget>[
        titleWidget(),
        filterWidget(context),
        chartWidget(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: tableWidget(context),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'BL Wilayah',
      body: (ctx) => filteredData == null
          ? isError
              ? CustomErrorWidget(
                  onRetry: () => getData(),
                )
              : LoadingWidget(colorPalette: widget.colorPalette)
          : mainWidget(context),
    );
  }
}
