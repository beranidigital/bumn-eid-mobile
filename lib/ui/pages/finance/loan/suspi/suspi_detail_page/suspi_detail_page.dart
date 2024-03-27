import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/bigger_custom_table.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/finance/loan/suspi/suspi_detail_page/di/suspi_detail_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class SuspiDetailData with BiggerCustomTableData {
  final int amount;
  final String key;
  final int tahun;

  SuspiDetailData({this.amount, this.key, this.tahun});

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
class SuspiDetailPage extends StatefulWidget with InjectableWidget {
  final SuspiDetailPageGraph _graph;

  final String bumnId;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;
  //injected
  FinanceController financeController;

  SuspiDetailPage({@required this.bumnId, SuspiDetailPageGraph graph})
      : this._graph = graph ?? SuspiDetailPageGraph() {
    setup();
  }

  @override
  SuspiDetailPageGraph graph() => _graph;

  @override
  _SuspiDetailPageState createState() => _SuspiDetailPageState();
}

class _SuspiDetailPageState extends State<SuspiDetailPage>
    with AfterLayoutMixin<SuspiDetailPage> {
  bool isError = false;

  Map<String, List<SuspiDetailData>> data;
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
      Map<String, List<SuspiDetailData>> data = {
        "Dana Pihak Tiga": [],
        "Pinjaman": [],
        "Surat Utang": [],
        "Cadangan Teknis Asuransi": [],
        "Utang Usaha": [],
        "Liabilitas Lain": [],
      };
      final fetchedData = await widget.financeController
          .fetchSuspiById(id: widget.bumnId, tahun: "2019");
      final fetchedData2018 = await widget.financeController
          .fetchSuspiById(id: widget.bumnId, tahun: "2018");
      final fetchedData2017 = await widget.financeController
          .fetchSuspiById(id: widget.bumnId, tahun: "2017");
      fetchedData..addAll(fetchedData2018)..addAll(fetchedData2017);
      final company = widget.store.state.companiesState.companies
          .firstWhere((company) => company.id == widget.bumnId);

      fetchedData.forEach((datum) {
        data["Dana Pihak Tiga"]
          ..add(SuspiDetailData(
              amount: datum.danaPihakTiga,
              tahun: datum.tahun,
              key: "Dana Pihak Tiga"));
        data["Pinjaman"]
          ..add(SuspiDetailData(
              amount: datum.pinjaman, tahun: datum.tahun, key: "Pinjaman"));
        data["Surat Utang"]
          ..add(SuspiDetailData(
              amount: datum.suratUtang,
              tahun: datum.tahun,
              key: "Surat Utang"));
        data["Cadangan Teknis Asuransi"]
          ..add(SuspiDetailData(
              amount: datum.cadanganTeknisAsuransi,
              tahun: datum.tahun,
              key: "Cadangan Teknis Asuransi"));
        data["Utang Usaha"]
          ..add(SuspiDetailData(
              amount: datum.utangUsaha,
              tahun: datum.tahun,
              key: "Utang Usaha"));
        data["Liabilitas Lain"]
          ..add(SuspiDetailData(
              amount: datum.liabilitasLain,
              tahun: datum.tahun,
              key: "Liabilitas Lain"));
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
            height: MediaQuery.of(context).size.height,
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
      title: 'Detail Suspi',
      body: (ctx) => mainWidget(context),
    );
  }
}
