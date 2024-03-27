import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/csr/pkbl.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_list_bar_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/pages/csr/common/realisasi_dana_page/di/realisasi_dana_page_graph.dart';
import 'package:bumn_eid/ui/pages/csr/common/realisasi_dana_page/realisasi_dana_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class RealisasiPageModel with SingleListItem {
  final String year;
  final String data;

  RealisasiPageModel({@required this.year, @required this.data});

  @override
  String getTitle() {
    return year;
  }
}

enum RealisasiDanaType { PROGRAM_KEMITRAAN, BINA_LINGKUNGAN }

class RealisasiDanaData with ListBarChartDataType {
  final int tahun;
  final String jenis; //tersedia & tersalurkan
  final double jumlah;

  RealisasiDanaData({
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
class RealisasiDanaPage extends StatefulWidget with InjectableWidget {
  final RealisasiDanaPageGraph _graph;

  final RealisasiDanaType type;

  //injected
  ColorPalette colorPalette;
  //injected
  RealisasiDanaActionMapper actionMapper;
  //injected
  CsrController csrController;

  @override
  RealisasiDanaPageGraph graph() => _graph;

  RealisasiDanaPage({@required this.type, RealisasiDanaPageGraph graph})
      : this._graph = graph ?? RealisasiDanaPageGraph() {
    setup();
  }

  @override
  _RealisasiDanaPageState createState() => _RealisasiDanaPageState();
}

class _RealisasiDanaPageState extends State<RealisasiDanaPage>
    with AfterLayoutMixin<RealisasiDanaPage> {
  Map<int, List<RealisasiDanaData>> tableData;
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
      final data = await widget.csrController.fetchPkblSummary();
      data.sort((a, b) => a.tahun.compareTo(b.tahun));
      Map<int, List<RealisasiDanaData>> chartData = {};
      data.forEach((grafikData) {
        final tersedia = widget.type == RealisasiDanaType.PROGRAM_KEMITRAAN
            ? grafikData.pkTersedia
            : grafikData.blTersedia;
        final tersalurkan = widget.type == RealisasiDanaType.PROGRAM_KEMITRAAN
            ? grafikData.pkTersalurkan
            : grafikData.blTersalurkan;
        chartData[grafikData.tahun] = [
          RealisasiDanaData(
              tahun: grafikData.tahun,
              jenis: "Tersedia",
              jumlah: parseDouble(tersedia) / Constants.trillion),
          RealisasiDanaData(
              tahun: grafikData.tahun,
              jenis: "Tersalurkan",
              jumlah: parseDouble(tersalurkan) / Constants.trillion),
        ];
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

  Widget chartWidget(BuildContext context) {
    return CustomListBarChart(
      colorPalette: widget.colorPalette,
      data: tableData.map((k, v) {
        return MapEntry(k.toString(), v);
      }),
      intervalY: 1,
      leftPadding: 32,
      topPadding: 1,
      keyToColor: {
        "Tersedia": Color(0xFFFE8282),
        "Tersalurkan": Color(0xFFFBD300),
      },
    );
  }

  Widget tableWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomTable(
        colorPalette: widget.colorPalette,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        data: tableData.map((k, v) {
          MapEntry<String, Pkbl> mapEntry;
          if (widget.type == RealisasiDanaType.PROGRAM_KEMITRAAN) {
            mapEntry = MapEntry(
                k.toString(),
                Pkbl(
                  tahun: k,
                  pkTersedia: v
                      .firstWhere((a) => a.jenis == "Tersedia")
                      .jumlah
                      .toString(),
                  pkTersalurkan: v
                      .firstWhere((a) => a.jenis == "Tersalurkan")
                      .jumlah
                      .toString(),
                ));
          } else {
            mapEntry = MapEntry(
                k.toString(),
                Pkbl(
                  tahun: k,
                  blTersedia: v
                      .firstWhere((a) => a.jenis == "Tersedia")
                      .jumlah
                      .toString(),
                  blTersalurkan: v
                      .firstWhere((a) => a.jenis == "Tersalurkan")
                      .jumlah
                      .toString(),
                ));
          }
          return mapEntry;
        }),
        headers: [
          TableText(text: "Tahun", flexColumnWidth: 90.0),
          TableText(
              text: "Realisasi",
              type: TableTextType.NUMBER,
              flexColumnWidth: 130.0)
        ],
        showTriliun: true,
        rowDescriptor: (String key, Pkbl data) {
          String jumlah;
          if (widget.type == RealisasiDanaType.PROGRAM_KEMITRAAN) {
            final tersalurkan = formatNumber(parseDouble(data.pkTersalurkan));
            final tersedia = formatNumber(parseDouble(data.pkTersedia));
            final percentage = parseDouble(data.pkTersalurkan) /
                parseDouble(data.pkTersedia) *
                100;
            final percentageString = formatNumber(percentage);
            jumlah = "$tersalurkan/$tersedia ($percentageString%)";
          } else {
            final tersalurkan = formatNumber(parseDouble(data.blTersalurkan));
            final tersedia = formatNumber(parseDouble(data.blTersedia));
            final percentage = parseDouble(data.blTersalurkan) /
                parseDouble(data.blTersedia) *
                100;
            final percentageString = formatNumber(percentage);
            jumlah = "$tersalurkan/$tersedia ($percentageString%)";
          }
          return TableRow(children: [
            cell(
              text: key,
              textAlign: TextAlign.start,
            ),
            cell(text: jumlah, textAlign: TextAlign.end),
          ]);
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
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[chartWidget(context), tableWidget(context)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String title;
    if (widget.type == RealisasiDanaType.PROGRAM_KEMITRAAN) {
      title = "Realisasi Dana PK";
    } else {
      title = "Realisasi Dana BL";
    }
    return BaseScaffold(
      title: title,
      body: (ctx) => tableData == null
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
