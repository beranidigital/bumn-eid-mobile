import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_dewan_kelas_detailed_response.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_kelas_detailed.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_kelas_detailed_proposed.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_class/komposisi_dewan_class_detailed_page/di/komposisi_dewan_class_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_class/komposisi_dewan_class_detailed_page/komposisi_dewan_class_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class KomposisiDewanClassDetailedData with Searchable {
  final String nama;
  final int total;
  final GrafikDewanKomisarisKelasDetailedProposed totalTarget;
  final int profesional;
  final GrafikDewanKomisarisKelasDetailedProposed profesionalTarget;
//    final int akademisi;
//    final int akademisiTarget;
  final int kementrianBumn;
  final GrafikDewanKomisarisKelasDetailedProposed kementrianBumnTarget;
  final int kementrian;
  final GrafikDewanKomisarisKelasDetailedProposed kementrianTarget;
  final int ormas;
  final GrafikDewanKomisarisKelasDetailedProposed ormasTarget;

  KomposisiDewanClassDetailedData({
    @required this.nama,
    @required this.total,
    @required this.totalTarget,
    @required this.profesional,
    @required this.profesionalTarget,
//        @required
//        this.akademisi,
//        @required
//        this.akademisiTarget,
    @required this.kementrianBumn,
    @required this.kementrianBumnTarget,
    @required this.kementrian,
    @required this.kementrianTarget,
    @required this.ormas,
    @required this.ormasTarget,
  });

  @override
  String getKey() {
    return nama;
  }

  Color getColor(String key) {
    int total;
    int jumlahMin;
    int jumlahMax;
    switch (key) {
      case "Total":
        total = this.total;
        jumlahMin = this.totalTarget.jumlahMin;
        jumlahMax = this.totalTarget.jumlahMax;
        break;
      case "Profesional Korporasi":
        total = this.profesional;
        jumlahMin = this.profesionalTarget.jumlahMin;
        jumlahMax = this.profesionalTarget.jumlahMax;
        break;
      case "Kementerian BUMN":
        total = this.kementrianBumn;
        jumlahMin = this.kementrianBumnTarget.jumlahMin;
        jumlahMax = this.kementrianBumnTarget.jumlahMax;
        break;
      case "Kementerian atau Lembaga":
        total = this.kementrian;
        jumlahMin = this.kementrianTarget.jumlahMin;
        jumlahMax = this.kementrianTarget.jumlahMax;
        break;
      case "Ormas dan Lainnya":
        total = this.ormas;
        jumlahMin = this.ormasTarget.jumlahMin;
        jumlahMax = this.ormasTarget.jumlahMax;
        break;
      default:
        total = this.total;
        jumlahMin = this.totalTarget.jumlahMin;
        jumlahMax = this.totalTarget.jumlahMax;
        break;
    }
    if (total == null || jumlahMin == null || jumlahMax == null)
      return Colors.black;
    if (total < jumlahMin) {
      return Color(0xFFEBBC12);
    } else if (total > jumlahMax) {
      return Color(0xFFBA2300);
    } else {
      return Color(0xFF29A81A);
    }
  }
}

// ignore: must_be_immutable
class KomposisiDewanClassDetailedPage extends StatefulWidget
    with InjectableWidget {
  final KomposisiDewanClassDetailedPageGraph _graph;

  final String kelas;

  //injected
  ColorPalette colorPalette;
  //injected
  KomposisiDewanClassDetailedActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  KomposisiDewanClassDetailedPageGraph graph() => _graph;

  KomposisiDewanClassDetailedPage(
      {@required this.kelas, KomposisiDewanClassDetailedPageGraph graph})
      : this._graph = graph ?? KomposisiDewanClassDetailedPageGraph() {
    setup();
  }

  @override
  _KomposisiDewanClassDetailedPageState createState() =>
      _KomposisiDewanClassDetailedPageState();
}

class _KomposisiDewanClassDetailedPageState
    extends State<KomposisiDewanClassDetailedPage>
    with AfterLayoutMixin<KomposisiDewanClassDetailedPage> {
  Map<String, KomposisiDewanClassDetailedData> tableData;
  GrafikDewanKelasDetailedResponse data;
  bool isError = false;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getData({String wamen}) async {
    try {
      setState(() {
        this.data = null;
        this.isError = false;
      });
      final data = await widget.hcController
          .fetchGrafikKomposisiKelasDetailed(kelas: widget.kelas);
      final Map<String, KomposisiDewanClassDetailedData> tableData = {};
      data.data.forEach((datum) {
        if (!tableData.containsKey(datum.namaPendek)) {
          final key = datum.namaPendek;
          final List<GrafikDewanKomisarisKelasDetailed> datas =
              data.data.where((element) => element.namaPendek == key).toList();
          tableData[key] = KomposisiDewanClassDetailedData(
            nama: key,
            total: datas.fold(0, (a, b) => a + b.jumlah),
            totalTarget: data.proposedData.firstWhereOrNull(key: "Total"),
            profesional:
                datas.firstWhereOrNull(key: "Profesional Korporasi")?.jumlah ??
                    0,
            profesionalTarget: data.proposedData
                .firstWhereOrNull(key: "Profesional Korporasi"),
//                        akademisi: datas.firstWhereOrNull(key: "Akademisi")?.jumlah ?? 0,
//                        akademisiTarget: data.proposedData.firstWhereOrNull(key: "Akademisi")?.jumlah ?? 0,
            kementrianBumn:
                datas.firstWhereOrNull(key: "Kementerian BUMN")?.jumlah ?? 0,
            kementrianBumnTarget:
                data.proposedData.firstWhereOrNull(key: "Kementerian BUMN"),
            kementrian: datas
                    .firstWhereOrNull(key: "Kementerian atau Lembaga")
                    ?.jumlah ??
                0,
            kementrianTarget: data.proposedData
                .firstWhereOrNull(key: "Kementerian atau Lembaga"),
            ormas:
                datas.firstWhereOrNull(key: "Ormas dan Lainnya")?.jumlah ?? 0,
            ormasTarget:
                data.proposedData.firstWhereOrNull(key: "Ormas dan Lainnya"),
          );
        }
      });

      setState(() {
        this.data = data;
        this.tableData = tableData;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        isError = true;
      });
    }
  }

  Widget itemWidget(KomposisiDewanClassDetailedData data) {
    return Container(
      height: 150,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        elevation: 16.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.nama,
                      maxLines: 2,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "PK: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                        TextSpan(
                          text: data.profesional.toString(),
                          style: TextStyle(
                              color: data.getColor("Profesional Korporasi"),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "BUMN: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                        TextSpan(
                          text: data.kementrianBumn.toString(),
                          style: TextStyle(
                              color: data.getColor("Kementerian BUMN"),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Kementrian Lainnya: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                        TextSpan(
                          text: data.kementrian.toString(),
                          style: TextStyle(
                              color: data.getColor("Kementerian atau Lembaga"),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Ormas: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                        TextSpan(
                          text: data.ormas.toString(),
                          style: TextStyle(
                              color: data.getColor("Ormas dan Lainnya"),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                color: widget.colorPalette.primary,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      data.total.toString(),
                      style: TextStyle(
                          color: data.getColor("Total"),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget dataWidget(BuildContext context) {
    final keys = tableData.keys.toList();
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: keys.length,
        itemBuilder: (context, index) => itemWidget(tableData[keys[index]]));
  }

  Widget dataWidget1(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: CustomTable(
        width: MediaQuery.of(context).size.width * 2,
        colorPalette: widget.colorPalette,
        data: tableData,
        headers: [
          TableText(text: "Nama", flexColumnWidth: 80),
          TableText(text: "Total", type: TableTextType.NUMBER),
          TableText(text: "PK", type: TableTextType.NUMBER),
//                  TableText(text: "Akademisi", flexColumnWidth: 80, type: TableTextType.NUMBER),
          TableText(
              text: "BUMN", flexColumnWidth: 80, type: TableTextType.NUMBER),
          TableText(
              text: "Kementrian",
              flexColumnWidth: 80,
              type: TableTextType.NUMBER),
          TableText(
              text: "Ormas", flexColumnWidth: 80, type: TableTextType.NUMBER),
        ],
        showTriliun: false,
        rowDescriptor: (key, KomposisiDewanClassDetailedData value) {
          return TableRow(children: [
            cell(text: key),
            cell(
                text: value.total.toString() ?? "-",
                textAlign: TextAlign.end,
                textColor: value.getColor("Total")),
            cell(
                text: value.profesional?.toString() ?? "-",
                textAlign: TextAlign.end,
                textColor: value.getColor("Profesional Korporasi")),
//                          cell(text: value.akademisi?.toString() ?? "-", textAlign: TextAlign.end,
//                              textColor: value.akademisi >= value.akademisiTarget ? widget.colorPalette.success : widget.colorPalette.error),
            cell(
                text: value.kementrianBumn?.toString() ?? "-",
                textAlign: TextAlign.end,
                textColor: value.getColor("Kementerian BUMN")),
            cell(
                text: value.kementrian?.toString() ?? "-",
                textAlign: TextAlign.end,
                textColor: value.getColor("Kementerian atau Lembaga")),
            cell(
                text: value.ormas?.toString() ?? "-",
                textAlign: TextAlign.end,
                textColor: value.getColor("Ormas dan Lainnya")),
          ]);
        },
      ),
    );
  }

  Widget titleWidget(BuildContext context) {
    return Text(
      "Penataan Posisi Dewan Komisaris / Dewan Pengawas untuk Setiap Kelas BUMN",
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
    );
  }

  Widget kelasWidget(BuildContext context) {
    final total = data.proposedData.firstWhereOrNull(key: "Total");
    final prof =
        data.proposedData.firstWhereOrNull(key: "Profesional Korporasi");
    final ormas = data.proposedData.firstWhereOrNull(key: "Ormas dan Lainnya");
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Kelas ${widget.kelas}",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w700),
          ),
          Text(
            "Range Total: ${total?.jumlahMin ?? ""} - ${total?.jumlahMax ?? ""} Orang",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          Text(
            "Range PK: ${prof?.jumlahMin ?? ""} - ${prof?.jumlahMax ?? ""} Orang",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          Text(
            "Range Ormas: ${ormas?.jumlahMin ?? ""} - ${ormas?.jumlahMax ?? ""} Orang",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        titleWidget(context),
        kelasWidget(context),
        dataWidget(context),
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
      title: "Dewan Komisaris / Dewan Pengawas",
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
