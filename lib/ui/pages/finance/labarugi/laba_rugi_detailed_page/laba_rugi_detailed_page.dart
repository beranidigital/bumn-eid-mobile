import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/finance/laba_rugi.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/finance/labarugi/laba_rugi_detailed_page/di/laba_rugi_detailed_page_graph.dart';
import 'package:bumn_eid/ui/pages/finance/labarugi/laba_rugi_detailed_page/laba_rugi_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class LabaRugiDetailedPageModel with SingleListItem {
  final String id;
  final String namaPerusahaan;
  final String periode;
  final num total;

  LabaRugiDetailedPageModel(
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
class LabaRugiDetailedPage extends StatefulWidget with InjectableWidget {
  final LabaRugiDetailedPageGraph _graph;

  final String jenisLabaRugi;

  //injected
  ColorPalette colorPalette;
  //injected
  FinanceController financeController;
  //injected
  LabaRugiDetailedActionMapper actionMapper;
  //injected
  Store<AppState> store;

  LabaRugiDetailedPage(
      {@required this.jenisLabaRugi, LabaRugiDetailedPageGraph graph})
      : this._graph = graph ?? LabaRugiDetailedPageGraph() {
    setup();
  }

  @override
  LabaRugiDetailedPageGraph graph() => _graph;

  @override
  _LabaRugiDetailedPageState createState() => _LabaRugiDetailedPageState();
}

class _LabaRugiDetailedPageState extends State<LabaRugiDetailedPage>
    with AfterLayoutMixin<LabaRugiDetailedPage> {
  bool isError = false;

  String currentTahun = "2019";
  List<String> tahunList = ["2017", "2018", "2019"];
  Map<String, List<LabaRugi>> labaRugi;
  Map<String, List<LabaRugi>> filteredLabaRugi;
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
      Map<String, List<LabaRugi>> data = {};
      List<LabaRugi> companies = await widget.financeController
          .fetchLabaRugi(jenisAkun: widget.jenisLabaRugi, tahun: "2019");
      List<LabaRugi> companies2018 = await widget.financeController
          .fetchLabaRugi(jenisAkun: widget.jenisLabaRugi, tahun: "2018");
      List<LabaRugi> companies2017 = await widget.financeController
          .fetchLabaRugi(jenisAkun: widget.jenisLabaRugi, tahun: "2017");
      companies..addAll(companies2018)..addAll(companies2017);

      companies.forEach((company) {
        if (data.containsKey(company.namaPerusahaan)) {
          data[company.namaPerusahaan].add(company);
        } else {
          data[company.namaPerusahaan] = [company];
        }
      });

      setState(() {
        this.labaRugi = data;
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
    _searchController?.dispose();
    super.dispose();
  }

  void filterCompany(String query) {
    if (labaRugi == null) return;
    Map<String, List<LabaRugi>> filtered = {};
    final filteredKeys = labaRugi.keys.where((key) {
      return key.toLowerCase().contains(query.toLowerCase());
    }).toList();
    filteredKeys.forEach((key) {
      filtered[key] = labaRugi[key];
    });

    setState(() {
      this.filteredLabaRugi = filtered;
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

  Widget tableWidget(
      BuildContext context, Map<String, List<LabaRugi>> companies) {
    final filteredCompanies = companies.map((k, v) {
      try {
        return MapEntry(
            k, v.firstWhere((a) => a.tahun.toString() == currentTahun));
      } catch (ex) {
        return MapEntry(k, null);
      }
    }).sortBasedOnValue();

    final List<LabaRugiDetailedPageModel> convertedData = [];
    filteredCompanies.values.forEach((datum) {
      if (datum != null)
        convertedData.add(LabaRugiDetailedPageModel(
            id: datum.id,
            namaPerusahaan: widget.store.getNamaPendek(datum.namaPerusahaan),
            periode: datum.periodeNama,
            total: parseDouble(datum.jumlah) / Constants.million));
    });

    return Column(
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
        SingleListView<LabaRugiDetailedPageModel>(
          colorPalette: widget.colorPalette,
          onItemTap: (LabaRugiDetailedPageModel item) =>
              widget.actionMapper.openCompanyDetailPage(item.id),
          items: convertedData,
          extraBottomWidget: (LabaRugiDetailedPageModel item) => Text(
            item.periode,
            style: TextStyle(
                color: widget.colorPalette.black,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          leadingWidget: (LabaRugiDetailedPageModel item) => SumTypeText(
            colorPalette: widget.colorPalette,
            sum: item.total,
          ),
        ),
      ],
    );
  }

  Widget companyList(
      BuildContext context, Map<String, List<LabaRugi>> companies) {
    if (companies != null && companies.isEmpty)
      return queryNotFoundError(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: tableWidget(context, companies),
    );
  }

  Widget filterWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: FilterWidget(
        width: 100,
        title: "Tahun Periode",
        currentItem: currentTahun,
        items: tahunList,
        onChanged: (wamen) {
          setState(() {
            currentTahun = wamen;
          });
        },
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return labaRugi == null && _searchController.text.isEmpty
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: searchBar(context),
                  ),
                  filterWidget(context),
                ],
              ),
              companyList(
                  context,
                  _searchController.text.isNotEmpty
                      ? filteredLabaRugi
                      : labaRugi)
            ]),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.jenisLabaRugi,
      body: (ctx) => mainWidget(context),
    );
  }
}
