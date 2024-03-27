import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/models/hc/bod1_profile.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/profile_bod_1_page/di/profile_bod1_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/profile_bod_1_page/profile_bod1_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class ProfileBOD1Page extends StatefulWidget with InjectableWidget {
  final ProfileBOD1PageGraph _graph;

  final ProfilPerusahaan company;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;
  //injected
  HcController hcController;
  //injected
  ProfileBOD1ActionMapper actionMapper;

  ProfileBOD1Page({@required this.company, ProfileBOD1PageGraph graph})
      : this._graph = graph ?? ProfileBOD1PageGraph() {
    setup();
  }

  @override
  ProfileBOD1PageGraph graph() => _graph;

  @override
  _ProfileBOD1PageState createState() => _ProfileBOD1PageState();
}

class _ProfileBOD1PageState extends State<ProfileBOD1Page>
    with AfterLayoutMixin<ProfileBOD1Page> {
  List<BOD1Profile> data;
  bool isError = false;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return data != null;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      final data = await widget.hcController
          .fetchBOD1ProfileByCompany(companyId: widget.company.id);

      setState(() {
        this.data = data;
      });
    } catch (ex) {
      print(ex.toString());
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget summaryTable() {
    Map<String, int> map = {"Jumlah BOD-1": data.length};
    return CustomTable(
      colorPalette: widget.colorPalette,
      showTriliun: false,
      data: map,
      headers: [
        TableText(text: "Nama", flexColumnWidth: 100),
        TableText(text: "Jumlah", flexColumnWidth: 70),
      ],
      rowDescriptor: (key, value) {
        return TableRow(children: [
          cell(text: key),
          cell(text: "$value Orang"),
        ]);
      },
    );
  }

  Widget mainTable() {
    return CustomTable(
      colorPalette: widget.colorPalette,
      showTriliun: false,
      data: data.asMap().map((k, v) => MapEntry(v.nik, v)),
      headers: [
        TableText(text: "Nama", flexColumnWidth: 100),
        TableText(text: "Jabatan", flexColumnWidth: 70),
        TableText(text: "Link", flexColumnWidth: 50),
      ],
      rowDescriptor: (key, BOD1Profile value) {
        return TableRow(children: [
          cell(text: value.nama),
          cell(text: value.jabatan),
          cell(
              text: "Detail",
              onTap: () => widget.actionMapper
                  .toCvPage(profile: value, company: widget.company))
        ]);
      },
    );
  }

  Widget companyName() {
    return Center(
      child: Text(
        widget.company.nama,
        style: TextStyle(
            color: widget.colorPalette.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget titleWidget() {
    return Center(
      child: Text(
        "Profil BOD-1",
        style: TextStyle(
            color: widget.colorPalette.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w700),
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
        : ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              titleWidget(),
              companyName(),
              summaryTable(),
              mainTable(),
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
      title: "BOD1",
      body: (ctx) => mainWidget(context),
    );
  }
}
