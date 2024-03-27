import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/finance/capex.dart';
import 'package:bumn_eid/core/models/finance/grafik_capex.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/strings/strings.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_bar_chart.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/finance/capex/capex_detailed_page/capex_detailed_page.dart';
import 'package:bumn_eid/ui/pages/finance/capex/capex_page/capex_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/capex/capex_page/di/capex_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CapexPageModel with SingleListItem {
  final String tahun;
  final int total;

  CapexPageModel({@required this.tahun, @required this.total});

  @override
  String getTitle() {
    return tahun;
  }
}

// ignore: must_be_immutable
class CapexPage extends StatefulWidget with InjectableWidget {
  final CapexPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  CapexActionMapper actionMapper;
  //injected
  FinanceController financeController;

  @override
  CapexPageGraph graph() => _graph;

  CapexPage([graph]) : this._graph = graph ?? CapexPageGraph() {
    setup();
  }

  @override
  _CapexPageState createState() => _CapexPageState();
}

class _CapexPageState extends State<CapexPage>
    with AfterLayoutMixin<CapexPage> {
  List<GrafikCapex> tableData;
  bool isError = false;
  List<Capex> capex = [];
  List<Capex> filteredCapex = [];
  TextEditingController _searchController = TextEditingController();

  int counter = 0;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataAvailable() {
    return tableData != null;
  }

  String currentTahun = '2019';

  void getData() async {
    try {
      setState(() {
        isError = false;
      });
      final data = await widget.financeController.fetchGrafikCapex();

      List<Capex> companies =
          await widget.financeController.fetchCapex(tahun: currentTahun);
      companies
          .sort((a, b) => int.parse(b.jumlah).compareTo(int.parse(a.jumlah)));
      setState(() {
        this.capex = companies;
      });

      setState(() {
        this.tableData = data;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        isError = true;
      });
    }
  }

  Widget chartWidget(BuildContext context) {
    return CustomBarChart(
      items: tableData,
      colorPalette: widget.colorPalette,
    );
  }

  void filterCompany(String query) {
    if (capex.isEmpty) return;
    final filtered = capex.where((company) {
      return company.namaPerusahaan.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      this.filteredCapex = filtered;
    });
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SearchBar(
          colorPalette: widget.colorPalette,
          controller: _searchController,
          onChanged: (query) => filterCompany(query),
          labelText: "Cari perusahaan disini",
          hintText: "Masukkan nama perusahaan."),
    );
  }

  Widget queryNotFoundError(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          "Mohon maaf, data yang Anda cari tidak tersedia. Silakan coba dengan pencarian lain.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: widget.colorPalette.black),
        ),
      ),
    );
  }

  Widget tableWidget(BuildContext context, List<Capex> companies) {
    final List<CapexDetailedPageModel> convertedData = [];
    final store = StoreProvider.of<AppState>(context);
    companies.forEach((datum) {
      if (datum != null)
        convertedData.add(
          CapexDetailedPageModel(
              id: datum.id,
              namaPerusahaan: store.getNamaPendek(datum.namaPerusahaan),
              periode: datum.periodeNama,
              total: parseDouble(datum.jumlah) / Constants.million),
        );
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "* Jumlah dalam triliun rupiah",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          SingleListView<CapexDetailedPageModel>(
            colorPalette: widget.colorPalette,
            onItemTap: (CapexDetailedPageModel item) {
              ApiStatistic().insertStatistic(
                  "Finance", "Detail Profil BUMN ${item.namaPerusahaan} CAPEX");
              widget.actionMapper.openCompanyDetailPage(item.id);
            },
            items: convertedData,
            extraBottomWidget: (CapexDetailedPageModel item) => Text(
              item.periode ?? "-",
              style: TextStyle(
                  color: widget.colorPalette.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            leadingWidget: (CapexDetailedPageModel item) => SumTypeText(
              colorPalette: widget.colorPalette,
              sum: item.total,
            ),
          ),
        ],
      ),
    );
  }

  Widget companyList(BuildContext context, List<Capex> companies) {
    if (companies.isEmpty) return queryNotFoundError(context);

    return tableWidget(context, companies);
  }

  Widget mainWidget(BuildContext context) {
    return Container(
      color: widget.colorPalette.defaultBg,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          chartWidget(context),
          SizedBox(
            height: 16.0,
          ),
          searchBar(context),
          companyList(
            context,
            _searchController.text.isNotEmpty ? filteredCapex : capex,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: Strings.getString("CapexPage.Title"),
      body: (ctx) => SafeArea(
        child: !isDataAvailable()
            ? isError
                ? CustomErrorWidget(
                    onRetry: () => getData(),
                  )
                : LoadingWidget(
                    colorPalette: widget.colorPalette,
                  )
            : mainWidget(context),
      ),
    );
  }
}
