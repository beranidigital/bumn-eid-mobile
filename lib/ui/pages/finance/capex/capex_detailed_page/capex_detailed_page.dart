import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/finance/capex.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/finance/capex/capex_detailed_page/capex_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/capex/capex_detailed_page/di/capex_detailed_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class CapexDetailedPageModel with SingleListItem {
  final String id;
  final String namaPerusahaan;
  final String periode;
  final num total;

  CapexDetailedPageModel(
      {@required this.id,
      @required this.namaPerusahaan,
      @required this.periode,
      @required this.total});

  @override
  String getTitle() {
    return namaPerusahaan;
  }
}

// ignore: must_be_immutable
class CapexDetailedPage extends StatefulWidget with InjectableWidget {
  final CapexDetailedPageGraph _graph;

  final String tahun;

  //injected
  ColorPalette colorPalette;
  //injected
  FinanceController financeController;
  //injected
  CapexDetailedActionMapper actionMapper;
  //injected
  Store<AppState> store;

  CapexDetailedPage({@required this.tahun, CapexDetailedPageGraph graph})
      : this._graph = graph ?? CapexDetailedPageGraph() {
    setup();
  }

  @override
  CapexDetailedPageGraph graph() => _graph;

  @override
  _CapexDetailedPageState createState() => _CapexDetailedPageState();
}

class _CapexDetailedPageState extends State<CapexDetailedPage>
    with AfterLayoutMixin<CapexDetailedPage> {
  bool isError = false;

  List<Capex> capex = [];
  List<Capex> filteredCapex = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      List<Capex> companies =
          await widget.financeController.fetchCapex(tahun: widget.tahun);
      companies
          .sort((a, b) => int.parse(b.jumlah).compareTo(int.parse(a.jumlah)));
      setState(() {
        this.capex = companies;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        this.isError = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
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
    companies.forEach((datum) {
      if (datum != null)
        convertedData.add(CapexDetailedPageModel(
            id: datum.id,
            namaPerusahaan: widget.store.getNamaPendek(datum.namaPerusahaan),
            periode: datum.periodeNama,
            total: parseDouble(datum.jumlah) / Constants.million));
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
            onItemTap: (CapexDetailedPageModel item) =>
                widget.actionMapper.openCompanyDetailPage(item.id),
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
    return capex.isEmpty && _searchController.text.isEmpty
        ? isError
            ? CustomErrorWidget(
                onRetry: () => getData(),
              )
            : LoadingWidget(
                colorPalette: widget.colorPalette,
              )
        : Container(
            color: widget.colorPalette.defaultBg,
            child: ListView(padding: const EdgeInsets.all(16.0), children: [
              searchBar(context),
              companyList(context,
                  _searchController.text.isNotEmpty ? filteredCapex : capex)
            ]),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Capex Tahun ${widget.tahun}",
      body: (ctx) => mainWidget(context),
    );
  }
}
