import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/pages/finance/loan/loan_main_page/di/loan_main_page_graph.dart';
import 'package:bumn_eid/ui/pages/finance/loan/loan_main_page/loan_main_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class LoanMainPage extends StatefulWidget with InjectableWidget {
  final LoanMainPageGraph _graph;

  LoanMainPage([graph]) : this._graph = graph ?? LoanMainPageGraph() {
    setup();
  }

  //injected
  ColorPalette colorPalette;
  //injected
  LoanMainPageActionMapper actionMapper;
  //injected
  Store<AppState> store;

  @override
  LoanMainPageGraph graph() => _graph;

  @override
  _LoanMainPageState createState() => _LoanMainPageState();
}

class _LoanMainPageState extends State<LoanMainPage> {
  Widget menuItem({
    String title,
    String imagePath,
    VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 32.0,
              width: 32.0,
            ),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'poppins',
                  color: Color(0xFF1F2855),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuWidgets(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: menuItem(
                  title: "Detil Liabilitas (SUSPI)",
                  imagePath: "res/images/suspi.png",
                  onTap: () {
                    ApiStatistic()
                        .insertStatistic("Finance", "List SUSPI Debt");
                    widget.actionMapper.openSuspi();
                  },
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: menuItem(
                  title: "Detil Debt",
                  imagePath: "res/images/detail_debt.png",
                  onTap: () {
                    ApiStatistic()
                        .insertStatistic("Finance", "List Detail Debt Debt");
                    widget.actionMapper.openLoan();
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 16.0,
        ),
        menuWidgets(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Debt',
      withTopBlue: true,
      body: (ctx) => mainWidget(context),
    );
  }
}
