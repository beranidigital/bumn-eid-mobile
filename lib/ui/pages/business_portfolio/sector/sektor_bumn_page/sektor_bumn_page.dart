import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/strings/strings.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/sector/sektor_bumn_page/di/sektor_bumn_page_graph.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/sector/sektor_bumn_page/sektor_bumn_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

enum SektorBumnPageType { BUSINESS_PORTFOLIO, HC }

class SektorBumnPageModel with SingleListItem {
  final String sektor;
  final int total;

  SektorBumnPageModel({@required this.sektor, @required this.total});

  @override
  String getTitle() {
    return sektor;
  }
}

// ignore: must_be_immutable
class SektorBumnPage extends StatefulWidget with InjectableWidget {
  final SektorBumnPageGraph _graph;

  final SektorBumnPageType type;

  //injected
  ColorPalette colorPalette;
  //injected
  SektorBumnActionMapper actionMapper;
  //injected
  JenisController jenisController;
  //injected
  CompaniesController companiesController;
  //injected
  Store<AppState> store;

  @override
  SektorBumnPageGraph graph() => _graph;

  SektorBumnPage([type, graph])
      : this._graph = graph ?? SektorBumnPageGraph(),
        this.type = type ?? SektorBumnPageType.BUSINESS_PORTFOLIO {
    setup();
  }

  @override
  _SektorBumnPageState createState() => _SektorBumnPageState();
}

class _SektorBumnPageState extends State<SektorBumnPage>
    with AfterLayoutMixin<SektorBumnPage> {
  Map<String, List<ProfilPerusahaan>> tableData;
  bool isError = false;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getData() {
    try {
      setState(() {
        isError = false;
      });
      Map<String, List<ProfilPerusahaan>> categorizedCompanies = {};
      final companiesList = widget.store.state.companiesState.companies;
      if (companiesList.isEmpty) throw Exception();

      companiesList.forEach((company) {
        if (!categorizedCompanies.containsKey(company.sektorBps)) {
          categorizedCompanies[company.sektorBps] = [company];
        } else {
          categorizedCompanies[company.sektorBps] =
              categorizedCompanies[company.sektorBps]..add(company);
        }
      });

      setState(() {
        this.tableData = categorizedCompanies;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        isError = true;
      });
    }
  }

  Widget chartWidget(BuildContext context) {
    return CustomPieChart(
      tableData: tableData,
      colorPalette: widget.colorPalette,
      maxItemToShowLabel: 3,
    );
  }

  Widget companyList(BuildContext context) {
    final List<SektorBumnPageModel> convertedData = [];
    tableData.keys.forEach((sektor) {
      convertedData.add(
          SektorBumnPageModel(sektor: sektor, total: tableData[sektor].length));
    });
    final sortedCompanies = convertedData.toList()
      ..sort((a, b) => b.total.compareTo(a.total));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleListView<SektorBumnPageModel>(
        colorPalette: widget.colorPalette,
        onItemTap: (SektorBumnPageModel item) => widget.actionMapper
            .openDetailedJenisPage(item.getTitle(), widget.type),
        items: sortedCompanies,
        leadingWidget: (SektorBumnPageModel item) => SumTypeText(
          colorPalette: widget.colorPalette,
          sum: item.total,
        ),
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return Container(
      color: widget.colorPalette.defaultBg,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: <Widget>[
          chartWidget(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: companyList(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: Strings.getString("SektorBumnPage.Title"),
      body: (ctx) => tableData == null
          ? isError
              ? CustomErrorWidget(
                  onRetry: () => getData(),
                )
              : LoadingWidget(colorPalette: widget.colorPalette)
          : mainWidget(context),
    );
  }
}
