import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/main_menu.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_page/di/talent_pool_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_page/talent_pool_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// ignore: must_be_immutable
class TalentPoolPage extends StatefulWidget with InjectableWidget {
  final TalentPoolPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  TalentPoolPageActionMapper actionMapper;

  @override
  TalentPoolPageGraph graph() => _graph;

  TalentPoolPage([graph]) : this._graph = graph ?? TalentPoolPageGraph() {
    setup();
  }

  @override
  _TalentPoolPageState createState() => _TalentPoolPageState();
}

class _TalentPoolPageState extends State<TalentPoolPage> {
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
                    imagePath: "res/images/talent_mobility.png",
                    colorPalette: widget.colorPalette,
                    title: "Talent Pool by Mobility",
                    onTap: () => widget.actionMapper.openByMobility(),
                  ),
                ),
                Expanded(
                  child: MainMenu(
                    imagePath: "res/images/class.png",
                    colorPalette: widget.colorPalette,
                    title: "Talent Pool by Process",
                    onTap: () => widget.actionMapper.openByProcess(),
                  ),
                ),
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
      title: "Talent Pool",
      body: (ctx) => SafeArea(
        child: menuList(context),
      ),
    );
  }
}
