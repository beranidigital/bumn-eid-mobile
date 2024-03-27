import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/finance/grafik_posisi_keuangan.dart';
import 'package:bumn_eid/core/models/finance/posisi_keuangan.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/strings/strings.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_list_bar_chart.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/finance/posisi_keuangan/posisi_keuangan_detailed_page/posisi_keuangan_detailed_page.dart';
import 'package:bumn_eid/ui/pages/finance/posisi_keuangan/posisi_keuangan_page/di/posisi_keuangan_page_graph.dart';
import 'package:bumn_eid/ui/pages/finance/posisi_keuangan/posisi_keuangan_page/posisi_keuangan_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PosisiKeuanganPageModel with SingleListItem {
  final String jenisAkun;
  final int total;

  PosisiKeuanganPageModel({@required this.jenisAkun, @required this.total});

  @override
  String getTitle() {
    return jenisAkun;
  }
}

// ignore: must_be_immutable
class PosisiKeuanganPage extends StatefulWidget with InjectableWidget {
  final PosisiKeuanganPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  PosisiKeuanganActionMapper actionMapper;
  //injected
  FinanceController financeController;

  @override
  PosisiKeuanganPageGraph graph() => _graph;

  PosisiKeuanganPage([graph])
      : this._graph = graph ?? PosisiKeuanganPageGraph() {
    setup();
  }

  @override
  _PosisiKeuanganPageState createState() => _PosisiKeuanganPageState();
}

class _PosisiKeuanganPageState extends State<PosisiKeuanganPage>
    with AfterLayoutMixin<PosisiKeuanganPage> {
  final tahunList = ["2017", "2018", "2019"];
  int currentTahunIndex = 2;
  String currentTahun = '2019';
  Map<String, List<GrafikPosisiKeuangan>> tableData;
  Map<String, List<PosisiKeuangan>> posisiKeuangan;
  Map<String, List<PosisiKeuangan>> filteredPosisiKeuangan;
  bool isError = false;

  TextEditingController _searchController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
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

  String currentJenisAkun = 'Aset';

  bool isDataAvailable() {
    return tableData != null;
  }

  void getData() async {
    try {
      setState(() {
        posisiKeuangan = null;
        tableData = null;
        isError = false;
      });
      final data = await widget.financeController.fetchGrafikPosisiKeuangan();
      Map<String, List<GrafikPosisiKeuangan>> chartData = {};
      data.forEach((grafikData) {
        if (chartData.containsKey(grafikData.tahun)) {
          chartData[grafikData.tahun].add(grafikData);
        } else {
          chartData[grafikData.tahun] = [grafikData];
        }
      });

      Map<String, List<PosisiKeuangan>> data2 = {};
      List<PosisiKeuangan> companies = await widget.financeController
          .fetchPosisiKeuangan(jenisAkun: currentJenisAkun, tahun: "2019");
      List<PosisiKeuangan> companies2018 = await widget.financeController
          .fetchPosisiKeuangan(jenisAkun: currentJenisAkun, tahun: "2018");
      List<PosisiKeuangan> companies2017 = await widget.financeController
          .fetchPosisiKeuangan(jenisAkun: currentJenisAkun, tahun: "2017");
      companies..addAll(companies2018)..addAll(companies2017);

      companies.forEach((company) {
        if (data2.containsKey(company.namaPerusahaan)) {
          data2[company.namaPerusahaan].add(company);
        } else {
          data2[company.namaPerusahaan] = [company];
        }
      });

      setState(() {
        this.posisiKeuangan = data2;
      });

      processData(chartData);
    } catch (ex) {
      print(ex);
      setState(() {
        isError = true;
      });
    }
  }

  processData(Map<String, List<GrafikPosisiKeuangan>> chartData) {
    chartData.values.forEach((list) {
      list.sort((GrafikPosisiKeuangan a, GrafikPosisiKeuangan b) =>
          int.parse(a.tahun).compareTo(int.parse(b.tahun)));
    });

    Map<String, List<GrafikPosisiKeuangan>> sortedData =
        sortBasedOnKey<GrafikPosisiKeuangan>(chartData);

    setState(() {
      this.tableData = sortedData;
    });
  }

  Widget chartWidget(BuildContext context) {
    return CustomListBarChart(
      colorPalette: widget.colorPalette,
      data: tableData,
      intervalY: 2000,
      leftPadding: 36,
      topPadding: 1000,
      keyToColor: {
        "Aset": Color(0xFFFE8282),
        "Liabilitas": Color(0xFFFBD300),
        "Ekuitas": Color(0xFF4572E5),
      },
    );
  }

  Widget filterItem(
      BuildContext context, List<GrafikPosisiKeuangan> data, String key) {
    return InkWell(
      onTap: () {
        setState(() {
          currentJenisAkun = key;
        });

        getData();
      },
      child: Container(
        decoration: BoxDecoration(
          color: currentJenisAkun == key ? Color(0xFF1FA4CA) : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.0,
              blurRadius: 4,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              key,
              style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color:
                    currentJenisAkun == key ? Colors.white : Color(0xFF1FA4CA),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              tableData[currentTahun]
                  .where((a) => a.jenisAkun == key)
                  .first
                  .jumlah
                  .toString(),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'poppins',
                color:
                    currentJenisAkun == key ? Colors.white : Color(0xFF1FA4CA),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterWidget(BuildContext context) {
    List<GrafikPosisiKeuangan> data = tableData.values
        .toList()
        .fold([], (a, b) => a == null ? b : [...a, ...b]);
    return Container(
      height: 100.0,
      margin: EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          filterItem(
            context,
            data,
            'Aset',
          ),
          SizedBox(
            width: 16.0,
          ),
          filterItem(
            context,
            data,
            'Liabilitas',
          ),
          SizedBox(
            width: 16.0,
          ),
          filterItem(
            context,
            data,
            'Ekuitas',
          ),
          SizedBox(
            width: 16.0,
          ),
        ],
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

    final store = StoreProvider.of<AppState>(context);

    final List<PosisiKeuanganDetailedPageModel> convertedData = [];
    filteredCompanies.values.forEach((datum) {
      if (datum != null)
        convertedData.add(PosisiKeuanganDetailedPageModel(
            id: datum.id,
            namaPerusahaan: store.getNamaPendek(datum.namaPerusahaan),
            periode: datum.periodeNama,
            total: parseDouble(datum.jumlah) / Constants.million));
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "* Jumlah dalam triliun rupiah",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          SingleListView<PosisiKeuanganDetailedPageModel>(
            colorPalette: widget.colorPalette,
            onItemTap: (PosisiKeuanganDetailedPageModel item) {
              ApiStatistic().insertStatistic("Finance",
                  "Detail Profil BUMN ${item.namaPerusahaan} Posisi Keuangan");
              widget.actionMapper.openCompanyDetailPage(item.id);
            },
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

  Widget companyList(
    BuildContext context,
    Map<String, List<PosisiKeuangan>> companies,
  ) {
    if (companies != null && companies.isEmpty)
      return queryNotFoundError(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: companyWidget(context, companies),
    );
  }

  Widget tableWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: searchBar(context),
                ),
                SizedBox(
                  width: 16.0,
                ),
                FilterWidget(
                  items: tahunList,
                  title: "Filter Tahun",
                  width: 100.0,
                  currentItem: tahunList.toList()[currentTahunIndex],
                  onChanged: (newTahun) {
                    final newIdx = (parseInt(newTahun) - 2017);
                    setState(() {
                      this.currentTahunIndex = newIdx;
                      this.currentTahun = newTahun;
                    });
                  },
                ),
              ],
            ),
          ),
          filterWidget(context),
          companyList(
              context,
              _searchController.text.isNotEmpty
                  ? filteredPosisiKeuangan
                  : posisiKeuangan),
        ],
      ),
    );
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
          tableWidget(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: Strings.getString("PosisiKeuanganPage.Title"),
      body: (ctx) => !isDataAvailable()
          ? isError
              ? CustomErrorWidget(
                  onRetry: () => getData(),
                )
              : LoadingWidget(
                  colorPalette: widget.colorPalette,
                )
          : mainWidget(context),
    );
  }
}
