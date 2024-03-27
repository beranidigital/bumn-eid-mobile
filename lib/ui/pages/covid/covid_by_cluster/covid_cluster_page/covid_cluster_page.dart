import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/covid/covid_cluster.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_page/covid_cluster_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_page/di/covid_cluster_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class CovidClusterPageModel with SingleListItem {
  final String cluster;
  final int total;
  final String lastChecked;

  CovidClusterPageModel({
    @required this.cluster,
    @required this.total,
    @required this.lastChecked,
  });

  @override
  String getTitle() {
    return cluster;
  }
}

// ignore: must_be_immutable
class CovidClusterPage extends StatefulWidget with InjectableWidget {
  final CovidClusterPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  CovidClusterActionMapper actionMapper;
  //injected
  HcController hcController;
  //injected
  CovidController covidController;
  //injected
  Store<AppState> store;

  @override
  CovidClusterPageGraph graph() => _graph;

  CovidClusterPage([type, graph])
      : this._graph = graph ?? CovidClusterPageGraph() {
    setup();
  }

  @override
  _CovidClusterPageState createState() => _CovidClusterPageState();
}

class _CovidClusterPageState extends State<CovidClusterPage>
    with AfterLayoutMixin<CovidClusterPage> {
  List<CovidCluster> tableData;
  String currentWamen = "WAMEN I";
  List<String> wamenList = ['WAMEN I', 'WAMEN II'];
  int totalCompany;
  bool isError = false;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return tableData != null;
  }

  void getData() async {
    try {
      setState(() {
        isError = false;
        this.tableData = null;
      });
      List<CovidCluster> companiesList =
          await widget.covidController.fetchCovidCluster();

      setState(() {
        this.tableData = companiesList;
        this.totalCompany = companiesList.length;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        isError = true;
      });
    }
  }

  Widget companyList(BuildContext context) {
    final filteredData = tableData.toList()
      ..removeWhere((k) => k.wamenBumn != currentWamen)
      ..sort((a, b) => b.jumlah.compareTo(a.jumlah));
    final List<CovidClusterPageModel> convertedData = [];
    filteredData.forEach((cluster) {
      convertedData.add(CovidClusterPageModel(
          cluster: cluster.clusterBumn,
          total: cluster.jumlah,
          lastChecked: cluster.lastReview));
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleListView<CovidClusterPageModel>(
        colorPalette: widget.colorPalette,
        onItemTap: (CovidClusterPageModel item) =>
            widget.actionMapper.openDetailedJenisPage(item.getTitle()),
        items: convertedData,
        total:
            convertedData.fold(0, (a, b) => a + b.total) / convertedData.length,
        totalPercentage: true,
        leadingWidget: (CovidClusterPageModel item) => SumTypeText(
          colorPalette: widget.colorPalette,
          sum: item.total,
          percentage: false,
          sumColor: widget.colorPalette.primary,
          sumText: "Last Reviewed",
          sumNotNumber: dateTimeToString(parseDateTime(item.lastChecked)),
        ),
      ),
    );
  }

  Widget filterWidget(BuildContext context) {
    return FilterWidget(
      title: "Filter Wamen",
      items: wamenList,
      currentItem: currentWamen,
      onChanged: (wamen) {
        setState(() {
          currentWamen = wamen;
        });
      },
    );
  }

  Widget mainWidget(BuildContext context) {
    return Container(
      color: Color(0xFFEEEFF3),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[filterWidget(context), companyList(context)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Cluster Covid BUMN',
      body: (ctx) => !isDataReady()
          ? isError
              ? CustomErrorWidget(
                  onRetry: () => getData(),
                )
              : LoadingWidget(
                  colorPalette: widget.colorPalette,
                )
          : mainWidget(context),
    );
  }
}
