import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/komposisi_dewan_cluster_page/komposisi_dewan_cluster_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/komposisi_dewan_page/komposisi_dewan_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/kontribusi_kementrian_page/kontribusi_kementrian_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/kontribusi_ormas_page/kontribusi_ormas_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/kontribusi_profesional_page/kontribusi_profesional_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/di/komposisi_dewan_master_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/komposisi_dewan_master_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class KomposisiDewanMasterPage extends StatefulWidget with InjectableWidget {
  final KomposisiDewanMasterPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  KomposisiDewanMasterActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  KomposisiDewanMasterPageGraph graph() => _graph;

  KomposisiDewanMasterPage([graph])
      : this._graph = graph ?? KomposisiDewanMasterPageGraph() {
    setup();
  }

  @override
  _KomposisiDewanMasterPageState createState() =>
      _KomposisiDewanMasterPageState();
}

class _KomposisiDewanMasterPageState extends State<KomposisiDewanMasterPage> {
  final choices = [
    "Dekom / Dewas",
    "Kementrian",
    "PK",
    "Ormas",
    "Cluster",
  ];

  Widget pageViewWidget() {
    return TabBarView(
      children: <Widget>[
        KomposisiDewanPage(),
        KontribusiKementrianPage(),
        KontribusiProfesionalPage(),
        KontribusiOrmasPage(),
        KomposisiDewanClusterPage()
      ],
    );
  }

  Widget tabWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black45, offset: Offset(1.0, 2.0))
      ]),
      child: Center(
        child: TabBar(
          isScrollable: true,
          unselectedLabelColor: widget.colorPalette.primary,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: widget.colorPalette.primary),
          tabs: choices
              .map(
                (String choice) => Center(
                  child: Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: widget.colorPalette.primary, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(choice),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
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
