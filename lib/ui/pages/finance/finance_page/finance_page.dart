import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/grafik_apbn.dart';
import 'package:bumn_eid/core/models/finance/ebitda.dart';
import 'package:bumn_eid/core/models/finance/grafik_capex.dart';
import 'package:bumn_eid/core/models/finance/grafik_laba_rugi.dart';
import 'package:bumn_eid/core/models/finance/grafik_posisi_keuangan.dart';
import 'package:bumn_eid/core/models/finance/grafik_suspi.dart';
import 'package:bumn_eid/core/models/finance/loan.dart';
import 'package:bumn_eid/core/models/finance/revenue.dart';
import 'package:bumn_eid/core/models/finance/third_party_loan.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loadable_widget.dart';
import 'package:bumn_eid/ui/pages/finance/finance_page/di/finance_page_graph.dart';
import 'package:bumn_eid/ui/pages/finance/finance_page/finance_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class FinancePage extends StatefulWidget with InjectableWidget {
  final FinancePageGraph _graph;

  FinancePage([graph]) : this._graph = graph ?? FinancePageGraph() {
    setup();
  }

  //injected
  ColorPalette colorPalette;
  //injected
  FinancePageActionMapper actionMapper;
  //injected
  Store<AppState> store;
  FinanceController financeController;

  @override
  FinancePageGraph graph() => _graph;

  @override
  _FinancePageState createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  Map<String, List<GrafikPosisiKeuangan>> posisiKeuanganData;
  Map<String, List<GrafikLabaRugi>> labaRugiData;
  List<GrafikCapex> capexData;
  Map<String, List<Revenue>> revenue;
  Map<String, List<GrafikAPBN>> apbnData;
  Map<String, List<Ebitda>> ebitda;
  Map<String, List<Loan>> loan;
  Map<String, List<ThirdPartyLoan>> thirdPartyLoan;
  Map<String, List<GrafikSuspi>> suspiLoan;

  fetchLoan() async {
    Map<String, List<Loan>> data = {};
    List<Loan> companies = await widget.financeController.fetchLoan();

    companies.forEach((company) {
      if (data.containsKey(company.tahun.toString())) {
        data[company.tahun.toString()].add(company);
      } else {
        data[company.tahun.toString()] = [company];
      }
    });

    Map<String, List<ThirdPartyLoan>> thirdData = {};
    List<ThirdPartyLoan> thirdCompanies =
        await widget.financeController.fetchThirdPartyLoan();

    thirdCompanies.forEach((company) {
      if (thirdData.containsKey(company.tahun.toString())) {
        thirdData[company.tahun.toString()].add(company);
      } else {
        thirdData[company.tahun.toString()] = [company];
      }
    });

    final suspiData = await widget.financeController.fetchGrafikSuspi();
    final Map<String, List<GrafikSuspi>> chartData = {};
    suspiData.forEach((datum) {
      if (chartData.containsKey(datum.tahun.toString())) {
        chartData[datum.tahun.toString()]..add(datum);
      } else {
        chartData[datum.tahun.toString()] = [datum];
      }
    });

    setState(() {
      this.loan = data;
      this.thirdPartyLoan = thirdData;
      this.suspiLoan = chartData;
    });
  }

  fetchEbitda() async {
    Map<String, List<Ebitda>> data = {};
    List<Ebitda> companies =
        await widget.financeController.fetchEbitda(tahun: "2019");
    List<Ebitda> companies2018 =
        await widget.financeController.fetchEbitda(tahun: "2018");
    List<Ebitda> companies2017 =
        await widget.financeController.fetchEbitda(tahun: "2017");
    companies..addAll(companies2018)..addAll(companies2017);

    companies.forEach((company) {
      if (data.containsKey(company.tahun.toString())) {
        data[company.tahun.toString()].add(company);
      } else {
        data[company.tahun.toString()] = [company];
      }
    });

    setState(() {
      ebitda = data;
    });
  }

  fetchApbn() async {
    final dividen = await widget.financeController.fetchGrafikDividen();
    final pajak = await widget.financeController.fetchGrafikPajak();
    final pnbp = await widget.financeController.fetchGrafikPnbp();

    Map<String, List<GrafikAPBN>> chartData = {};
    chartData['Dividen'] = dividen;
    chartData['Pajak'] = pajak;
    chartData['PNBP'] = pnbp;

    setState(() {
      this.apbnData = chartData;
    });
  }

  fetchRevenue() async {
    Map<String, List<Revenue>> data = {};
    List<Revenue> companies =
        await widget.financeController.fetchRevenue(tahun: "2019");
    List<Revenue> companies2018 =
        await widget.financeController.fetchRevenue(tahun: "2018");
    List<Revenue> companies2017 =
        await widget.financeController.fetchRevenue(tahun: "2017");
    companies..addAll(companies2018)..addAll(companies2017);

    companies.forEach((company) {
      if (data.containsKey(company.tahun)) {
        data[company.tahun].add(company);
      } else {
        data[company.tahun] = [company];
      }
    });

    setState(() {
      this.revenue = data;
    });
  }

  fetchCapex() async {
    final data = await widget.financeController.fetchGrafikCapex();

    setState(() {
      capexData = data;
    });
  }

  fetchLabaRugi() async {
    final data = await widget.financeController.fetchGrafikLabaRugi();
    Map<String, List<GrafikLabaRugi>> chartData = {};
    data.forEach((grafikData) {
      if (chartData.containsKey('Laba')) {
        chartData['Laba'] = [
          ...chartData['Laba'],
          GrafikLabaRugi(
            tahun: grafikData.tahun,
            jumlah: grafikData.laba,
          )
        ];
      } else {
        chartData['Laba'] = [
          GrafikLabaRugi(
            tahun: grafikData.tahun,
            jumlah: grafikData.laba,
          )
        ];
      }

      if (chartData.containsKey('Laba Bersih')) {
        chartData['Laba Bersih'] = [
          ...chartData['Laba Bersih'],
          GrafikLabaRugi(
            tahun: grafikData.tahun,
            jumlah: grafikData.labaBersih,
          )
        ];
      } else {
        chartData['Laba Bersih'] = [
          GrafikLabaRugi(
            tahun: grafikData.tahun,
            jumlah: grafikData.labaBersih,
          )
        ];
      }

      if (chartData.containsKey('Rugi')) {
        chartData['Rugi'] = [
          ...chartData['Rugi'],
          GrafikLabaRugi(
            tahun: grafikData.tahun,
            jumlah: grafikData.rugi,
          )
        ];
      } else {
        chartData['Rugi'] = [
          GrafikLabaRugi(
            tahun: grafikData.tahun,
            jumlah: grafikData.rugi,
          )
        ];
      }
    });

    setState(() {
      this.labaRugiData = chartData;
    });
  }

  fetchPosisiKeuangan() async {
    final data = await widget.financeController.fetchGrafikPosisiKeuangan();
    Map<String, List<GrafikPosisiKeuangan>> chartData = {};
    data.forEach((grafikData) {
      if (chartData.containsKey(grafikData.jenisAkun)) {
        chartData[grafikData.jenisAkun].add(grafikData);
      } else {
        chartData[grafikData.jenisAkun] = [grafikData];
      }
    });
    chartData.values.forEach((list) {
      list.sort((GrafikPosisiKeuangan a, GrafikPosisiKeuangan b) =>
          int.parse(a.tahun).compareTo(int.parse(b.tahun)));
    });

    setState(() {
      this.posisiKeuanganData = chartData;
    });
  }

  String currentTahun = '2019';

  Widget menuWidgets(BuildContext context) {
    return LoadableWidget(
        fetchFunction: () async {
          await fetchPosisiKeuangan();
          await fetchLabaRugi();
          await fetchCapex();
          await fetchRevenue();
          await fetchApbn();
          await fetchEbitda();
          await fetchLoan();

          return 0;
        },
        colorPalette: ColorPalette(),
        buildFunction: (ctx, data) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Transform.translate(
                  offset: Offset(0, 5),
                  child: Text(
                    "Tahun Audited",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                FilterWidget(
                  items: [
                    '2019',
                    '2018',
                    '2017',
                  ],
                  currentItem: currentTahun,
                  onChanged: (a) {
                    setState(() {
                      currentTahun = a;
                    });
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                InkWell(
                  onTap: () {
                    ApiStatistic()
                        .insertStatistic("Finance", "List Posisi Keungan");
                    widget.actionMapper.openPosisiKeuangan();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.0,
                          blurRadius: 4,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'res/images/posisi_keuangan.png',
                          width: 50.0,
                          height: 40.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Posisi Keuangan',
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:
                                    posisiKeuanganData.keys.map((element) {
                                  final data = posisiKeuanganData[element]
                                      .firstWhere(
                                          (a) => a.tahun == currentTahun);
                                  return Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          element,
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFF222933),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          parseDouble(data.jumlah)
                                                  .toStringAsFixed(2) +
                                              ' T',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFFD8B005),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Color(0xFF1B478D),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                InkWell(
                  onTap: () {
                    ApiStatistic().insertStatistic("Finance", "List Laba Rugi");
                    widget.actionMapper.openLabaRugi();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.0,
                          blurRadius: 4,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'res/images/laba_rugi.png',
                          width: 50.0,
                          height: 40.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Laba Rugi',
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: labaRugiData.keys.map((element) {
                                  final data = labaRugiData[element].firstWhere(
                                      (a) => a.tahun == currentTahun);
                                  return Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          element,
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFF222933),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          parseDouble(data.jumlah)
                                                  .toStringAsFixed(2) +
                                              ' T',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFFD8B005),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Color(0xFF1B478D),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                InkWell(
                  onTap: () {
                    ApiStatistic().insertStatistic("Finance", "List CAPEX");
                    widget.actionMapper.openCapex();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.0,
                          blurRadius: 4,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'res/images/capex.png',
                          width: 50.0,
                          height: 40.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CAPEX',
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                capexData
                                        .fold(
                                            0,
                                            (a, b) => b.tahun.toString() ==
                                                    currentTahun
                                                ? a + b.jumlah
                                                : a)
                                        .toString() +
                                    ' T',
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0,
                                  color: Color(0xFFD8B005),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Color(0xFF1B478D),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                InkWell(
                  onTap: () {
                    ApiStatistic().insertStatistic("Finance", "List Revenue");
                    widget.actionMapper.openRevenue();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.0,
                          blurRadius: 4,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'res/images/revenue.png',
                          width: 50.0,
                          height: 40.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Revenue',
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                (revenue[currentTahun].toList().fold(
                                                0,
                                                (a, b) =>
                                                    b.tahun == currentTahun
                                                        ? a + b.jumlah
                                                        : a) /
                                            1000000)
                                        .toStringAsFixed(2) +
                                    ' T',
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0,
                                  color: Color(0xFFD8B005),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Color(0xFF1B478D),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                InkWell(
                  onTap: () {
                    ApiStatistic().insertStatistic("Finance", "List Debt");
                    widget.actionMapper.openLoan();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.0,
                          blurRadius: 4,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'res/images/debt.png',
                          width: 50.0,
                          height: 40.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Debt',
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          'Dana Pihak Ketiga',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFF222933),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          (thirdPartyLoan[currentTahun].fold(
                                                          0,
                                                          (a, b) =>
                                                              a +
                                                              double.parse(
                                                                      b.jumlah)
                                                                  .toInt()) /
                                                      Constants.million)
                                                  .toStringAsFixed(2) +
                                              ' T',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFFD8B005),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          'Pinjaman',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFF222933),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          (loan[currentTahun].fold(
                                                          0,
                                                          (a, b) =>
                                                              a +
                                                              double.parse(
                                                                      b.jumlah)
                                                                  .toInt()) /
                                                      Constants.million)
                                                  .toStringAsFixed(2) +
                                              ' T',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFFD8B005),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          'Surat Utang',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFF222933),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          (loan[currentTahun].fold(
                                                          0,
                                                          (a, b) =>
                                                              a +
                                                              double.parse(b
                                                                      .obligasi)
                                                                  .toInt()) /
                                                      Constants.million)
                                                  .toStringAsFixed(2) +
                                              ' T',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFFD8B005),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          'Liabilitas Lain',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFF222933),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          (suspiLoan[currentTahun].fold(0,
                                                          (a, b) {
                                                        return b.jenisAkun ==
                                                                'Liabilitas Lain'
                                                            ? a +
                                                                double.parse(b
                                                                        .jumlah)
                                                                    .toInt()
                                                            : a;
                                                      }) /
                                                      Constants.million)
                                                  .toStringAsFixed(2) +
                                              ' T',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFFD8B005),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          'Cadangan Teknis Asuransi',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFF222933),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          (suspiLoan[currentTahun].fold(
                                                          0,
                                                          (a, b) => b.jenisAkun ==
                                                                  'Cadangan Teknis Asuransi'
                                                              ? a +
                                                                  double.parse(b
                                                                          .jumlah)
                                                                      .toInt()
                                                              : a) /
                                                      Constants.million)
                                                  .toStringAsFixed(2) +
                                              ' T',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFFD8B005),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          'Cadangan Utang Usaha',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFF222933),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          (suspiLoan[currentTahun].fold(0,
                                                          (a, b) {
                                                        return b.jenisAkun ==
                                                                'Cadangan Utang Usaha'
                                                            ? a +
                                                                double.parse(b
                                                                        .jumlah)
                                                                    .toInt()
                                                            : a;
                                                      }) /
                                                      Constants.million)
                                                  .toStringAsFixed(2) +
                                              ' T',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFFD8B005),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Color(0xFF1B478D),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                InkWell(
                  onTap: () {
                    ApiStatistic().insertStatistic("Finance", "List Ebitda");
                    widget.actionMapper.openEbitda();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.0,
                          blurRadius: 4,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'res/images/ebitda.png',
                          width: 50.0,
                          height: 40.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'EBITDA',
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0,
                                ),
                              ),
                              // Text(
                              // ebitda[currentTahun]
                              //         .fold(0, (a, b) => a + b.jumlah)
                              //         .toString() +
                              //     ' T',
                              //   style: TextStyle(
                              //     fontFamily: 'poppins',
                              //     fontWeight: FontWeight.w500,
                              //     fontSize: 12.0,
                              //     color: Color(0xFFD8B005),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Color(0xFF1B478D),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                InkWell(
                  onTap: () {
                    ApiStatistic().insertStatistic(
                        "Finance", "List Kontribusi Pada Negara");
                    widget.actionMapper.openKontribusiApbn();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.0,
                          blurRadius: 4,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'res/images/finance_icon.png',
                          width: 50.0,
                          height: 40.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kontribusi Pada Negara',
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: apbnData.keys.map((element) {
                                  final data = apbnData[element].firstWhere(
                                      (a) => a.tahun == currentTahun);
                                  return Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          element,
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFF222933),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          parseDouble(data.jumlah)
                                                  .toStringAsFixed(2) +
                                              ' T',
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color(0xFFD8B005),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Color(0xFF1B478D),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          );
        });
  }

  Widget mainWidget(BuildContext context) {
    return Container(
      color: Color(0xFFEEEFF3),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        children: <Widget>[
          menuWidgets(context),
          SizedBox(
            height: 16.0,
          ),
          LastUpdateWidget(
            pageName: "finance",
            store: widget.store,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Finance',
      body: (ctx) => mainWidget(ctx),
    );
  }
}
