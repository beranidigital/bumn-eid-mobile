import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/main_menu.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dewan_komisaris_page/dewan_komisaris_page_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dewan_komisaris_page/di/dewan_komisaris_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class DewanKomisarisPage extends StatelessWidget with InjectableWidget {
  final DewanKomisarisPageGraph _graph;

  //injected
  DewanKomisarisPageActionMapper actionMapper;
  //injected
  Store<AppState> store;
  //injected
  ColorPalette colorPalette;

  @override
  DewanKomisarisPageGraph graph() => _graph;

  DewanKomisarisPage([graph])
      : this._graph = graph ?? DewanKomisarisPageGraph() {
    setup();
  }

  Widget firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: MainMenu(
              colorPalette: colorPalette,
              title: "Komposisi Dekom / Dewas",
              imagePath: "res/images/komposisi_dekom.png",
              onTap: () => actionMapper.openKomposisiDekom()),
        ),
        Expanded(
          child: MainMenu(
              colorPalette: colorPalette,
              title: "Penataan Komposisi",
              imagePath: "res/images/penataan_komposisi.png",
              onTap: () => actionMapper.openPenataanKomposisi()),
        ),
      ],
    );
  }

  Widget secondRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: MainMenu(
            colorPalette: colorPalette,
            title: "BOC By Cluster",
            imagePath: "res/images/cluster.png",
            onTap: () => actionMapper.openBocByCluster(),
          ),
        ),
        Expanded(
          child: MainMenu(
              colorPalette: colorPalette,
              title: "Potret Masa Tugas",
              imagePath: "res/images/potret.png",
              onTap: () => actionMapper.openPotretMasaTugas()),
        ),
      ],
    );
  }

  Widget thirdRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: MainMenu(
              colorPalette: colorPalette,
              title: "Potret Masa Tugas Saat Ini",
              imagePath: "res/images/potret.png",
              onTap: () => actionMapper.openPotretMasaTugasSaatIni()),
        ),
        Expanded(
          child: MainMenu(
            colorPalette: colorPalette,
            title: "BOC By Company",
            imagePath: "res/images/profile.png",
            onTap: () => actionMapper.openBocByCompany(),
          ),
        ),
      ],
    );
  }

  Widget fourthRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: MainMenu(
            colorPalette: colorPalette,
            title: "BOC By Class",
            imagePath: "res/images/class.png",
            onTap: () => actionMapper.openBocByClass(),
          ),
        ),
        Expanded(
          child: MainMenu(
            colorPalette: colorPalette,
            title: "Search All Pejabat",
            imagePath: "res/images/profile.png",
            onTap: () => actionMapper.openSearchPejabat(),
          ),
        )
      ],
    );
  }

  Widget fifthRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }

  Widget menuList(BuildContext context) {
    return Container(
      color: Color(0xFFEEEFF3),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: firstRow()),
          Expanded(child: secondRow()),
          Expanded(child: thirdRow()),
          Expanded(
            child: fourthRow(),
          ),
          Expanded(
            child: fifthRow(),
          ),
          LastUpdateWidget(
            store: StoreProvider.of<AppState>(context),
            pageName: "hc",
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Dewan Komisaris / Dewan Pengawas",
      body: (ct) => SafeArea(
        child: menuList(context),
      ),
    );
  }
}
