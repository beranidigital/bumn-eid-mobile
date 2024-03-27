import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_by_class.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_class_page/di/talent_pool_by_class_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_class_page/talent_pool_by_class_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TalentPoolByClassPage extends StatefulWidget with InjectableWidget {
  final TalentPoolByClassPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  TalentPoolByClassPageActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  TalentPoolByClassPageGraph graph() => _graph;

  TalentPoolByClassPage([graph])
      : this._graph = graph ?? TalentPoolByClassPageGraph() {
    setup();
  }

  @override
  _TalentPoolByClassPageState createState() => _TalentPoolByClassPageState();
}

class _TalentPoolByClassPageState extends State<TalentPoolByClassPage>
    with AfterLayoutMixin<TalentPoolByClassPage> {
  List<TalentPoolByClass> data;
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
      final data = await widget.hcController.fetchTalentPoolByClass();

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
      tableData:
          data.asMap().map((k, v) => MapEntry("Kelas ${v.kelasBumn}", [v])),
      colorPalette: widget.colorPalette,
      maxItemToShowLabel: 5,
      customCountFunction: (data) => data.first.jumlah,
      customTotalCount: data.fold(0, (a, b) => a + b.jumlah),
    );
  }

  Widget tableWidget(BuildContext context) {
    return CustomTable(
      data: data.asMap().map((k, v) => MapEntry(v.kelasBumn, v)),
      colorPalette: widget.colorPalette,
      headers: [
        TableText(text: "Kelas", flexColumnWidth: 100),
        TableText(
            text: "Jumlah Talent",
            type: TableTextType.NUMBER,
            flexColumnWidth: 100)
      ],
      showTriliun: false,
      rowDescriptor: (String key, TalentPoolByClass item) =>
          TableRow(children: [
        cell(
            text: "Kelas $key",
            onTap: () =>
                widget.actionMapper.openAdvanceFilter(kelas: item.kelasBumn)),
        cell(text: item.jumlah.toString(), textAlign: TextAlign.end),
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
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            children: <Widget>[
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
      title: "Talent Pool By Class",
      body: (ctx) => mainWidget(context),
    );
  }
}
