import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/csr/csr_item.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/pages/csr/common/csr_detail_page/csr_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/common/csr_detail_page/di/csr_detail_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class CsrDetailPage extends StatefulWidget with InjectableWidget {
  final CsrDetailPageGraph _graph;

  final CsrItem item;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;
  //injected
  CsrController csrController;
  //injected
  CsrDetailActionMapper actionMapper;

  CsrDetailPage({@required this.item, CsrDetailPageGraph graph})
      : this._graph = graph ?? CsrDetailPageGraph() {
    setup();
  }

  @override
  CsrDetailPageGraph graph() => _graph;

  @override
  _CsrDetailPageState createState() => _CsrDetailPageState();
}

class _CsrDetailPageState extends State<CsrDetailPage> {
  Widget title(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Detail CSR >",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        Text(
          widget.item.bentukCsr,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget danaWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Dana CSR:",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(color: Color(0xFFE7F0FF), boxShadow: [
              BoxShadow(color: Colors.black26, offset: Offset(1.0, 2.0))
            ]),
            padding: EdgeInsets.all(16.0),
            child: Text(
              "${parseDouble(widget.item.danaCsr) / Constants.billion} Miliar",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }

  Widget wilayahWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Wilayah:",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(color: Color(0xFFE7F0FF), boxShadow: [
              BoxShadow(color: Colors.black26, offset: Offset(1.0, 2.0))
            ]),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Kota: ${widget.item.kota}",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Propinsi: ${widget.item.propinsi}",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget deskripsiWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Deskripsi CSR:",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(color: Color(0xFFE7F0FF), boxShadow: [
              BoxShadow(color: Colors.black26, offset: Offset(1.0, 2.0))
            ]),
            padding: EdgeInsets.all(16.0),
            child: Text(
              widget.item.bentukCsr,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        title(context),
        danaWidget(context),
        wilayahWidget(context),
        deskripsiWidget(context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Detail Kegiatan CSR',
      body: (ctx) => mainWidget(ctx),
    );
  }
}
