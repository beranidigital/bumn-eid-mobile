import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/legal_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/legal/legal_item.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_expansion_tile.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/legal/legal_detail_page/di/legal_detail_page_graph.dart';
import 'package:bumn_eid/ui/pages/legal/legal_detail_page/legal_detail_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class LegalDetailPage extends StatefulWidget with InjectableWidget {
  final LegalDetailPageGraph _graph;

  final LegalItem item;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;
  //injected
  LegalController legalController;
  //injected
  LegalDetailActionMapper actionMapper;

  LegalDetailPage({@required this.item, LegalDetailPageGraph graph})
      : this._graph = graph ?? LegalDetailPageGraph() {
    setup();
  }

  @override
  LegalDetailPageGraph graph() => _graph;

  @override
  _LegalDetailPageState createState() => _LegalDetailPageState();
}

class _LegalDetailPageState extends State<LegalDetailPage>
    with AfterLayoutMixin<LegalDetailPage> {
  bool isError = false;

  LegalItem data;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return data != null;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      final data = widget.item;

      setState(() {
        this.data = data;
      });
    } catch (ex) {
      print(ex.toString());
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget teamInfo(BuildContext context) {
    return CustomExpansionTile(
      colorPalette: widget.colorPalette,
      icon: Icons.info,
      text: "Deskripsi Perkara",
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Nomor Perkara",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A919B)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  data.nomorPerkara ?? '-',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                margin: EdgeInsets.only(top: 8),
                color: Color(0xFFD9D9D9),
              ),
              Text(
                "Nomor SKK",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A919B)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  data.nomorSkk ?? '-',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                margin: EdgeInsets.only(top: 8),
                color: Color(0xFFD9D9D9),
              ),
              Text(
                "Penggugat",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A919B)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  data.penggugat ?? '-',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                margin: EdgeInsets.only(top: 8),
                color: Color(0xFFD9D9D9),
              ),
              Text(
                "Tergugat",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A919B)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  data.tergugat ?? '-',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                margin: EdgeInsets.only(top: 8),
                color: Color(0xFFD9D9D9),
              ),
              Text(
                "Objek Gugatan",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A919B)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  data.objekGugatan ?? '-',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                margin: EdgeInsets.only(top: 8),
                color: Color(0xFFD9D9D9),
              ),
              Text(
                "Objek Perkara",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A919B)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  data.objek_perkara ?? '-',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                margin: EdgeInsets.only(top: 8),
                color: Color(0xFFD9D9D9),
              ),
              Text(
                "BUMN",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A919B)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  data.nama_pendek ?? '-',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                margin: EdgeInsets.only(top: 8),
                color: Color(0xFFD9D9D9),
              ),
              Text(
                "Kota",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A919B)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  data.kota ?? '-',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                margin: EdgeInsets.only(top: 8),
                color: Color(0xFFD9D9D9),
              ),
              Text(
                "Tempat Perkara",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A919B)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  data.tempat_perkara ?? '-',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                margin: EdgeInsets.only(top: 8),
                color: Color(0xFFD9D9D9),
              ),
              Text(
                "Keterangan",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A919B)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  data.keterangan ?? '-',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                margin: EdgeInsets.only(top: 8),
                color: Color(0xFFD9D9D9),
              ),
              Text(
                "Petitum",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A919B)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  data.petitum ?? '-',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget statusPerkara(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        icon: Icons.info,
        text: "Status Perkara",
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.progress,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget detailsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          teamInfo(context),
          statusPerkara(context),
        ],
      ),
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
        : Container(
            color: widget.colorPalette.defaultBg,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Text(
                      data.penggugat + " - " + data.nomorPerkara,
                      style: TextStyle(
                          color: widget.colorPalette.black, fontSize: 18.0),
                    ),
                  ),
                ),
                detailsList(context)
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Legal Case Detail',
      body: (ctx) => mainWidget(context),
    );
  }
}
