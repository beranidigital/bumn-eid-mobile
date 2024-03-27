import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_detailed/component/sektor_penyaluran_area/sektor_penyaluran_area_page.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_detailed/component/sektor_penyaluran_company/sektor_penyaluran_company_page.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_detailed/di/sektor_penyaluran_detailed_page_graph.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_detailed/sektor_penyaluran_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class SektorPenyaluranDetailedPage extends StatefulWidget
    with InjectableWidget {
  final SektorPenyaluranDetailedPageGraph _graph;

  final String sektor;

  //injected
  ColorPalette colorPalette;
  //injected
  SektorPenyaluranDetailedActionMapper actionMapper;
  //injected
  CsrController csrController;
  //injected
  Store<AppState> store;

  @override
  SektorPenyaluranDetailedPageGraph graph() => _graph;

  SektorPenyaluranDetailedPage(
      {@required this.sektor, SektorPenyaluranDetailedPageGraph graph})
      : this._graph = graph ?? SektorPenyaluranDetailedPageGraph() {
    setup();
  }

  @override
  _SektorPenyaluranDetailedPageState createState() =>
      _SektorPenyaluranDetailedPageState();
}

class _SektorPenyaluranDetailedPageState
    extends State<SektorPenyaluranDetailedPage> {
  List<int> tahunList = Constants.tahunList;
  int currentTahun = int.parse(Constants.latestDataYear);

  final optionsList = [
    "by Company",
    "by Area",
  ];

  String currentOption = "by Company";

  Widget optionFilter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FilterWidget(
        items: optionsList,
        title: "Filter",
        currentItem: currentOption,
        onChanged: (newOption) {
          setState(() {
            this.currentOption = newOption;
          });
        },
      ),
    );
  }

  Widget tahunFilter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: FilterWidget(
        items: tahunList.map((a) => a.toString()).toList(),
        title: "Tahun",
        currentItem: currentTahun.toString(),
        onChanged: (newTahun) {
          setState(() {
            this.currentTahun = parseInt(newTahun);
          });
        },
      ),
    );
  }

  Widget individualItem() {
    return currentOption == "by Company"
        ? SektorPenyaluranCompanyPage(
            tahun: currentTahun.toString(),
            sektor: widget.sektor,
          )
        : SektorPenyaluranAreaPage(
            tahun: currentTahun.toString(),
            sektor: widget.sektor,
          );
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        children: [tahunFilter(), optionFilter(), individualItem()]);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.sektor,
      body: (ctx) => mainWidget(context),
    );
  }
}
