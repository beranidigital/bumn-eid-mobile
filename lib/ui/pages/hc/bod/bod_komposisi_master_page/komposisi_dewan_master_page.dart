import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/components/bod_cluster_page/bod_cluster_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/components/komposisi_bod_page/komposisi_bod_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/di/komposisi_dewan_master_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/komposisi_dewan_master_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BODKomposisiMasterPage extends StatefulWidget with InjectableWidget {
  final BODKomposisiMasterPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  BODKomposisiMasterActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  BODKomposisiMasterPageGraph graph() => _graph;

  BODKomposisiMasterPage([graph])
      : this._graph = graph ?? BODKomposisiMasterPageGraph() {
    setup();
  }

  @override
  _BODKomposisiMasterPageState createState() => _BODKomposisiMasterPageState();
}

class _BODKomposisiMasterPageState extends State<BODKomposisiMasterPage> {
  final choices = [
    "Komposisi BOD",
    "Komposisi by Cluster",
  ];

  Widget pageViewWidget() {
    return TabBarView(
      children: <Widget>[
        KomposisiBODPage(),
        BODClusterPage(),
      ],
    );
  }

  Widget tabWidget() {
    return TabBar(
      tabs: choices
          .map((String choice) => Tab(
                child: Text(
                  choice,
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ))
          .toList(),
    );
  }

  Widget mainWidget(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          tabWidget(),
          Expanded(child: pageViewWidget()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Dewan Komisaris / Dewan Pengawas",
      body: (ctx) => mainWidget(context),
    );
  }
}
