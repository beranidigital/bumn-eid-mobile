import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/csr/bl_item.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran/di/jenis_penyebaran_page_graph.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran/jenis_penyebaran_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class JenisPenyebaranPage extends StatefulWidget with InjectableWidget {
  final JenisPenyebaranPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  JenisPenyebaranActionMapper actionMapper;
  //injected
  CsrController csrController;
  //injected
  Store<AppState> store;

  @override
  JenisPenyebaranPageGraph graph() => _graph;

  JenisPenyebaranPage([graph])
      : this._graph = graph ?? JenisPenyebaranPageGraph() {
    setup();
  }

  @override
  _JenisPenyebaranPageState createState() => _JenisPenyebaranPageState();
}

class _JenisPenyebaranPageState extends State<JenisPenyebaranPage>
    with AfterLayoutMixin<JenisPenyebaranPage> {
  List<int> tahunList = Constants.tahunList;
  int currentTahun = int.parse(Constants.latestDataYear);
  List<BlItem> data;
  Map<String, List<BlItem>> filteredData;
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
      final companiesList = await widget.csrController.fetchJenisBantuan();
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
    Map<String, List<BlItem>> categorizedCompanies = {};
    data.forEach((company) {
      if (company.tahun != currentTahun) return;
      if (!categorizedCompanies.containsKey(company.jenisBantuan)) {
        categorizedCompanies[company.jenisBantuan] = [company];
      } else {
        categorizedCompanies[company.jenisBantuan]..add(company);
      }
    });

    setState(() {
      this.filteredData = categorizedCompanies;
    });
  }

  Widget chartWidget(BuildContext context) {
    return CustomPieChart<BlItem>(
      tableData: filteredData,
      colorPalette: widget.colorPalette,
      maxItemToShowLabel: 3,
      customTotalCount: filteredData.values.fold(
          0, (a, b) => a + b.fold(0, (c, d) => c + d.totalDana().truncate())),
      customCountFunction: (List items) =>
          items.fold(0, (a, b) => a + b.totalDana().truncate()),
    );
  }

  Widget tableWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "* Data dalam Miliar rupiah",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
          ),
        ),
        CustomTable(
          data: filteredData.sortBasedOnValue(),
          colorPalette: widget.colorPalette,
          headers: [
            TableText(text: "Bantuan", flexColumnWidth: 100),
            TableText(
                text: "Dana Tersalur",
                type: TableTextType.NUMBER,
                flexColumnWidth: 100)
          ],
          margin: EdgeInsets.zero,
          showTriliun: false,
          rowDescriptor: (String key, List<BlItem> items) {
            final jumlah =
                items.fold(0, (a, b) => a + b.totalDana().truncate()) /
                    Constants.billion;
            return TableRow(children: [
              cell(
                  text: key,
                  onTap: () {
                    ApiStatistic().insertStatistic(
                        "CSR", "Level 4 $key Jenis Bantuan Bina Lingkungan");
                    widget.actionMapper.openDetailedJenisPage(key);
                  }),
              cell(text: formatNumber(jumlah), textAlign: TextAlign.end),
            ]);
          },
        ),
      ],
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
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      children: <Widget>[
        filterWidget(context),
        chartWidget(context),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: tableWidget(context),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Jenis Bantuan',
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
