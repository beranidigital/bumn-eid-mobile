import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/finance/grafik_laba_rugi.dart';
import 'package:bumn_eid/core/models/finance/laba_rugi.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/strings/strings.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_list_bar_chart.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/finance/labarugi/laba_rugi_detailed_page/laba_rugi_detailed_page.dart';
import 'package:bumn_eid/ui/pages/finance/labarugi/laba_rugi_page/di/laba_rugi_page_graph.dart';
import 'package:bumn_eid/ui/pages/finance/labarugi/laba_rugi_page/laba_rugi_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LabaRugiPageModel with SingleListItem {
  final String jenisAkun;
  final num total;

  LabaRugiPageModel({@required this.jenisAkun, @required this.total});

  @override
  String getTitle() {
    return jenisAkun;
  }
}

// needed to be done because the form of datas on this page aren't the same with other page
class GrafikLabaRugiDetailed with ListBarChartDataType {
  String tahun;
  String jenis;
  String jumlah;
  String akun;

  GrafikLabaRugiDetailed(
      {@required this.tahun,
      @required this.jenis,
      @required this.jumlah,
      @required this.akun});

  @override
  String getColorKey() {
    return jenis.toString().replaceAll("_", " ");
  }

  @override
  int getX() {
    return tahun.hashCode;
  }

  @override
  double getY() {
    return parseDouble(jumlah).abs();
  }
}

// ignore: must_be_immutable
class LabaRugiPage extends StatefulWidget with InjectableWidget {
  final LabaRugiPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  LabaRugiActionMapper actionMapper;
  //injected
  FinanceController financeController;

  @override
  LabaRugiPageGraph graph() => _graph;

  LabaRugiPage([graph]) : this._graph = graph ?? LabaRugiPageGraph() {
    setup();
  }

  @override
  _LabaRugiPageState createState() => _LabaRugiPageState();
}

class _LabaRugiPageState extends State<LabaRugiPage>
    with AfterLayoutMixin<LabaRugiPage> {
  final tahunList = Constants.tahunList.map((e) => e.toString()).toList();
  String currentTahun = Constants.latestDataYear;

  Map<String, GrafikLabaRugi> tableData;
  Map<String, List<LabaRugi>> labaRugi;
  Map<String, List<LabaRugi>> filteredLabaRugi;
  TextEditingController _searchController = TextEditingController();
  bool isError = false;

  String currentJenis = 'Laba';
  int counter = 0;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataAvailable() {
    return tableData != null;
  }

  void getData() async {
    try {
      setState(() {
        labaRugi = null;
        tableData = null;
        isError = false;
      });
      final data = await widget.financeController.fetchGrafikLabaRugi();
      Map<String, GrafikLabaRugi> chartData = {};
      data.forEach((grafikData) {
        chartData[grafikData.tahun] = grafikData;
      });

      Map<String, List<LabaRugi>> data2 = {};
      List<LabaRugi> companies = await widget.financeController
          .fetchLabaRugi(jenisAkun: currentJenis, tahun: "2019");
      List<LabaRugi> companies2018 = await widget.financeController
          .fetchLabaRugi(jenisAkun: currentJenis, tahun: "2018");
      List<LabaRugi> companies2017 = await widget.financeController
          .fetchLabaRugi(jenisAkun: currentJenis, tahun: "2017");
      companies..addAll(companies2018)..addAll(companies2017);

      companies.forEach((company) {
        if (data2.containsKey(company.namaPerusahaan)) {
          data2[company.namaPerusahaan].add(company);
        } else {
          data2[company.namaPerusahaan] = [company];
        }
      });

      setState(() {
        this.labaRugi = data2;
      });

      setState(() {
        this.tableData = chartData;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        isError = true;
      });
    }
  }

  Widget chartWidget(BuildContext context) {
    return CustomListBarChart(
      colorPalette: widget.colorPalette,
      data: mapLabaRugiToList(tableData),
      leftPadding: 24.0,
      intervalY: 50,
      keyToColor: {
        "Laba": Color(0xFF4572E5),
        "Laba Bersih": Color(0xFFFBD300),
        "Rugi (Negatif)": Colors.redAccent,
      },
    );
  }

  Widget filterItem(
      BuildContext context, List<GrafikLabaRugi> data, String key) {
    return InkWell(
      onTap: () {
        setState(() {
          currentJenis = key;
        });

        getData();
      },
      child: Container(
        decoration: BoxDecoration(
          color: currentJenis == key ? Color(0xFF1FA4CA) : Colors.white,
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
                color: currentJenis == key ? Colors.white : Color(0xFF1FA4CA),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              key == 'Laba'
                  ? tableData[currentTahun].laba
                  : (key == 'Laba Bersih'
                      ? tableData[currentTahun].labaBersih
                      : tableData[currentTahun].rugi),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'poppins',
                color: currentJenis == key ? Colors.white : Color(0xFF1FA4CA),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterWidget(BuildContext context) {
    List<GrafikLabaRugi> data =
        tableData.values.toList().fold([], (a, b) => a == null ? b : [...a, b]);
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
            'Laba',
          ),
          SizedBox(
            width: 16.0,
          ),
          filterItem(
            context,
            data,
            'Laba Bersih',
          ),
          SizedBox(
            width: 16.0,
          ),
          filterItem(
            context,
            data,
            'Rugi',
          ),
          SizedBox(
            width: 16.0,
          ),
        ],
      ),
    );
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

  Widget companyList(
      BuildContext context, Map<String, List<LabaRugi>> companies) {
    if (companies != null && companies.isEmpty)
      return queryNotFoundError(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: tableWidget(context, companies),
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

    final store = StoreProvider.of<AppState>(context);
    final List<LabaRugiDetailedPageModel> convertedData = [];
    filteredCompanies.values.forEach((datum) {
      if (datum != null)
        convertedData.add(LabaRugiDetailedPageModel(
            id: datum.id,
            namaPerusahaan: store.getNamaPendek(datum.namaPerusahaan),
            periode: datum.periodeNama,
            total: parseDouble(datum.jumlah) / Constants.million));
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        searchBar(context),
        SizedBox(
          height: 16.0,
        ),
        filterWidget(context),
        SizedBox(
          height: 16.0,
        ),
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
        SingleListView<LabaRugiDetailedPageModel>(
          colorPalette: widget.colorPalette,
          onItemTap: (LabaRugiDetailedPageModel item) {
            ApiStatistic().insertStatistic("Finance",
                "Detail Profil BUMN ${item.namaPerusahaan} Laba Rugi");
            widget.actionMapper.openCompanyDetailPage(item.id);
          },
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

  Widget mainWidget(BuildContext context) {
    return Container(
      color: widget.colorPalette.defaultBg,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          chartWidget(context),
          tableWidget(context,
              _searchController.text.isNotEmpty ? filteredLabaRugi : labaRugi),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: Strings.getString("LabaRugiPage.Title"),
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
