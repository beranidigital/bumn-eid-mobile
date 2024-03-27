import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/models/common/kinerja_perusahaan.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/bigger_custom_table.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/common/kontribusi_negara_page/di/kontribusi_negara_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class KontribusiNegaraPage extends StatefulWidget with InjectableWidget {
  final KontribusiNegaraPageGraph _graph;

  final String id;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;
  //injected
  FinanceController financeController;

  KontribusiNegaraPage({@required this.id, KontribusiNegaraPageGraph graph})
      : this._graph = graph ?? KontribusiNegaraPageGraph() {
    setup();
  }

  @override
  KontribusiNegaraPageGraph graph() => _graph;

  @override
  _KontribusiNegaraPageState createState() => _KontribusiNegaraPageState();
}

class _KontribusiNegaraPageState extends State<KontribusiNegaraPage>
    with AfterLayoutMixin<KontribusiNegaraPage> {
  bool isError = false;

  Map<String, List<KinerjaPerusahaan>> dataKinerjaPerusahaan;
  ProfilPerusahaan company;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return dataKinerjaPerusahaan != null && company != null;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      Map<String, List<KinerjaPerusahaan>> data = {};
      final fetchedData =
          await widget.financeController.fetchKinerjaPerusahaan(id: widget.id);
      final company = widget.store.state.companiesState.companies
          .firstWhere((company) => company.id == widget.id);

      fetchedData.forEach((datum) {
        if (!Constants.akunKontribusiNegara.contains(datum.jenisAkun)) return;
        if (data.containsKey(datum.jenisAkun)) {
          data[datum.jenisAkun].add(datum);
        } else {
          data[datum.jenisAkun] = [datum];
        }
      });

      data.keys.forEach((key) {
        data[key]..sort((a, b) => a.tahun.compareTo(b.tahun));

        if (data[key].length > 3) {
          data[key].removeAt(0);
        }
      });

      setState(() {
        this.dataKinerjaPerusahaan = data;
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
        color: widget.colorPalette.success,
        title: "Kontribusi Pada Negara",
        data: dataKinerjaPerusahaan,
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
                detailsList(context)
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Kontribusi Pada Negara',
      body: (ctx) => mainWidget(ctx),
    );
  }
}
