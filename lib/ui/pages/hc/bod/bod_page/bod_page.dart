import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/main_menu.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_page/bod_page_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_page/di/bod_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class BODPage extends StatelessWidget with InjectableWidget {
  final BODPageGraph _graph;

  //injected
  BODPageActionMapper actionMapper;
  //injected
  Store<AppState> store;
  //injected
  ColorPalette colorPalette;

  @override
  BODPageGraph graph() => _graph;

  BODPage([graph]) : this._graph = graph ?? BODPageGraph() {
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
              title: "Komposisi BOD",
              imagePath: "res/images/komposisi_dekom.png",
              onTap: () => actionMapper.openKomposisiBOD()),
        ),
        Expanded(
          child: MainMenu(
              colorPalette: colorPalette,
              title: "Penataan Komposisi",
              imagePath: "res/images/penataan_komposisi.png",
              onTap: () => actionMapper.openKomposisiByClass()),
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
              title: "Potret Masa Tugas",
              imagePath: "res/images/potret.png",
              onTap: () => actionMapper.openPotretMasaTugas()),
        ),
        Expanded(
          child: MainMenu(
              colorPalette: colorPalette,
              title: "Potret Masa Tugas Saat Ini",
              imagePath: "res/images/potret.png",
              onTap: () => actionMapper.openPotretMasaTugasSaatIni()),
        ),
      ],
    );
  }

  Widget fifthRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: MainMenu(
            colorPalette: colorPalette,
            title: "BOD By Company",
            imagePath: "res/images/profile.png",
            onTap: () => actionMapper.openBodByCompany(),
          ),
        ),
        Expanded(
          child: MainMenu(
            colorPalette: colorPalette,
            title: "BOD By Class",
            imagePath: "res/images/class.png",
            onTap: () => actionMapper.openBodByClass(),
          ),
        ),
      ],
    );
  }

  Widget sixthRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: MainMenu(
            colorPalette: colorPalette,
            title: "BOD By Cluster",
            imagePath: "res/images/cluster.png",
            onTap: () => actionMapper.openBodByCluster(),
          ),
        ),
        Expanded(
          child: MainMenu(
            colorPalette: colorPalette,
            title: "Search All Pejabat",
            imagePath: "res/images/profile.png",
            onTap: () => actionMapper.openSearchPejabat(),
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
          Expanded(child: thirdRow()),
          Expanded(child: fifthRow()),
          Expanded(child: sixthRow()),
          Expanded(
            child: Container(),
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
      title: "BOD",
      body: (ctx) => SafeArea(
        child: menuList(context),
      ),
    );
  }
}
