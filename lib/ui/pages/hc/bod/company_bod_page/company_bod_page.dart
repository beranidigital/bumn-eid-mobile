import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod/company_bod_page/company_bod_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/company_bod_page/di/company_bod_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class CompanyBODPage extends StatefulWidget with InjectableWidget {
  final CompanyBODPageGraph _graph;

  final String id;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;
  //injected
  CompaniesController companiesController;
  //injected
  CompanyBODActionMapper actionMapper;

  CompanyBODPage({@required this.id, CompanyBODPageGraph graph})
      : this._graph = graph ?? CompanyBODPageGraph() {
    setup();
  }

  @override
  CompanyBODPageGraph graph() => _graph;

  @override
  _CompanyBODPageState createState() => _CompanyBODPageState();
}

class _CompanyBODPageState extends State<CompanyBODPage>
    with AfterLayoutMixin<CompanyBODPage> {
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

  Widget menuItem(
      {@required BuildContext context,
      @required String text,
      @required String imagePath,
      @required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Card(
                  color: Color(0xFFE7F0FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  elevation: 12.0,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Image(
                      image: AssetImage(imagePath),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                      color: widget.colorPalette.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget menuList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: menuItem(
                context: context,
                text: "Induk",
                imagePath: "res/images/dekom.png",
                onTap: () => widget.actionMapper.openPusat(company)),
          ),
          Expanded(
            child: menuItem(
                context: context,
                text: "Anak Perusahaan",
                imagePath: "res/images/talent_mobility.png",
                onTap: () => widget.actionMapper.openAnak(company)),
          ),
          Expanded(
            child: menuItem(
                context: context,
                text: "Cucu Perusahaan",
                imagePath: "res/images/dekom.png",
                onTap: () => widget.actionMapper.openCucu(company)),
          ),
        ],
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
        : Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Center(
                  child: Text(
                    company.nama,
                    style: TextStyle(
                        color: widget.colorPalette.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Expanded(child: menuList(context)),
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
      title: 'BOD',
      body: (ctx) => mainWidget(ctx),
    );
  }
}
