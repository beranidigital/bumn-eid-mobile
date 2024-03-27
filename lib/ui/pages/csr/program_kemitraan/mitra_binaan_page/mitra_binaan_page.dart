import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/csr/jumlah_mitra.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_line_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/mitra_binaan_page/di/mitra_binaan_page_graph.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/mitra_binaan_page/mitra_binaan_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class MitraBinaanData with LineChartDataType {
  final int tahun;
  final int jumlah;

  MitraBinaanData({
    @required this.tahun,
    @required this.jumlah,
  });

  @override
  Color getColor() {
    return Colors.blue;
  }

  @override
  int getX() {
    return tahun;
  }

  @override
  double getY() {
    return jumlah.toDouble();
  }
}

// ignore: must_be_immutable
class MitraBinaanPage extends StatefulWidget with InjectableWidget {
  final MitraBinaanPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  MitraBinaanActionMapper actionMapper;
  //injected
  CsrController csrController;

  @override
  MitraBinaanPageGraph graph() => _graph;

  MitraBinaanPage({MitraBinaanPageGraph graph})
      : this._graph = graph ?? MitraBinaanPageGraph() {
    setup();
  }

  @override
  _MitraBinaanPageState createState() => _MitraBinaanPageState();
}

class _MitraBinaanPageState extends State<MitraBinaanPage>
    with AfterLayoutMixin<MitraBinaanPage> {
  final String semuaSektor = "Semua";

  String currentSektor;
  List<String> sektorList;
  List<JumlahMitra> data;
  Map<int, List<JumlahMitra>> filteredData;
  bool isError = false;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return filteredData != null && sektorList != null;
  }

  void getSektor(List<JumlahMitra> data) {
    List<String> sektorList = [semuaSektor];
    data.forEach((item) {
      if (!sektorList.contains(item.sektorUsaha))
        sektorList.add(item.sektorUsaha);
    });

    setState(() {
      this.sektorList = sektorList;
      this.currentSektor = semuaSektor;
    });
  }

  void getData() async {
    try {
      setState(() {
        isError = false;
      });
      final data = await widget.csrController.fetchJumlahMitra();
      getSektor(data);

      setState(() {
        this.data = data;
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
    Map<int, List<JumlahMitra>> chartData = {};
    data.forEach((grafikData) {
      if (currentSektor != semuaSektor &&
          grafikData.sektorUsaha != currentSektor) return;
      if (chartData.containsKey(grafikData.tahun)) {
        chartData[grafikData.tahun].add(grafikData);
      } else {
        chartData[grafikData.tahun] = [grafikData];
      }
    });

    setState(() {
      this.filteredData = sortBasedOnIntKey(chartData);
    });
  }

  Map<String, double> getMaxMin() {
    double max = -1;
    double min = 1000000000000;
    filteredData.values.forEach((list) {
      list.forEach((item) {
        if (item.totalMitra > max)
          max = item.totalMitra.toDouble();
        else if (item.totalMitra < min) min = item.totalMitra.toDouble();
      });
    });
    return {
      "max": max,
      "min": min,
    };
  }

  Widget chartWidget(BuildContext context) {
    final maxMin = getMaxMin();
    return CustomLineChart(
      colorPalette: widget.colorPalette,
      items: filteredData
          .map((k, v) {
            final jumlah = v.fold(0, (a, b) => a + b.totalMitra);
            return MapEntry(k, MitraBinaanData(tahun: k, jumlah: jumlah));
          })
          .values
          .toList(),
      intervalY:
          currentSektor == semuaSektor ? 100000 : getInterval(maxMin["max"]),
      bottomPadding: currentSektor == semuaSektor
          ? 100000
          : currentSektor == "Sektor Industri Kreatif"
              ? 0
              : getInterval(maxMin["min"]),
      topPadding:
          currentSektor == semuaSektor ? 50000 : getInterval(maxMin["max"]),
      leftPadding: 36.0,
    );
  }

  Widget tableWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomTable(
        colorPalette: widget.colorPalette,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        data: filteredData.map((k, v) {
          final jumlah = v.fold(0, (a, b) => a + b.totalMitra);
          return MapEntry(
              k.toString(), MitraBinaanData(tahun: k, jumlah: jumlah));
        }),
        headers: [
          TableText(text: "Tahun", flexColumnWidth: 90.0),
          TableText(
              text: "Jumlah Mitra Binaan",
              type: TableTextType.NUMBER,
              flexColumnWidth: 100.0)
        ],
        showTriliun: false,
        rowDescriptor: (String key, MitraBinaanData data) =>
            TableRow(children: [
          cell(
            text: key,
            textAlign: TextAlign.start,
          ),
          cell(text: formatNumber(data.jumlah), textAlign: TextAlign.end),
        ]),
      ),
    );
  }

  Widget filterWidget(BuildContext context) {
    return FilterWidget(
      items: sektorList,
      title: "Sektor",
      currentItem: currentSektor,
      onChanged: (newSektor) {
        setState(() {
          this.currentSektor = newSektor;
        });
        processData();
      },
    );
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        filterWidget(context),
        chartWidget(context),
        tableWidget(context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Jumlah Mitra Binaan',
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
