import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/finance/grafik_suspi.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/finance/loan/suspi/suspi_graph_page/di/suspi_graph_page_graph.dart';
import 'package:bumn_eid/ui/pages/finance/loan/suspi/suspi_graph_page/suspi_graph_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class SuspiGraphPageModel with SingleListItem {
  final GrafikSuspi model;
  final String jenisAkun;
  final num total;

  SuspiGraphPageModel(
      {@required this.model, @required this.jenisAkun, @required this.total});

  @override
  String getTitle() {
    return jenisAkun;
  }
}

// ignore: must_be_immutable
class SuspiGraphPage extends StatefulWidget with InjectableWidget {
  final SuspiGraphPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  SuspiGraphActionMapper actionMapper;
  //injected
  FinanceController financeController;

  @override
  SuspiGraphPageGraph graph() => _graph;

  SuspiGraphPage([graph]) : this._graph = graph ?? SuspiGraphPageGraph() {
    setup();
  }

  @override
  _SuspiGraphPageState createState() => _SuspiGraphPageState();
}

class _SuspiGraphPageState extends State<SuspiGraphPage>
    with AfterLayoutMixin<SuspiGraphPage> {
  String currentTahun = Constants.latestDataYear;
  List<String> tahunList =
      Constants.tahunList.map((e) => e.toString()).toList();

  Map<int, List<GrafikSuspi>> tableData;
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
      final data = await widget.financeController.fetchGrafikSuspi();
      final Map<int, List<GrafikSuspi>> chartData = {};
      data.forEach((datum) {
        if (chartData.containsKey(datum.tahun)) {
          chartData[datum.tahun]..add(datum);
        } else {
          chartData[datum.tahun] = [datum];
        }
      });

      setState(() {
        this.tableData = chartData;
      });
    } catch (ex) {
      setState(() {
        isError = true;
      });
    }
  }

  Widget filterWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterWidget(
        title: "Tahun Periode",
        currentItem: currentTahun,
        items: tahunList,
        onChanged: (tahun) {
          setState(() {
            currentTahun = tahun;
          });
        },
      ),
    );
  }

  Widget tableWidget(BuildContext context) {
    final tahun = parseInt(currentTahun);
    final sortedData = tableData[tahun]
        .asMap()
        .map((key, value) => MapEntry(value.jenisAkun, value))
        .sortBasedOnValue();

    final List<SuspiGraphPageModel> convertedData = [];
    sortedData.values.forEach((datum) {
      if (datum != null)
        convertedData.add(SuspiGraphPageModel(
            model: datum,
            jenisAkun: datum.jenisAkun,
            total: parseDouble(datum.jumlah) / Constants.million));
    });

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "* Dalam Triliun Rupiah",
            style: TextStyle(fontSize: 16.0),
          ),
          SingleListView<SuspiGraphPageModel>(
            colorPalette: widget.colorPalette,
            onItemTap: (SuspiGraphPageModel item) {
              ApiStatistic().insertStatistic("Finance",
                  "List Detail Liabilitas ket ${item.jenisAkun} Debt");
              widget.actionMapper.openDetailedJenisPage(item.model);
            },
            items: convertedData,
            leadingWidget: (SuspiGraphPageModel item) => SumTypeText(
              colorPalette: widget.colorPalette,
              sum: item.total,
            ),
          ),
        ],
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return Container(
      color: widget.colorPalette.defaultBg,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[filterWidget(context), tableWidget(context)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Detail Liabilitas',
      body: (ctx) => SafeArea(
        child: tableData == null
            ? isError
                ? CustomErrorWidget(
                    onRetry: () => getData(),
                  )
                : LoadingWidget(
                    colorPalette: widget.colorPalette,
                  )
            : mainWidget(context),
      ),
    );
  }
}
