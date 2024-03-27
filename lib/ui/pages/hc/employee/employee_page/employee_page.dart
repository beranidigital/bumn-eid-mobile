import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/main_menu.dart';
import 'package:bumn_eid/ui/pages/hc/employee/employee_page/di/employee_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/employee/employee_page/employee_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// ignore: must_be_immutable
class EmployeePage extends StatefulWidget with InjectableWidget {
  final EmployeePageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  EmployeePageActionMapper actionMapper;

  @override
  EmployeePageGraph graph() => _graph;

  EmployeePage([graph]) : this._graph = graph ?? EmployeePageGraph() {
    setup();
  }

  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
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
                    imagePath: "res/images/profile.png",
                    colorPalette: widget.colorPalette,
                    title: "Employee by Company",
                    onTap: () => widget.actionMapper.openByCompany(),
                  ),
                ),
                Expanded(
                  child: MainMenu(
                    imagePath: "res/images/class.png",
                    colorPalette: widget.colorPalette,
                    title: "Employee by Class",
                    onTap: () => widget.actionMapper.openByClass(),
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
                    title: "Employee by Cluster",
                    onTap: () => widget.actionMapper.openByCluster(),
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
      title: 'Employee',
      body: (ctx) => menuList(context),
    );
  }
}
