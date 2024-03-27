import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/general_company.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/strings/strings.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_card.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/business_portfolio_page/bumn_by_class_widget.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/business_portfolio_page/bumn_by_cluster_widget.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/business_portfolio_page/bumn_by_ownership_widget.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/business_portfolio_page/business_portfolio_action_mapper.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/business_portfolio_page/di/business_portfolio_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class BusinessPortfolioPage extends StatefulWidget with InjectableWidget {
  final BusinessPortfolioPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  BusinessPortfolioActionMapper actionMapper;
  //injected
  Store<AppState> store;
  //injected
  JenisController jenisController;

  @override
  BusinessPortfolioPageGraph graph() => _graph;

  BusinessPortfolioPage([graph])
      : this._graph = graph ?? BusinessPortfolioPageGraph() {
    setup();
  }

  @override
  _BusinessPortfolioPageState createState() => _BusinessPortfolioPageState();
}

class _BusinessPortfolioPageState extends State<BusinessPortfolioPage>
    with AfterLayoutMixin<BusinessPortfolioPage> {
  bool isError = false;
  int totalCompany;
  List<GeneralCompany> companies;
  Map<String, int> companiesByCluster;
  Map<String, int> companiesBySector;
  Map<int, int> companiesByClass;

  bool isDataReady() {
    return totalCompany != null &&
        companiesByClass != null &&
        companiesByCluster != null &&
        companiesBySector != null;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  getData() {
    try {
      final companies = widget.store.state.companiesState.companies;
      final Map<String, int> cluster = {};
      final Map<String, int> sector = {};
      final Map<int, int> kelas = {};

      companies.forEach((company) {
        if (cluster.containsKey(company.cluster)) {
          cluster[company.cluster]++;
        } else {
          cluster[company.cluster] = 1;
        }
        if (sector.containsKey(company.sektorBps)) {
          sector[company.sektorBps]++;
        } else {
          sector[company.sektorBps] = 1;
        }
        if (kelas.containsKey(company.kelasBumn)) {
          kelas[company.kelasBumn]++;
        } else {
          kelas[company.kelasBumn] = 1;
        }
      });

      setState(() {
        this.companies = companies;
        this.companiesByCluster = cluster;
        this.companiesBySector = sector;
        this.companiesByClass = kelas;
        this.totalCompany = companies.length;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget topMenuItem(
    BuildContext context,
    String image,
    String title,
    String count,
  ) {
    return Container(
      constraints: BoxConstraints(
        // minHeight: MediaQuery.of(context).size.height * 0.1125,
        minHeight: 90,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Color(0xFF1FA4CA),
          width: 2.0,
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(
        right: 8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 22.0,
              ),
              SizedBox(
                width: 4.0,
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 11.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Text(
            count,
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget menuList(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color(0xFFEEEFF3),
      child: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 8.0,
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    ApiStatistic().insertStatistic("Business Portofolio",
                        "List Total BUMN Business Portofolio");
                    widget.actionMapper.openTotalBumn();
                  },
                  child: topMenuItem(
                    context,
                    'res/images/ic_total_bumn.png',
                    'Total BUMN',
                    totalCompany.toString(),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    ApiStatistic().insertStatistic("Business Portofolio",
                        "List Wamen 1 Business Portofolio");
                    widget.actionMapper.openWamenI();
                  },
                  child: topMenuItem(
                    context,
                    'res/images/ic_wamen.png',
                    'Wamen 1',
                    companies
                        .where((a) => a.getWamen() == 'WAMEN I')
                        .length
                        .toString(),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    ApiStatistic().insertStatistic("Business Portofolio",
                        "List Wamen 2 Business Portofolio");
                    widget.actionMapper.openWamenII();
                  },
                  child: topMenuItem(
                    context,
                    'res/images/ic_wamen.png',
                    'Wamen II',
                    companies
                        .where((a) => a.getWamen() == 'WAMEN II')
                        .length
                        .toString(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    ApiStatistic().insertStatistic("Business Portofolio",
                        "List Ownership Business Portofolio");
                    widget.actionMapper.openJenisBumn();
                  },
                  child: topMenuItem(
                    context,
                    'res/images/ic_ownership.png',
                    'Ownership',
                    Constants.dummyJenisData.keys.length.toString(),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    ApiStatistic().insertStatistic("Business Portofolio",
                        "List Cluster Business Portofolio");
                    widget.actionMapper.openClusterBumn();
                  },
                  child: topMenuItem(
                    context,
                    'res/images/ic_cluster.png',
                    'Cluster',
                    companiesByCluster.keys.length.toString(),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    ApiStatistic().insertStatistic("Business Portofolio",
                        "List Kelas Kelas Business Portofolio");
                    widget.actionMapper.openClassBumn();
                  },
                  child: topMenuItem(
                    context,
                    'res/images/ic_kelas.png',
                    'Kelas',
                    companiesByClass.keys.length.toString(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          BaseCard(
            title: 'Summary',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BumnByOwnershipWidget(
                  jenisController: widget.jenisController,
                ),
                SizedBox(
                  height: 16.0,
                ),
                BumnByClusterWidget(
                  jenisController: widget.jenisController,
                  store: StoreProvider.of<AppState>(context),
                ),
                SizedBox(
                  height: 16.0,
                ),
                BumnByClassWidget(
                  jenisController: widget.jenisController,
                  store: StoreProvider.of<AppState>(context),
                ),
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     Expanded(
          //       child: BasicMenu(
          //         title: "Total BUMN",
          //         subtitle: "Perusahaan",
          //         onTap: () => widget.actionMapper.openTotalBumn(),
          //         bgColor: Color(0xFF7F92FB),
          //         bottomColor: Color(0xFF6778DB),
          //         total: totalCompany,
          //       ),
          //     ),
          //     Expanded(
          //       child: BasicMenu(
          //           title: "By Cluster",
          //           onTap: () => widget.actionMapper.openClusterBumn(),
          //           bgColor: Color(0xFFF6E2A7),
          //           bottomColor: Color(0xFFEECB75),
          //           textColor: widget.colorPalette.darkGrey,
          //           subtitle: "Cluster",
          //           total: companiesByCluster.keys.length),
          //     ),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     Expanded(
          //       child: SmallPieChartMenu(
          //         colorPalette: widget.colorPalette,
          //         title: "By Sektor",
          //         onTap: () => widget.actionMapper.openSectorBumn(),
          //         chartData: companiesBySector,
          //       ),
          //     ),
          //     Expanded(
          //       child: SmallBarChartListMenu(
          //         colorPalette: widget.colorPalette,
          //         title: "By Ownership",
          //         onTap: () => widget.actionMapper.openJenisBumn(),
          //         keyToColor: Constants.dummyJenisKeyToColor,
          //         data: Constants.dummyJenisData,
          //       ),
          //     ),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     Expanded(
          //       child: SmallPieChartMenu(
          //           colorPalette: widget.colorPalette,
          //           title: "By Class",
          //           onTap: () => widget.actionMapper.openClassBumn(),
          //           chartData: companiesByClass
          //               .map((k, v) => MapEntry("Kelas $k", v)),
          //           maxItemToShow: 5,
          //           legendTextSize: 8),
          //     ),
          //     Expanded(
          //       child: Container(
          //         color: Colors.transparent,
          //       ),
          //     )
          //   ],
          // ),
          // LastUpdateWidget(
          //   pageName: "business_portofolio",
          //   store: widget.store,
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: Strings.getString("BusinessPortfolioPage.Title"),
      body: (ctx) => !isDataReady()
          ? isError
              ? CustomErrorWidget(
                  onRetry: () => getData(),
                )
              : LoadingWidget(
                  colorPalette: widget.colorPalette,
                )
          : menuList(context),
    );
  }
}
