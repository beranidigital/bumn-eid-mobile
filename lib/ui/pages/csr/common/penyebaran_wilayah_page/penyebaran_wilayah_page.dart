import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_page/di/penyebaran_wilayah_page_graph.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_page/penyebaran_wilayah_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum PenyebaranWilayahType { PROGRAM_KEMITRAAN, BINA_LINGKUNGAN }

mixin PenyebaranWilayahDataType {
  int getTahun();
  String getPropinsi();
  num getTotal();
  LatLng getLatLng();
  String getJenis();
}

// ignore: must_be_immutable
class PenyebaranWilayahPage extends StatefulWidget with InjectableWidget {
  final PenyebaranWilayahPageGraph _graph;

  final PenyebaranWilayahType type;

  //injected
  ColorPalette colorPalette;
  //injected
  PenyebaranWilayahActionMapper actionMapper;
  //injected
  CsrController csrController;

  @override
  PenyebaranWilayahPageGraph graph() => _graph;

  PenyebaranWilayahPage({@required this.type, PenyebaranWilayahPageGraph graph})
      : this._graph = graph ?? PenyebaranWilayahPageGraph() {
    setup();
  }

  @override
  _PenyebaranWilayahPageState createState() => _PenyebaranWilayahPageState();
}

class _PenyebaranWilayahPageState extends State<PenyebaranWilayahPage>
    with AfterLayoutMixin<PenyebaranWilayahPage> {
  List<int> tahunList = Constants.tahunList;
  int currentTahun = int.parse(Constants.latestDataYear);
  List<PenyebaranWilayahDataType> data;
  Map<String, PenyebaranWilayahDataType> filteredData;
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
      List<PenyebaranWilayahDataType> companiesList;
      if (widget.type == PenyebaranWilayahType.PROGRAM_KEMITRAAN) {
        companiesList = await widget.csrController.fetchPenyebaranPkList();
      } else {
        companiesList = await widget.csrController.fetchPenyebaranBlList();
      }
      if (companiesList.isEmpty) throw Exception();

      setState(() {
        this.data = companiesList;
      });

      processData();
    } catch (ex) {
      setState(() {
        isError = true;
      });
    }
  }

  void processData() {
    Map<String, PenyebaranWilayahDataType> categorizedCompanies = {};
    data.forEach((company) {
      if (company.getTahun() != currentTahun) return;
      categorizedCompanies[company.getPropinsi()] = company;
    });

    setState(() {
      this.filteredData = categorizedCompanies;
    });
  }

  Widget mapWidget(BuildContext context) {
    return Container(
      height: 200.0,
      child: GoogleMap(
        initialCameraPosition: Constants.indonesiaCameraPosition,
        markers: filteredData.values
            .map((item) => Marker(
                  markerId: MarkerId(item.getPropinsi()),
                  position: item.getLatLng(),
                  infoWindow: InfoWindow(
                      title: item.getPropinsi(),
                      snippet:
                          "Jumlah: ${formatNumber(item.getTotal() / Constants.billion)} Miliar"),
                ))
            .toSet(),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer(),
          ),
        ].toSet(),
      ),
    );
  }

  Widget tableWidget(BuildContext context) {
    final data = filteredData.sortBasedOnValue();
    final total = data.values.fold(0, (a, b) => a + b.getTotal());
    return CustomTable(
      data: data,
      colorPalette: widget.colorPalette,
      headers: [
        TableText(text: "Provinsi", flexColumnWidth: 100),
        TableText(
            text: "Keterangan",
            type: TableTextType.NUMBER,
            flexColumnWidth: 100)
      ],
      showTriliun: false,
      rowDescriptor: (String key, PenyebaranWilayahDataType item) {
        final jumlah = item.getTotal();
        double percentage = (jumlah / total) * 100;
        return TableRow(children: [
          cell(
              text: key,
              onTap: () {
                ApiStatistic().insertStatistic("CSR",
                    "Level 4 ${key} Penyebaran Wilayah Bina Lingkungan/Program Kemitraan");
                widget.actionMapper.openDetailedPage(
                    type: widget.type, tahun: currentTahun, provinsi: key);
              }),
          cell(
              text: "${percentage.toStringAsFixed(2)}%",
              textAlign: TextAlign.end),
        ]);
      },
    );
  }

  Widget filterWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FilterWidget(
        items: tahunList.map((a) => a.toString()).toList(),
        title: "Tahun",
        currentItem: currentTahun.toString(),
        onChanged: (newTahun) {
          setState(() {
            this.currentTahun = int.parse(newTahun);
          });
          processData();
        },
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        filterWidget(context),
        mapWidget(context),
        tableWidget(context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String title;
    if (widget.type == PenyebaranWilayahType.PROGRAM_KEMITRAAN) {
      title = "Penyebaran Wilayah PK";
    } else {
      title = "Penyebaran Wilayah BL";
    }
    return BaseScaffold(
      title: title,
      body: (ctx) => filteredData == null
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
