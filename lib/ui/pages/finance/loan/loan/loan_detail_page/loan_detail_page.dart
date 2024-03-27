import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/bigger_custom_table.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/finance/loan/loan/loan_detail_page/di/loan_detail_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class LoanDetailData with BiggerCustomTableData {
  final int amount;
  final String key;
  final int tahun;

  LoanDetailData({this.amount, this.key, this.tahun});

  @override
  int getJumlah() {
    return amount;
  }

  @override
  String getTahun() {
    return tahun.toString();
  }
}

// ignore: must_be_immutable
class LoanDetailPage extends StatefulWidget with InjectableWidget {
  final LoanDetailPageGraph _graph;

  final String bumnId;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;
  //injected
  FinanceController financeController;

  LoanDetailPage({@required this.bumnId, LoanDetailPageGraph graph})
      : this._graph = graph ?? LoanDetailPageGraph() {
    setup();
  }

  @override
  LoanDetailPageGraph graph() => _graph;

  @override
  _LoanDetailPageState createState() => _LoanDetailPageState();
}

class _LoanDetailPageState extends State<LoanDetailPage>
    with AfterLayoutMixin<LoanDetailPage> {
  bool isError = false;

  Map<String, List<LoanDetailData>> data;
  ProfilPerusahaan company;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return data != null && company != null;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      Map<String, List<LoanDetailData>> data = {
        // "Obligasi": [],
        // "MTN": [],
        // "NCD": [],
        // "Sukuk": [],
        // "Efek Lain": [],
        "Utang Bank": [],
        "Utang Pemerintah R.I.": [],
        "Pinjaman Subordinasi": [],
        "Utang SP": []
      };
      final fetchedData =
          await widget.financeController.fetchLoanById(id: widget.bumnId);
      final fetchedPinjamanLain = await widget.financeController
          .fetchPinjamanLain(companyId: widget.bumnId, tahun: "2019");
      final fetchedPinjamanLain2018 = await widget.financeController
          .fetchPinjamanLain(companyId: widget.bumnId, tahun: "2018");
      final fetchedPinjamanLain2017 = await widget.financeController
          .fetchPinjamanLain(companyId: widget.bumnId, tahun: "2017");
      fetchedPinjamanLain
        ..addAll(fetchedPinjamanLain2018)
        ..addAll(fetchedPinjamanLain2017);
      final company = widget.store.state.companiesState.companies
          .firstWhere((company) => company.id == widget.bumnId);

      fetchedData.forEach((datum) {
        // data["Obligasi"]
        //   ..add(LoanDetailData(
        //       amount: parseDouble(datum.obligasi).toInt(),
        //       tahun: datum.tahun,
        //       key: "Obligasi"));
        // data["MTN"]
        //   ..add(LoanDetailData(
        //       amount: parseDouble(datum.mtn).toInt(),
        //       tahun: datum.tahun,
        //       key: "MTN"));
        // data["NCD"]
        //   ..add(LoanDetailData(
        //       amount: parseDouble(datum.ncd).toInt(),
        //       tahun: datum.tahun,
        //       key: "NCD"));
        // data["Sukuk"]
        //   ..add(LoanDetailData(
        //       amount: parseDouble(datum.sukuk).toInt(),
        //       tahun: datum.tahun,
        //       key: "Sukuk"));
        // data["Efek Lain"]
        //   ..add(LoanDetailData(
        //       amount: parseDouble(datum.efekLain).toInt(),
        //       tahun: datum.tahun,
        //       key: "Efek Lain"));
      });

      fetchedPinjamanLain.forEach((datum) {
        data["Utang Bank"]
          ..add(LoanDetailData(
              amount: datum.utangBank, tahun: datum.tahun, key: "Utang Bank"));
        data["Utang Pemerintah R.I."]
          ..add(LoanDetailData(
              amount: datum.utangRi,
              tahun: datum.tahun,
              key: "Utang Pemerintah R.I."));
        data["Pinjaman Subordinasi"]
          ..add(LoanDetailData(
              amount: datum.pinjSubordinasi,
              tahun: datum.tahun,
              key: "Pinjaman Subordinasi"));
        data["Utang SP"]
          ..add(LoanDetailData(
              amount: datum.utangSp, tahun: datum.tahun, key: "Utang SP"));
      });

      data.keys.forEach((key) {
        data[key]..sort((a, b) => a.tahun.compareTo(b.tahun));
      });

      setState(() {
        this.data = data;
        this.company = company;
      });
    } catch (ex) {
      print(ex.toString());
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget kontribusiWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: BiggerCustomTable(
        colorPalette: widget.colorPalette,
        color: Color(0xffFF4200),
        title: "Jenis Utang",
        data: data,
      ),
    );
  }

  Widget detailsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          kontribusiWidget(context),
        ],
      ),
    );
  }

  Widget companyImage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 84.0,
      width: 84.0,
      child: CachedNetworkImage(
        imageUrl: company.logo,
        placeholder: (context, _) => CircularProgressIndicator(
          valueColor:
              new AlwaysStoppedAnimation<Color>(widget.colorPalette.primary),
        ),
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return !isDataReady()
        ? isError
            ? CustomErrorWidget(
                onRetry: () => getData(),
              )
            : LoadingWidget(
                colorPalette: widget.colorPalette,
              )
        : Container(
            color: widget.colorPalette.defaultBg,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                companyImage(context),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Text(
                      company.nama,
                      style: TextStyle(
                          color: widget.colorPalette.black, fontSize: 18.0),
                    ),
                  ),
                ),
              ]..add(detailsList(context)),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Detail Debt',
      body: (ctx) => mainWidget(context),
    );
  }
}
