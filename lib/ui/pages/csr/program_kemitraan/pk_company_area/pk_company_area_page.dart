import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/csr/pk_item_area.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/pk_company_area/di/pk_company_area_page_graph.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/pk_company_area/pk_company_area_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class PkCompanyAreaPage extends StatefulWidget with InjectableWidget {
  final PkCompanyAreaPageGraph _graph;

  final String companyId;
  final String provinsi;

  //injected
  ColorPalette colorPalette;
  //injected
  PkCompanyAreaActionMapper actionMapper;
  //injected
  CsrController csrController;
  //injected
  Store<AppState> store;

  @override
  PkCompanyAreaPageGraph graph() => _graph;

  PkCompanyAreaPage(
      {@required this.companyId,
      @required this.provinsi,
      PkCompanyAreaPageGraph graph})
      : this._graph = graph ?? PkCompanyAreaPageGraph() {
    setup();
  }

  @override
  _PkCompanyAreaPageState createState() => _PkCompanyAreaPageState();
}

class _PkCompanyAreaPageState extends State<PkCompanyAreaPage>
    with AfterLayoutMixin<PkCompanyAreaPage> {
  List<int> tahunList = Constants.tahunList;
  int currentTahun = int.parse(Constants.latestDataYear);
  List<PkItemArea> data;
  Map<String, PkItemArea> filteredData;
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
      final companiesList = await widget.csrController.fetchPkItemByArea(
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
    Map<String, PkItemArea> categorizedCompanies = {};
    data.forEach((company) {
      if (company.tahun != currentTahun) return;
      if (!categorizedCompanies.containsKey(company.sektorUsaha)) {
        categorizedCompanies[company.sektorUsaha] = company;
      }
    });

    setState(() {
      this.filteredData = categorizedCompanies;
    });
  }

  Widget chartWidget(BuildContext context) {
    return CustomPieChart<PkItemArea>(
      tableData: filteredData.map((k, v) {
        return MapEntry(v.sektorUsaha, [v]);
      }),
      colorPalette: widget.colorPalette,
      maxItemToShowLabel: 3,
      customTotalCount:
          filteredData.values.fold(0, (a, b) => a + b.totalDana().truncate()),
      customCountFunction: (List items) {
        return items.first.totalDana().truncate();
      },
    );
  }

  Widget keteranganWidget() {
    final totalMitra = filteredData.values.fold(0, (a, b) => a + b.totalMitra);
    final totalRealisasi =
        filteredData.values.fold(0, (a, b) => a + b.totalDana()) /
            Constants.billion;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Total Mitra:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    totalMitra.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Total Realisasi: ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "${formatNumber(totalRealisasi)} Miliar",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tableWidget(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: CustomTable(
        width: MediaQuery.of(context).size.width * 2,
        data: filteredData.sortBasedOnValue(),
        colorPalette: widget.colorPalette,
        headers: [
          TableText(text: "Sektor", flexColumnWidth: 100),
          TableText(
              text: "Dana Tersalur (Miliar Rupiah)",
              type: TableTextType.NUMBER,
              flexColumnWidth: 100),
          TableText(
              text: "Lancar", type: TableTextType.NUMBER, flexColumnWidth: 100),
          TableText(
              text: "Kurang Lancar",
              type: TableTextType.NUMBER,
              flexColumnWidth: 100),
          TableText(
              text: "Diragukan",
              type: TableTextType.NUMBER,
              flexColumnWidth: 100),
          TableText(
              text: "Macet", type: TableTextType.NUMBER, flexColumnWidth: 100),
        ],
        showTriliun: false,
        rowDescriptor: (String key, PkItemArea items) {
          final jumlah = items.totalDana() / Constants.billion;
          final lancar = parseDouble(items.lancar) / Constants.billion;
          final kurangLancar =
              parseDouble(items.kurangLancar) / Constants.billion;
          final diragukan = parseDouble(items.diragukan) / Constants.billion;
          final macet = parseDouble(items.macet) / Constants.billion;
          return TableRow(children: [
            cell(
              text: key,
            ),
            cell(text: formatNumber(jumlah), textAlign: TextAlign.end),
            cell(text: formatNumber(lancar), textAlign: TextAlign.end),
            cell(text: formatNumber(kurangLancar), textAlign: TextAlign.end),
            cell(text: formatNumber(diragukan), textAlign: TextAlign.end),
            cell(text: formatNumber(macet), textAlign: TextAlign.end),
          ]);
        },
      ),
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
        keteranganWidget(),
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
      title: "PK Wilayah",
      body: (ctx) => SafeArea(
        child: filteredData == null
            ? isError
                ? CustomErrorWidget(
                    onRetry: () => getData(),
                  )
                : LoadingWidget(colorPalette: widget.colorPalette)
            : mainWidget(context),
      ),
    );
  }
}
