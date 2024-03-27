import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/finance/posisi_keuangan.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/finance/posisi_keuangan/posisi_keuangan_detailed_page/di/posisi_keuangan_detailed_page_graph.dart';
import 'package:bumn_eid/ui/pages/finance/posisi_keuangan/posisi_keuangan_detailed_page/posisi_keuangan_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class PosisiKeuanganDetailedPageModel with SingleListItem {
  final String id;
  final String namaPerusahaan;
  final String periode;
  final num total;

  PosisiKeuanganDetailedPageModel(
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
class PosisiKeuanganDetailedPage extends StatefulWidget with InjectableWidget {
  final PosisiKeuanganDetailedPageGraph _graph;

  final String jenisAkun;

  //injected
  ColorPalette colorPalette;
  //injected
  FinanceController financeController;
  //injected
  PosisiKeuanganDetailedActionMapper actionMapper;
  //injected
  Store<AppState> store;

  PosisiKeuanganDetailedPage(
      {@required this.jenisAkun, PosisiKeuanganDetailedPageGraph graph})
      : this._graph = graph ?? PosisiKeuanganDetailedPageGraph() {
    setup();
  }

  @override
  PosisiKeuanganDetailedPageGraph graph() => _graph;

  @override
  _PosisiKeuanganDetailedPageState createState() =>
      _PosisiKeuanganDetailedPageState();
}

class _PosisiKeuanganDetailedPageState extends State<PosisiKeuanganDetailedPage>
    with AfterLayoutMixin<PosisiKeuanganDetailedPage> {
  bool isError = false;

  String currentTahun = "2019";
  List<String> tahunList = ["2017", "2018", "2019"];
  Map<String, List<PosisiKeuangan>> posisiKeuangan;
  Map<String, List<PosisiKeuangan>> filteredPosisiKeuangan;
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
      Map<String, List<PosisiKeuangan>> data = {};
      List<PosisiKeuangan> companies = await widget.financeController
          .fetchPosisiKeuangan(jenisAkun: widget.jenisAkun, tahun: "2019");
      List<PosisiKeuangan> companies2018 = await widget.financeController
          .fetchPosisiKeuangan(jenisAkun: widget.jenisAkun, tahun: "2018");
      List<PosisiKeuangan> companies2017 = await widget.financeController
          .fetchPosisiKeuangan(jenisAkun: widget.jenisAkun, tahun: "2017");
      companies..addAll(companies2018)..addAll(companies2017);

      companies.forEach((company) {
        if (data.containsKey(company.namaPerusahaan)) {
          data[company.namaPerusahaan].add(company);
        } else {
          data[company.namaPerusahaan] = [company];
        }
      });

      setState(() {
        this.posisiKeuangan = data;
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
  }

  void filterCompany(String query) {
    if (PosisiKeuangan == null) return;
    Map<String, List<PosisiKeuangan>> filtered = {};
    final filteredKeys = posisiKeuangan.keys.where((key) {
      return key.toLowerCase().contains(query.toLowerCase());
    }).toList();
    filteredKeys.forEach((key) {
      filtered[key] = posisiKeuangan[key];
    });

    setState(() {
      this.filteredPosisiKeuangan = filtered;
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

  Widget companyWidget(
      BuildContext context, Map<String, List<PosisiKeuangan>> companies) {
    final filteredCompanies = companies.map((k, v) {
      try {
        return MapEntry(
            k, v.firstWhere((a) => a.tahun.toString() == currentTahun));
      } catch (ex) {
        return MapEntry(k, null);
      }
    }).sortBasedOnValue();

    final List<PosisiKeuanganDetailedPageModel> convertedData = [];
    filteredCompanies.values.forEach((datum) {
      if (datum != null)
        convertedData.add(PosisiKeuanganDetailedPageModel(
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
          SingleListView<PosisiKeuanganDetailedPageModel>(
            colorPalette: widget.colorPalette,
            onItemTap: (PosisiKeuanganDetailedPageModel item) =>
                widget.actionMapper.openCompanyDetailPage(item.id),
            items: convertedData,
            extraBottomWidget: (PosisiKeuanganDetailedPageModel item) => Text(
              item.periode,
              style: TextStyle(
                  color: widget.colorPalette.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            leadingWidget: (PosisiKeuanganDetailedPageModel item) =>
                SumTypeText(
              colorPalette: widget.colorPalette,
              sum: item.total,
            ),
          ),
        ],
      ),
    );
  }

  Widget companyList(
      BuildContext context, Map<String, List<PosisiKeuangan>> companies) {
    if (companies != null && companies.isEmpty)
      return queryNotFoundError(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: companyWidget(context, companies),
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
    return posisiKeuangan == null && _searchController.text.isEmpty
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
                      ? filteredPosisiKeuangan
                      : posisiKeuangan)
            ]),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.jenisAkun,
      body: (ctx) => mainWidget(context),
    );
  }
}
