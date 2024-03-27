import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/bod1_cluster.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_cluster/bod_1_cluster_page/bod_1_cluster_page_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_cluster/bod_1_cluster_page/di/bod_1_cluster_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class BOD1ClusterPage extends StatefulWidget with InjectableWidget {
  final BOD1ClusterPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  BOD1ClusterActionMapper actionMapper;
  //injected
  HcController hcController;
  //injected
  Store<AppState> store;

  @override
  BOD1ClusterPageGraph graph() => _graph;

  BOD1ClusterPage([graph]) : this._graph = graph ?? BOD1ClusterPageGraph() {
    setup();
  }

  @override
  _BOD1ClusterPageState createState() => _BOD1ClusterPageState();
}

class _BOD1ClusterPageState extends State<BOD1ClusterPage>
    with AfterLayoutMixin<BOD1ClusterPage> {
  TextEditingController _searchController = TextEditingController();

  bool isError = false;
  List<BOD1Cluster> data;

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
        this.isError = false;
      });
      List<BOD1Cluster> companies =
          await widget.hcController.fetchBOD1Cluster();

      setState(() {
        this.data = companies;
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

  Widget chartWidget(BuildContext context) {
    return CustomPieChart(
      tableData:
          data.asMap().map((k, v) => MapEntry("Cluster ${v.cluster}", [v])),
      colorPalette: widget.colorPalette,
      customCountFunction: (List data) => data.first.jumlahBOD1,
      customTotalCount: data.fold(0, (a, b) => a + b.jumlahBOD1),
      maxItemToShowLabel: 5,
    );
  }

  Widget tableWidget(BuildContext context, List<BOD1Cluster> companies) {
    final filteredCompanies = companies.toList()
      ..sort((a, b) => b.jumlahBOD1.compareTo(a.jumlahBOD1));
    return CustomTable(
      colorPalette: widget.colorPalette,
      headers: [
        TableText(text: "Nama Cluster", flexColumnWidth: 100),
        TableText(
            text: "Jumlah", flexColumnWidth: 75, type: TableTextType.NUMBER),
      ],
      data: filteredCompanies.asMap().map((k, v) => MapEntry(v.cluster, v)),
      showTriliun: false,
      rowDescriptor: (key, BOD1Cluster data) => TableRow(children: [
        cell(
          text: "Cluster ${data.cluster}",
          textAlign: TextAlign.start,
          onTap: () => widget.actionMapper
              .openClusterDetailedPage(cluster: data.cluster),
        ),
        cell(
          text: data.jumlahBOD1.toString(),
          textAlign: TextAlign.end,
        ),
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
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            children: [
                chartWidget(context),
                tableWidget(context, data),
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
