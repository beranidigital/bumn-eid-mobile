import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/main_menu.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_process_page/di/talent_pool_by_process_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_process_page/talent_pool_by_process_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// ignore: must_be_immutable
class TalentPoolByProcessPage extends StatefulWidget with InjectableWidget {
  final TalentPoolByProcessPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  TalentPoolByProcessPageActionMapper actionMapper;

  @override
  TalentPoolByProcessPageGraph graph() => _graph;

  TalentPoolByProcessPage([graph])
      : this._graph = graph ?? TalentPoolByProcessPageGraph() {
    setup();
  }

  @override
  _TalentPoolByProcessPageState createState() =>
      _TalentPoolByProcessPageState();
}

class _TalentPoolByProcessPageState extends State<TalentPoolByProcessPage> {
  Widget menuList(BuildContext context) {
    return Container(
      color: Color(0xFFEEEFF3),
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MainMenu(
                    imagePath: "res/images/class.png",
                    colorPalette: widget.colorPalette,
                    title: "Talent Pool by Class",
                    onTap: () => widget.actionMapper.openByClass(),
                  ),
                ),
                Expanded(
                  child: MainMenu(
                    imagePath: "res/images/profile.png",
                    colorPalette: widget.colorPalette,
                    title: "Talent Pool by Company",
                    onTap: () => widget.actionMapper.openByCompany(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MainMenu(
                    imagePath: "res/images/cluster.png",
                    colorPalette: widget.colorPalette,
                    title: "Talent Pool by Cluster",
                    onTap: () => widget.actionMapper.openByCluster(),
                  ),
                ),
                Expanded(
                  child: MainMenu(
                    imagePath: "res/images/talent_mobility.png",
                    colorPalette: widget.colorPalette,
                    title: "Dropped Talent",
                    onTap: () => widget.actionMapper.openDroppedTalent(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MainMenu(
                    imagePath: "res/images/anggaran_karyawan.png",
                    colorPalette: widget.colorPalette,
                    title: "Advanced Filter",
                    onTap: () => widget.actionMapper.openAdvanceFilter(),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                  ),
                )
              ],
            ),
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
      title: "Talent Pool By Process",
      body: (ctx) => SafeArea(
        child: menuList(context),
      ),
    );
  }
}
