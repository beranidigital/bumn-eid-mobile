import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/general_company.dart';
import 'package:bumn_eid/core/models/common/anak_perusahaan_deni.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_anak_company_page/bod_anak_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_anak_company_page/di/bod_anak_company_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// ignore: must_be_immutable
class BODAnakCompanyPage extends StatefulWidget with InjectableWidget {
  final BODAnakCompanyPageGraph _graph;

  final GeneralCompany company;

  //injected
  ColorPalette colorPalette;
  //injected
  BODAnakCompanyActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  BODAnakCompanyPageGraph graph() => _graph;

  BODAnakCompanyPage({@required this.company, BODAnakCompanyPageGraph graph})
      : this._graph = graph ?? BODAnakCompanyPageGraph() {
    setup();
  }

  @override
  _BODAnakCompanyPageState createState() => _BODAnakCompanyPageState();
}

class _BODAnakCompanyPageState extends State<BODAnakCompanyPage>
    with AfterLayoutMixin<BODAnakCompanyPage> {
  List<AnakPerusahaanDeni> data;
  bool isError = false;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getData() async {
    try {
      setState(() {
        isError = false;
      });
      final data = await widget.hcController
          .fetchAnakPerusahaanByCompany(companyId: widget.company.getId());

      setState(() {
        this.data = data;
      });
    } catch (ex) {
      setState(() {
        isError = true;
      });
    }
  }

  Widget tableWidget() {
    return data.isEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 96.0),
            child: Center(
              child: Text(
                "Tidak Ada Anak Perusahaan",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
          )
        : CustomTable(
            colorPalette: widget.colorPalette,
            data: data.asMap().map((k, v) => MapEntry(v.anak, v)),
            headers: [
              TableText(text: "Nama Anak Perusahaan"),
              TableText(text: "Jumlah Pejabat", type: TableTextType.NUMBER),
              TableText(text: "Link"),
            ],
            showTriliun: false,
            rowDescriptor: (key, AnakPerusahaanDeni value) {
              return TableRow(children: [
                cell(text: value.anak),
                cell(
                    text: value.jumlahPejabat.toString(),
                    textAlign: TextAlign.end),
                cell(
                    text: "Detail",
                    onTap: () => widget.actionMapper
                        .openBODByAnakCompanyPage(company: value))
              ]);
            },
          );
  }

  Widget titleWidget(BuildContext context) {
    return Text(
      "${widget.company.getShortName()}",
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
    );
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        titleWidget(context),
        tableWidget(),
        LastUpdateWidget(
          store: StoreProvider.of<AppState>(context),
          pageName: "hc",
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Anak Perusahaan",
      body: (ctx) => SafeArea(
        child: data == null
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
