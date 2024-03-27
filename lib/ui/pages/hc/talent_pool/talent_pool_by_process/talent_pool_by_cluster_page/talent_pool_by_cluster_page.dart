import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_by_cluster.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_cluster_page/di/talent_pool_by_cluster_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_cluster_page/talent_pool_by_cluster_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TalentPoolByClusterPage extends StatefulWidget with InjectableWidget {
  final TalentPoolByClusterPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  TalentPoolByClusterPageActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  TalentPoolByClusterPageGraph graph() => _graph;

  TalentPoolByClusterPage([graph])
      : this._graph = graph ?? TalentPoolByClusterPageGraph() {
    setup();
  }

  @override
  _TalentPoolByClusterPageState createState() =>
      _TalentPoolByClusterPageState();
}

class _TalentPoolByClusterPageState extends State<TalentPoolByClusterPage>
    with AfterLayoutMixin<TalentPoolByClusterPage> {
  String currentWamen = "WAMEN I";
  List<String> wamenList = ['WAMEN I', 'WAMEN II'];

  List<TalentPoolByCluster> data;
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
      final data = await widget.hcController.fetchTalentPoolByCluster();

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

  Widget chartWidget(BuildContext context) {
    return CustomPieChart(
      tableData: data.asMap().map((k, v) => MapEntry(v.clusterBumn, [v])),
      colorPalette: widget.colorPalette,
      maxItemToShowLabel: 5,
      customCountFunction: (data) => data.first.jumlah,
      customTotalCount: data.fold(0, (a, b) => a + b.jumlah),
    );
  }

  Widget tableWidget(BuildContext context) {
    final filteredData =
        data.where((e) => e.wamenBumn == currentWamen).toList();
    return CustomTable(
      data: filteredData.asMap().map((k, v) => MapEntry(v.clusterBumn, v)),
      colorPalette: widget.colorPalette,
      headers: [
        TableText(text: "Cluster", flexColumnWidth: 100),
        TableText(
            text: "Jumlah Talent",
            type: TableTextType.NUMBER,
            flexColumnWidth: 100)
      ],
      showTriliun: false,
      rowDescriptor: (String key, TalentPoolByCluster item) =>
          TableRow(children: [
        cell(
            text: key,
            onTap: () => widget.actionMapper
                .openAdvanceFilter(cluster: item.clusterBumn)),
        cell(text: item.jumlah.toString(), textAlign: TextAlign.end),
      ]),
    );
  }

  Widget filterWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FilterWidget(
        title: "Filter Wamen",
        items: wamenList,
        currentItem: currentWamen,
        onChanged: (wamen) {
          setState(() {
            currentWamen = wamen;
          });
        },
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
      title: "Talent Pool By Cluster",
      body: (ctx) => mainWidget(context),
    );
  }
}
