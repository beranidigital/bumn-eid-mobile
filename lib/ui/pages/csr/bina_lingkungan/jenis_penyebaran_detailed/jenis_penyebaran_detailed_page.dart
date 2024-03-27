import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran_detailed/component/jenis_penyebaran_area/jenis_penyebaran_area_page.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran_detailed/component/jenis_penyebaran_company/jenis_penyebaran_company_page.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran_detailed/di/jenis_penyebaran_detailed_page_graph.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran_detailed/jenis_penyebaran_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class JenisPenyebaranDetailedPage extends StatefulWidget with InjectableWidget {
  final JenisPenyebaranDetailedPageGraph _graph;

  final String jenis;

  //injected
  ColorPalette colorPalette;
  //injected
  JenisPenyebaranDetailedActionMapper actionMapper;
  //injected
  CsrController csrController;
  //injected
  Store<AppState> store;

  @override
  JenisPenyebaranDetailedPageGraph graph() => _graph;

  JenisPenyebaranDetailedPage(
      {@required this.jenis, JenisPenyebaranDetailedPageGraph graph})
      : this._graph = graph ?? JenisPenyebaranDetailedPageGraph() {
    setup();
  }

  @override
  _JenisPenyebaranDetailedPageState createState() =>
      _JenisPenyebaranDetailedPageState();
}

class _JenisPenyebaranDetailedPageState
    extends State<JenisPenyebaranDetailedPage> {
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
        ? JenisPenyebaranCompanyPage(
            tahun: currentTahun.toString(),
            jenis: widget.jenis,
          )
        : JenisPenyebaranAreaPage(
            tahun: currentTahun.toString(),
            jenis: widget.jenis,
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
      title: widget.jenis,
      body: (ctx) => mainWidget(context),
    );
  }
}
