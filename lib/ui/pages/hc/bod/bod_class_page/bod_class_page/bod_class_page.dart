import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_class_page/bod_class_page/bod_class_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_class_page/bod_class_page/di/bod_class_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BODClassPageData {
  final String kelas;
  final int jumlah;
  final int target;

  BODClassPageData(
      {@required this.kelas, @required this.jumlah, @required this.target});
}

// ignore: must_be_immutable
class BODClassPage extends StatefulWidget with InjectableWidget {
  final BODClassPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  BODClassActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  BODClassPageGraph graph() => _graph;

  BODClassPage([graph]) : this._graph = graph ?? BODClassPageGraph() {
    setup();
  }

  @override
  _BODClassPageState createState() => _BODClassPageState();
}

class _BODClassPageState extends State<BODClassPage>
    with AfterLayoutMixin<BODClassPage> {
  int totalData;
  List<BODClassPageData> data;
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
      final data = await widget.hcController.fetchGrafikKomposisiKelasBod();

      final List<BODClassPageData> convertedData = [];
      data.data.forEach((datum) {
        final kelas = "Kelas ${datum.kelas}";
        convertedData.add(BODClassPageData(
            kelas: kelas,
            jumlah: data.proposedData[kelas.toLowerCase()],
            target: datum.jumlah));
      });

      setState(() {
        this.totalData = data.totalData;
        this.data = convertedData;
      });
    } catch (ex) {
      setState(() {
        isError = true;
      });
    }
  }

  Widget tableCell(
      {@required String text,
      TextStyle textStyle,
      VoidCallback onTap,
      TextAlign textAlign}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Center(
            child: Text(
              text,
              textAlign: textAlign ?? TextAlign.center,
              style: textStyle ??
                  TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  TableRow row(
      {@required String kelas, @required int jumlah, @required int target}) {
    return TableRow(children: [
      tableCell(text: kelas),
      TableCell(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.only(right: 8.0),
                child: Text(
                  jumlah.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Text(
                "of $target",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
      TableCell(
        child: GestureDetector(
          onTap: () =>
              widget.actionMapper.openDetailedPage(kelas: kelas.split(" ")[1]),
          child: Container(
            color: Color(0xffFBD300),
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.symmetric(vertical: 4.0),
            child: Center(
              child: Text(
                "Detail",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget table() {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(50),
        1: FlexColumnWidth(75),
        2: FlexColumnWidth(50),
      },
      children: [
        TableRow(children: [
          tableCell(text: ""),
          tableCell(text: "Jumlah BUMN yang Sesuai Target"),
          tableCell(text: ""),
        ]),
      ]
        ..addAll(List.generate(data.length, (idx) {
          final datum = data[idx];
          return row(
              kelas: datum.kelas, jumlah: datum.jumlah, target: datum.target);
        }))
        ..add(
          TableRow(children: [
            tableCell(text: "Total"),
            tableCell(text: totalData.toString()),
            tableCell(text: ""),
          ]),
        ),
    );
  }

  Widget tableWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: widget.colorPalette.primary,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: table(),
        ),
      ),
    );
  }

  Widget titleWidget(BuildContext context) {
    return Text(
      "Penataan Posisi BOD untuk Setiap Kelas BUMN",
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
        child: data == null && totalData == null
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
