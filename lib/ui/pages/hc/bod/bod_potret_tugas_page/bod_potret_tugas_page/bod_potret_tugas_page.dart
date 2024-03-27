import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/core/models/hc/grafik_potret_kerja.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_potret_tugas_page/bod_potret_tugas_page/bod_potret_tugas_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_potret_tugas_page/bod_potret_tugas_page/di/bod_potret_tugas_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BODPotretTugasPageData with Sortable {
  final int kategori;
  final double percentage;
  final int jumlah;

  BODPotretTugasPageData({
    @required this.kategori,
    @required this.percentage,
    @required this.jumlah,
  });

  @override
  num getNumber() {
    return percentage;
  }
}

// ignore: must_be_immutable
class BODPotretTugasPage extends StatefulWidget with InjectableWidget {
  final BODPotretTugasPageGraph _graph;
  final bool now;

  //injected
  ColorPalette colorPalette;
  //injected
  BODPotretTugasActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  BODPotretTugasPageGraph graph() => _graph;

  BODPotretTugasPage({this.now = false, BODPotretTugasPageGraph graph})
      : this._graph = graph ?? BODPotretTugasPageGraph() {
    setup();
  }

  @override
  _BODPotretTugasPageState createState() => _BODPotretTugasPageState();
}

class _BODPotretTugasPageState extends State<BODPotretTugasPage>
    with AfterLayoutMixin<BODPotretTugasPage> {
  Map<String, BODPotretTugasPageData> tableData;
  int total;
  GrafikPotretTugas data;
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
      final Map<String, BODPotretTugasPageData> tableData = {};
      final data = await widget.hcController
          .fetchGrafikPotretTugasDireksi(now: widget.now);

      final total = data.lessOneYear +
          data.oneTwoYears +
          data.twoThreeYears +
          data.threeFourYears +
          data.fourFiveYears;
      tableData["< 1 Tahun"] = BODPotretTugasPageData(
          kategori: 0,
          percentage: data.lessOneYear / total * 100,
          jumlah: data.lessOneYear);
      tableData["1-2 Tahun"] = BODPotretTugasPageData(
          kategori: 1,
          percentage: data.oneTwoYears / total * 100,
          jumlah: data.oneTwoYears);
      tableData["2-3 Tahun"] = BODPotretTugasPageData(
          kategori: 2,
          percentage: data.twoThreeYears / total * 100,
          jumlah: data.twoThreeYears);
      tableData["3-4 Tahun"] = BODPotretTugasPageData(
          kategori: 3,
          percentage: data.threeFourYears / total * 100,
          jumlah: data.threeFourYears);
      tableData["4-5 Tahun"] = BODPotretTugasPageData(
          kategori: 4,
          percentage: data.fourFiveYears / total * 100,
          jumlah: data.fourFiveYears);

      setState(() {
        this.data = data;
        this.tableData = tableData;
        this.total = total;
      });
    } catch (ex) {
      setState(() {
        isError = true;
      });
    }
  }

  Widget chartWidget(BuildContext context) {
    return CustomPieChart(
      colorPalette: widget.colorPalette,
      tableData: tableData.map((k, v) => MapEntry(k, [v])),
      customCountFunction: (data) => data.first.percentage.truncate(),
      customTotalCount: 100,
    );
  }

  Widget tableWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomTable(
        colorPalette: widget.colorPalette,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        data: tableData.sortBasedOnValue(),
        headers: [
          TableText(text: "Keterangan", flexColumnWidth: 130.0),
          TableText(
              text: "Kontribusi",
              type: TableTextType.NUMBER,
              flexColumnWidth: 100.0),
        ],
        showTriliun: false,
        rowDescriptor: (String key, BODPotretTugasPageData datum) =>
            TableRow(children: [
          cell(
              text: key,
              textAlign: TextAlign.start,
              onTap: () => widget.actionMapper
                  .openDetailedPage(datum.kategori, widget.now)),
          cell(text: formatNumber(datum.jumlah), textAlign: TextAlign.end),
        ]),
        total: tableData.values.fold(0, (a, b) => a + b.jumlah),
      ),
    );
  }

  Widget titleWidget(BuildContext context) {
    String title;
    if (widget.now) {
      title = "Potret Masa Tugas BOD Saat Ini";
    } else {
      title = "Potret Masa Tugas BOD 8 Tahun Terakhir";
    }
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
    );
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        titleWidget(context),
        chartWidget(context),
        tableWidget(context),
        LastUpdateWidget(
          store: StoreProvider.of<AppState>(context),
          pageName: "hc",
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "BOD",
      body: (ctx) => SafeArea(
        child: data == null
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
