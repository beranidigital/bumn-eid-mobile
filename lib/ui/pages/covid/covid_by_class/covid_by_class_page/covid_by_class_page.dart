import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/covid/covid_kelas.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/utils.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_class/covid_by_class_page/covid_by_class_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_class/covid_by_class_page/di/covid_by_class_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class CovidByClassPageModel with SingleListItem {
  final String kelas;
  final int total;

  CovidByClassPageModel({@required this.kelas, @required this.total});

  @override
  String getTitle() {
    return kelas;
  }
}

// ignore: must_be_immutable
class CovidByClassPage extends StatefulWidget with InjectableWidget {
  final CovidByClassPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  CovidByClassActionMapper actionMapper;
  //injected
  HcController hcController;
  //injected
  CovidController covidController;
  //injected
  Store<AppState> store;

  @override
  CovidByClassPageGraph graph() => _graph;

  CovidByClassPage({CovidByClassPageGraph graph})
      : this._graph = graph ?? CovidByClassPageGraph() {
    setup();
  }

  @override
  _CovidByClassPageState createState() => _CovidByClassPageState();
}

class _CovidByClassPageState extends State<CovidByClassPage>
    with AfterLayoutMixin<CovidByClassPage> {
  List<CovidKelas> tableData;
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
      List<CovidKelas> companiesList =
          await widget.covidController.fetchCovidKelas();

      setState(() {
        this.tableData = companiesList;
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
      tableData: tableData.asMap().map((k, v) => MapEntry(v.kelasBumn, [v])),
      colorPalette: widget.colorPalette,
      maxItemToShowLabel: 5,
      customCountFunction: (listData) {
        if (listData == null || listData.isEmpty) return 0;
        return listData.first.jumlah;
      },
      customTotalCount: tableData.fold(0, (a, b) => a + b.jumlah),
    );
  }

  Widget companyList(BuildContext context) {
    final List<CovidByClassPageModel> convertedData = [];
    tableData.forEach((data) {
      convertedData.add(CovidByClassPageModel(
          kelas: "Kelas ${data.kelasBumn}", total: data.jumlah));
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleListView<CovidByClassPageModel>(
        colorPalette: widget.colorPalette,
        onItemTap: (CovidByClassPageModel item) =>
            widget.actionMapper.openDetailedJenisPage(item.getTitle()),
        items: convertedData,
        total:
            convertedData.fold(0, (a, b) => a + b.total) / convertedData.length,
        totalPercentage: true,
        leadingWidget: (CovidByClassPageModel item) => SumTypeText(
          colorPalette: widget.colorPalette,
          sum: item.total,
          percentage: true,
          sumColor: getColorByJumlah(item.total),
        ),
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return Container(
      color: widget.colorPalette.defaultBg,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: <Widget>[
          chartWidget(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: companyList(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "#CovidSafe BUMN Readiness By Class",
      body: (ctx) => tableData == null
          ? isError
              ? CustomErrorWidget(
                  onRetry: () => getData(),
                )
              : LoadingWidget(colorPalette: widget.colorPalette)
          : mainWidget(context),
    );
  }
}
