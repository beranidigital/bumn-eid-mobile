import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/csr/sektor_pk.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/strings/strings.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_page/di/sektor_penyaluran_page_graph.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_page/sektor_penyaluran_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class SektorPenyaluranPage extends StatefulWidget with InjectableWidget {
  final SektorPenyaluranPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  SektorPenyaluranActionMapper actionMapper;
  //injected
  CsrController csrController;
  //injected
  Store<AppState> store;

  @override
  SektorPenyaluranPageGraph graph() => _graph;

  SektorPenyaluranPage([graph])
      : this._graph = graph ?? SektorPenyaluranPageGraph() {
    setup();
  }

  @override
  _SektorPenyaluranPageState createState() => _SektorPenyaluranPageState();
}

class _SektorPenyaluranPageState extends State<SektorPenyaluranPage>
    with AfterLayoutMixin<SektorPenyaluranPage> {
  List<int> tahunList = Constants.tahunList;
  int currentTahun = int.parse(Constants.latestDataYear);
  List<SektorPk> data;
  Map<String, List<SektorPk>> filteredData;
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
      final companiesList = await widget.csrController.fetchSektorPkList();
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
    Map<String, List<SektorPk>> categorizedCompanies = {};
    data.forEach((company) {
      if (company.tahun != currentTahun) return;
      if (!categorizedCompanies.containsKey(company.sektor)) {
        categorizedCompanies[company.sektor] = [company];
      } else {
        categorizedCompanies[company.sektor]..add(company);
      }
    });

    setState(() {
      this.filteredData = categorizedCompanies;
    });
  }

  Widget chartWidget(BuildContext context) {
    // var nilai = filteredData.values.fold(
    //     0, (a, b) => a + b.fold(0, (c, d) => c + d.getJumlah().truncate()));
    // return Text("${nilai} --- ${filteredData.length}");
    return CustomPieChart<SektorPk>(
      tableData: filteredData,
      colorPalette: widget.colorPalette,
      maxItemToShowLabel: 3,
      customTotalCount: filteredData.values.fold(
          0, (a, b) => a + b.fold(0, (c, d) => c + d.getJumlah().truncate())),
      customCountFunction: (List items) =>
          items.fold(0, (a, b) => a + b.getJumlah().truncate()),
    );
  }

  Widget tableWidget(BuildContext context) {
    return CustomTable(
      data: filteredData.sortBasedOnValue(),
      colorPalette: widget.colorPalette,
      headers: [
        TableText(text: "Sektor", flexColumnWidth: 100),
        TableText(
            text: "Dana Tersalur (Miliar Rupiah)",
            type: TableTextType.NUMBER,
            flexColumnWidth: 100)
      ],
      showTriliun: false,
      rowDescriptor: (String key, List<SektorPk> items) {
        final jumlah =
            items.fold(0, (a, b) => a + b.getJumlah()) / Constants.billion;
        return TableRow(children: [
          cell(
              text: key,
              onTap: () {
                ApiStatistic().insertStatistic("CSR",
                    "Level 4 ${key.toString()} Sektor Penyaluran Program Kemitraan");
                widget.actionMapper.openDetailedJenisPage(key);
              }),
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

  Widget mainWidget(BuildContext context) {
    return Container(
      color: widget.colorPalette.defaultBg,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: <Widget>[
          filterWidget(context),
          chartWidget(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: tableWidget(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: Strings.getString("SektorPenyaluranPage.Title"),
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
