import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/pages/hc/employee/profile_employee_page/di/profile_employee_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/employee/profile_employee_page/pages/age_page/age_page.dart';
import 'package:bumn_eid/ui/pages/hc/employee/profile_employee_page/pages/demography_page/demography_page.dart';
import 'package:bumn_eid/ui/pages/hc/employee/profile_employee_page/pages/education_page/education_page.dart';
import 'package:bumn_eid/ui/pages/hc/employee/profile_employee_page/pages/gender_page/gender_page.dart';
import 'package:bumn_eid/ui/pages/hc/employee/profile_employee_page/profile_employee_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class ProfileEmployeePage extends StatefulWidget with InjectableWidget {
  final ProfileEmployeePageGraph _graph;

  final ProfilPerusahaan company;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;
  //injected
  HcController hcController;
  //injected
  ProfileEmployeeActionMapper actionMapper;

  ProfileEmployeePage({@required this.company, ProfileEmployeePageGraph graph})
      : this._graph = graph ?? ProfileEmployeePageGraph() {
    setup();
  }

  @override
  ProfileEmployeePageGraph graph() => _graph;

  @override
  _ProfileEmployeePageState createState() => _ProfileEmployeePageState();
}

class _ProfileEmployeePageState extends State<ProfileEmployeePage> {
  var currentProfile = "Status Karyawan";
  final profileList = [
    "Status Karyawan",
    "Education",
    "Gender",
    "Age",
  ];

  Widget companyName() {
    return Center(
      child: Text(
        widget.company.nama,
        style: TextStyle(color: widget.colorPalette.black, fontSize: 18.0),
      ),
    );
  }

  Widget titleWidget() {
    return Center(
      child: Text(
        "Profil Karyawan",
        style: TextStyle(color: widget.colorPalette.black, fontSize: 18.0),
      ),
    );
  }

  Widget filterWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
      child: FilterWidget(
        title: "Jenis Karyawan",
        currentItem: currentProfile,
        items: profileList,
        onChanged: (newItem) {
          setState(() {
            this.currentProfile = newItem;
          });
        },
      ),
    );
  }

  String url() {
    switch (currentProfile) {
      case "Status Karyawan":
        return '/hc/grafik/karyawan/demografi/by/bumn/#companyId';
      case "Education":
        return '/hc/grafik/karyawan/education/by/bumn/#companyId';
      case "Gender":
        return '/hc/grafik/karyawan/gender/by/bumn/#companyId';
      case "Age":
        return '/hc/grafik/karyawan/age/by/bumn/#companyId';
      default:
        return '/hc/grafik/karyawan/demografi/by/bumn/#companyId';
    }
  }

  Widget contentWidget() {
    switch (currentProfile) {
      case "Status Karyawan":
        return DemographyPage(
          colorPalette: widget.colorPalette,
          companyId: widget.company.id,
          hcController: widget.hcController,
        );
      case "Education":
        return EducationPage(
          colorPalette: widget.colorPalette,
          companyId: widget.company.id,
          hcController: widget.hcController,
        );
      case "Gender":
        return GenderPage(
          colorPalette: widget.colorPalette,
          companyId: widget.company.id,
          hcController: widget.hcController,
        );
      case "Age":
        return AgePage(
          colorPalette: widget.colorPalette,
          companyId: widget.company.id,
          hcController: widget.hcController,
        );
      default:
        return DemographyPage(
          colorPalette: widget.colorPalette,
          companyId: widget.company.id,
          hcController: widget.hcController,
        );
    }
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        titleWidget(),
        companyName(),
        filterWidget(),
        contentWidget(),
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
      title: "Employee",
      body: (ctx) => mainWidget(context),
    );
  }
}
