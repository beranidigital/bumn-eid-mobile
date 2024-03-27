import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/controllers/legal_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/legal/legal_item.dart';
import 'package:bumn_eid/core/models/legal/legal_summary_data.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_card.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_bar_chart.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/legal/legal_summary_page/di/legal_summary_page_graph.dart';
import 'package:bumn_eid/ui/pages/legal/legal_summary_page/legal_bumn.dart';
import 'package:bumn_eid/ui/pages/legal/legal_summary_page/legal_jenis.dart';
import 'package:bumn_eid/ui/pages/legal/legal_summary_page/legal_persebaran.dart';
import 'package:bumn_eid/ui/pages/legal/legal_summary_page/legal_summary_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class SummaryBumnDataType with BarChartDataType {
  final String name;
  final int kasus;

  SummaryBumnDataType(
    this.name,
    this.kasus,
  );

  @override
  Color getColor() => Colors.blueAccent;

  @override
  int getX() => name.hashCode;

  @override
  String getXString() => name;

  @override
  double getY() => kasus.toDouble();
}

// ignore: must_be_immutable
class LegalSummaryPage extends StatefulWidget with InjectableWidget {
  final LegalSummaryPageGraph _graph;

  @override
  LegalSummaryPageGraph graph() => _graph;

  LegalSummaryPageActionMapper actionMapper;

  Store<AppState> store;

  ColorPalette colorPalette;

  JenisController jenisController;
  LegalController legalController;

  LegalSummaryPage([graph]) : this._graph = graph ?? LegalSummaryPageGraph() {
    setup();
  }

  @override
  _LegalSummaryPageState createState() => _LegalSummaryPageState();
}

class _LegalSummaryPageState extends State<LegalSummaryPage>
    with AfterLayoutMixin<LegalSummaryPage> {
  List<LegalItem> items;
  LegalSummaryData data;
  bool isError = false;

  bool isDataReady() {
    return data != null;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getData() async {
    try {
      setState(() {
        this.data = null;
        this.isError = false;
      });
      final items = await widget.legalController.fetchLegalList();
      final summary = await widget.legalController.fetchLegalSummary();

      setState(() {
        this.data = summary;
        this.items = items;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget topMenuItem(
    BuildContext context,
    String image,
    String title,
    String count,
  ) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 80.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Color(0xFF1FA4CA),
          width: 2.0,
        ),
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(
        right: 8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 24.0,
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 11.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Text(
            count,
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget menuList(BuildContext context) {
    // print("Hasil : ${data.legalSummaryAll}");
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color(0xFFEEEFF3),
      child: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 8.0,
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.actionMapper.goToCategory(null);
                  },
                  child: topMenuItem(
                    context,
                    'res/images/ic_total_bumn.png',
                    'Total BUMN',
                    items
                        .where((element) => element.bumn != null)
                        .length
                        .toString(),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.actionMapper.goToCategory(null);
                  },
                  child: topMenuItem(
                    context,
                    'res/images/ic_wamen.png',
                    'Total Perkara',
                    items.length.toString(),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.actionMapper.goToCategory('Tingkat Pertama');
                  },
                  child: topMenuItem(
                    context,
                    'res/images/ic_wamen.png',
                    'Tingkat Pertama',
                    items
                        .where((element) =>
                            element.tingkat_perkara
                                ?.contains('Tingkat Pertama') ??
                            false)
                        .length
                        .toString(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.actionMapper.goToCategory('Tingkat Banding');
                  },
                  child: topMenuItem(
                    context,
                    'res/images/ic_ownership.png',
                    'Tingkat Banding',
                    items
                        .where((element) =>
                            element.tingkat_perkara
                                ?.contains('Tingkat Banding') ??
                            false)
                        .length
                        .toString(),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.actionMapper.goToCategory('Tingkat Kasasi');
                  },
                  child: topMenuItem(
                    context,
                    'res/images/ic_cluster.png',
                    'Tingkat Kasasi',
                    items
                        .where((element) =>
                            element.tingkat_perkara
                                ?.contains('Tingkat Kasasi') ??
                            false)
                        .length
                        .toString(),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.actionMapper
                        .goToCategory('Tingkat Peninjauan Kembali');
                  },
                  child: topMenuItem(
                    context,
                    'res/images/ic_kelas.png',
                    'Tingkat PK',
                    items
                        .where((element) =>
                            element.tingkat_perkara
                                ?.contains('Tingkat Peninjauan Kembali') ??
                            false)
                        .length
                        .toString(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          BaseCard(
            title: 'Summary',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LegalJenis(
                  data: data,
                ),
                SizedBox(
                  height: 16.0,
                ),
                LegalBUMN(
                  data: data,
                ),
                SizedBox(
                  height: 16.0,
                ),
                LegalPersebaran(
                  data: data,
                ),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Legal',
      body: (ctx) => !isDataReady()
          ? isError
              ? CustomErrorWidget(
                  onRetry: () => getData(),
                )
              : LoadingWidget(
                  colorPalette: widget.colorPalette,
                )
          : menuList(context),
    );
  }
}
