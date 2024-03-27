import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/main_menu.dart';
import 'package:bumn_eid/ui/pages/hc/employee/company_employee_page/company_employee_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/employee/company_employee_page/di/company_employee_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class CompanyEmployeePage extends StatefulWidget with InjectableWidget {
  final CompanyEmployeePageGraph _graph;

  final String id;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;
  //injected
  CompaniesController companiesController;
  //injected
  CompanyEmployeeActionMapper actionMapper;

  CompanyEmployeePage({@required this.id, CompanyEmployeePageGraph graph})
      : this._graph = graph ?? CompanyEmployeePageGraph() {
    setup();
  }

  @override
  CompanyEmployeePageGraph graph() => _graph;

  @override
  _CompanyEmployeePageState createState() => _CompanyEmployeePageState();
}

class _CompanyEmployeePageState extends State<CompanyEmployeePage>
    with AfterLayoutMixin<CompanyEmployeePage> {
  bool isError = false;

  ProfilPerusahaan company;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return company != null;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      final fetchedCompany =
          await widget.companiesController.fetchCompany(id: widget.id);

      setState(() {
        this.company = fetchedCompany;
      });
    } catch (ex) {
      print(ex.toString());
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget menuList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MainMenu(
                      colorPalette: widget.colorPalette,
                      title: "Profil Karyawan",
                      imagePath: "res/images/profil_karyawan.png",
                      onTap: () =>
                          widget.actionMapper.openProfilKaryawan(company)),
                ),
                Expanded(
                  child: MainMenu(
                      colorPalette: widget.colorPalette,
                      title: "Anggaran Learning and Development",
                      imagePath: "res/images/anggaran_learning.png",
                      onTap: () =>
                          widget.actionMapper.openAnggaranLearning(company)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MainMenu(
                      colorPalette: widget.colorPalette,
                      title: "Anggaran Inovasi dan Teknologi",
                      imagePath: "res/images/anggaran_inovasi.png",
                      onTap: () =>
                          widget.actionMapper.openAnggaranInovasi(company)),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          )
        ],
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    if (!isDataReady()) {
      return isError
          ? CustomErrorWidget(
              onRetry: () => getData(),
            )
          : LoadingWidget(
              colorPalette: widget.colorPalette,
            );
    } else {
      return Container(
        color: Color(0xFFEEEFF3),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Center(
                child: Text(
                  company.nama,
                  style: TextStyle(
                      color: widget.colorPalette.black, fontSize: 18.0),
                ),
              ),
            ),
            Expanded(child: menuList(context)),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: LastUpdateWidget(
                store: StoreProvider.of<AppState>(context),
                pageName: "hc",
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Employee",
      body: (ctx) => mainWidget(context),
    );
  }
}
