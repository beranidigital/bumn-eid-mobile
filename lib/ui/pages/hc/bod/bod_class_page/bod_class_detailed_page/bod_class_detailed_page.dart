import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_bod_kelas_detailed_response.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/grafik_bod_kelas_detailed.dart';
import 'package:bumn_eid/core/models/hc/grafik_bod_kelas_detailed_proposed.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_class_page/bod_class_detailed_page/bod_class_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_class_page/bod_class_detailed_page/di/bod_class_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BODClassDetailedData with Searchable {
  final String nama;
  final int total;
  final GrafikBODKelasDetailedProposed totalTarget;

  BODClassDetailedData({
    @required this.nama,
    @required this.total,
    @required this.totalTarget,
  });

  @override
  String getKey() {
    return nama;
  }

  Color getColor() {
    if (this.total < this.totalTarget.jumlahMin) {
      return Color(0xFFEBBC12);
    } else if (this.total > this.totalTarget.jumlahMax) {
      return Color(0xFFBA2300);
    } else {
      return Color(0xFF29A81A);
    }
  }
}

// ignore: must_be_immutable
class BODClassDetailedPage extends StatefulWidget with InjectableWidget {
  final BODClassDetailedPageGraph _graph;

  final String kelas;

  //injected
  ColorPalette colorPalette;
  //injected
  BODClassDetailedActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  BODClassDetailedPageGraph graph() => _graph;

  BODClassDetailedPage({@required this.kelas, BODClassDetailedPageGraph graph})
      : this._graph = graph ?? BODClassDetailedPageGraph() {
    setup();
  }

  @override
  _BODClassDetailedPageState createState() => _BODClassDetailedPageState();
}

class _BODClassDetailedPageState extends State<BODClassDetailedPage>
    with AfterLayoutMixin<BODClassDetailedPage> {
  Map<String, BODClassDetailedData> tableData;
  GrafikBODKelasDetailedResponse data;
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
          .fetchGrafikKomposisiKelasBodDetailed(kelas: widget.kelas);
      final Map<String, BODClassDetailedData> tableData = {};
      data.data.forEach((datum) {
        if (!tableData.containsKey(datum.namaPendek)) {
          final key = datum.namaPendek;
          final List<GrafikBODKelasDetailed> datas =
              data.data.where((element) => element.namaPendek == key).toList();
          tableData[key] = BODClassDetailedData(
            nama: key,
            total: datas.fold(0, (a, b) => a + b.jumlah),
            totalTarget: data.proposedData.firstWhereOrNull(key: "Total"),
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

  Widget tableWidget(BuildContext context) {
    return CustomTable(
      colorPalette: widget.colorPalette,
      data: tableData,
      headers: [
        TableText(text: "Nama", flexColumnWidth: 80),
        TableText(text: "Realisasi", type: TableTextType.NUMBER),
      ],
      showTriliun: false,
      rowDescriptor: (key, BODClassDetailedData value) {
        return TableRow(children: [
          cell(text: key),
          cell(
              text: value.total.toString() ?? "-",
              textAlign: TextAlign.end,
              textColor: value.getColor()),
        ]);
      },
    );
  }

  Widget titleWidget(BuildContext context) {
    return Text(
      "Penataan Posisi BOD untuk Setiap Kelas BUMN",
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
    );
  }

  Widget kelasWidget(BuildContext context) {
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
            "Range Total: ${data.proposedData.first.jumlahMin} - ${data.proposedData.first.jumlahMax} Orang",
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
