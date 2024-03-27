import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/general_company.dart';
import 'package:bumn_eid/core/models/hc/anggaran.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_list_bar_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/employee/realisasi_learning_page/di/realisasi_learning_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/employee/realisasi_learning_page/realisasi_learning_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class RealisasiLearningData with ListBarChartDataType {
  final int tahun;
  final String jenis; //rencana & realisasi
  final double jumlah;

  RealisasiLearningData({
    @required this.tahun,
    @required this.jenis,
    @required this.jumlah,
  });

  @override
  String getColorKey() {
    return jenis;
  }

  @override
  int getX() {
    return tahun;
  }

  @override
  double getY() {
    return jumlah;
  }
}

// ignore: must_be_immutable
class RealisasiLearningPage extends StatefulWidget with InjectableWidget {
  final RealisasiLearningPageGraph _graph;

  final GeneralCompany company;

  //injected
  ColorPalette colorPalette;
  //injected
  RealisasiLearningActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  RealisasiLearningPageGraph graph() => _graph;

  RealisasiLearningPage(
      {@required this.company, RealisasiLearningPageGraph graph})
      : this._graph = graph ?? RealisasiLearningPageGraph() {
    setup();
  }

  @override
  _RealisasiLearningPageState createState() => _RealisasiLearningPageState();
}

class _RealisasiLearningPageState extends State<RealisasiLearningPage>
    with AfterLayoutMixin<RealisasiLearningPage> {
  Map<int, List<RealisasiLearningData>> chartData;
  List<Anggaran> tableData;
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
      final data = await widget.hcController
          .fetchAnggaranLearningByCompany(companyId: widget.company.getId());
      data.sort((a, b) => a.tahun.compareTo(b.tahun));
      Map<int, List<RealisasiLearningData>> chartData = {};
      data.forEach((grafikData) {
        double rencana;
        try {
          rencana = double.parse(grafikData.rencana);
        } catch (ex) {
          rencana = 0;
        }
        double realisasi;
        try {
          realisasi = double.parse(grafikData.realisasi);
        } catch (ex) {
          rencana = 0;
        }
        chartData[grafikData.tahun] = [
          RealisasiLearningData(
              tahun: grafikData.tahun, jenis: "Rencana", jumlah: rencana),
          RealisasiLearningData(
              tahun: grafikData.tahun, jenis: "Realisasi", jumlah: realisasi),
        ];
      });

      setState(() {
        this.chartData = chartData;
        this.tableData = data;
      });
    } catch (ex) {
      setState(() {
        isError = true;
      });
    }
  }

  Widget chartWidget(BuildContext context) {
    return CustomListBarChart(
      colorPalette: widget.colorPalette,
      data: chartData.map((k, v) {
        return MapEntry(k.toString(), v);
      }),
      intervalY: 1000,
      leftPadding: 32,
      topPadding: 500,
      keyToColor: {
        "Rencana": Color(0xFFFE8282),
        "Realisasi": Color(0xFFFBD300),
      },
    );
  }

  Widget tableWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "* Data Dalam Triliun Rupiah",
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          ),
          CustomTable(
            colorPalette: widget.colorPalette,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            data: tableData
                .asMap()
                .map((k, v) => MapEntry(v.tahun.toString(), v)),
            headers: [
              TableText(text: "Tahun", flexColumnWidth: 90.0),
              TableText(
                  text: "Rencana",
                  type: TableTextType.NUMBER,
                  flexColumnWidth: 130.0),
              TableText(
                  text: "Realisasi",
                  type: TableTextType.NUMBER,
                  flexColumnWidth: 130.0),
            ],
            showTriliun: false,
            rowDescriptor: (String key, Anggaran data) {
              double rencanaInt;
              try {
                rencanaInt = double.parse(data.rencana);
              } catch (ex) {
                rencanaInt = 0;
              }
              double realisasiInt;
              try {
                realisasiInt = double.parse(data.realisasi);
              } catch (ex) {
                realisasiInt = 0;
              }
              final rencana = rencanaInt;
              final realisasi = realisasiInt;
              final percent = realisasi / rencana * 100;
              return TableRow(children: [
                cell(
                  text: key,
                  textAlign: TextAlign.start,
                ),
                cell(text: formatNumber(rencana), textAlign: TextAlign.end),
                cell(
                    text:
                        "${formatNumber(realisasi)} (${percent.toStringAsFixed(2)}%)",
                    textAlign: TextAlign.end),
              ]);
            },
          ),
        ],
      ),
    );
  }

  Widget companyName() {
    return Text(
      widget.company.getShortName(),
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    );
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        companyName(),
        chartWidget(context),
        tableWidget(context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Realisasi Learning",
      body: (ctx) => SafeArea(
        child: chartData == null
            ? isError
                ? CustomErrorWidget(
                    customText: "Data Tidak Tersedia",
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
