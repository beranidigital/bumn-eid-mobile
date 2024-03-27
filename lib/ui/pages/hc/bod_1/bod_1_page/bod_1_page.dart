import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/main_menu.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_page/bod_1_page_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_page/di/bod_1_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// ignore: must_be_immutable
class BOD1Page extends StatefulWidget with InjectableWidget {
  final BOD1PageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  BOD1PageActionMapper actionMapper;

  @override
  BOD1PageGraph graph() => _graph;

  BOD1Page([graph]) : this._graph = graph ?? BOD1PageGraph() {
    setup();
  }

  @override
  _BOD1PageState createState() => _BOD1PageState();
}

class _BOD1PageState extends State<BOD1Page> {
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
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: MainMenu(
                    imagePath: "res/images/profile.png",
                    colorPalette: widget.colorPalette,
                    title: "BOD-1 by Company",
                    onTap: () => widget.actionMapper.openByCompany(),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: MainMenu(
                    imagePath: "res/images/class.png",
                    colorPalette: widget.colorPalette,
                    title: "BOD-1 by Class",
                    onTap: () => widget.actionMapper.openByClass(),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: MainMenu(
                    imagePath: "res/images/cluster.png",
                    colorPalette: widget.colorPalette,
                    title: "BOD-1 by Cluster",
                    onTap: () => widget.actionMapper.openByCluster(),
                  ),
                ),
                SizedBox(
                  width: 16.0,
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
      title: "BOD-1",
      body: (ctx) => SafeArea(
        child: menuList(context),
      ),
    );
  }
}
