import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/grafik_jenis_perusahaan.dart';
import 'package:bumn_eid/core/models/common/user.dart';
import 'package:bumn_eid/core/models/finance/grafik_posisi_keuangan.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/strings/strings.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/irwan_dev/services/storage_preferences.dart';
import 'package:bumn_eid/irwan_dev/services/version_control.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/default_loading_widget.dart';
import 'package:bumn_eid/ui/components/main_menu.dart';
import 'package:bumn_eid/ui/components/triangle_painter.dart';
import 'package:bumn_eid/ui/pages/home/home_page/di/home_page_graph.dart';
import 'package:bumn_eid/ui/pages/home/home_page/home_page_action_mapper.dart';
import 'package:bumn_eid/ui/pages/home/home_page/summary_item_top.dart';
import 'package:bumn_eid/ui/pages/internal/internal_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/business_portfolio_page/bumn_by_ownership_widget.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/dashboard/dashboard.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget with InjectableWidget {
  final HomePageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  HomePageActionMapper actionMapper;
  //injected
  CompaniesController companiesController;
  FinanceController financeController;
  JenisController jenisController;

  HomePage([graph]) : this._graph = graph ?? HomePageGraph() {
    setup();
  }

  @override
  HomePageGraph graph() => _graph;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin<HomePage> {
  ScrollController scrollController;
  Map<String, List<GrafikPosisiKeuangan>> posisiKeuanganData;

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

  Map<String, List<GrafikJenisPerusahaan>> tableData;

  Future fetchVersionControl() async {
    final nilai = await VersionControl().getVersionControl();
    if (nilai.version_code != "11") {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Tersedia Versi Terbaru (Version ${nilai.version})",
              // "${StoragePreferences.getTimeLogin().toString()}",
              textAlign: TextAlign.center,
            ),
            titleTextStyle: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            content: Container(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: Colors.red),
                        ),
                        child: Text(
                          "Abaikan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (Platform.isAndroid) {
                          launchUrl(
                              "https://play.google.com/store/apps/details?id=com.kembumn.bumneid");
                        } else {
                          launchUrl(
                              "https://apps.apple.com/us/app/bumn-eid-apps/id1551587181");
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green,
                        ),
                        child: Text(
                          "Update",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchVersionControl();
    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchPosisiKeuangan();
      getData();
    });
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  void getData() async {
    try {
      final data = await widget.jenisController.fetchGrafikJenis();
      Map<String, List<GrafikJenisPerusahaan>> chartData = {};
      data.forEach((grafikData) {
        if (chartData.containsKey(grafikData.jenis_bumn)) {
          chartData[grafikData.jenis_bumn].add(grafikData);
        } else {
          chartData[grafikData.jenis_bumn] = [grafikData];
        }
      });

      chartData.values.forEach((list) {
        list.sort((GrafikJenisPerusahaan a, GrafikJenisPerusahaan b) =>
            int.parse(a.tahun).compareTo(int.parse(b.tahun)));
      });

      setState(() {
        this.tableData = chartData;
      });
    } catch (ex) {
      print(ex);
    }
  }

  String currentOwnership = 'Persero';

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      widget.companiesController.fetchCompanies();
    });
  }

  Widget circleUser(BuildContext context) {
    return Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: widget.colorPalette.white),
      child: Icon(Icons.person),
    );
  }

  Widget userWidget(BuildContext context) {
    return StoreConnector<AppState, User>(
      converter: (store) => store.state.authState.currentUser,
      builder: (context, user) {
        return user == null
            ? Container()
            : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // SizedBox(
                    //   height: 4.0,
                    // ),
                    // Text(
                    //   // TODO: CHANGE
                    //   'Wakil Menteri BUMN',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w300,
                    //     fontSize: 12.0,
                    //     color: Colors.white,
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                  ],
                ),
              );
      },
    );
  }

  Widget mainWidget(BuildContext context) {
    final pixels =
        scrollController.hasClients ? scrollController.position.pixels : 0;

    if (posisiKeuanganData == null || tableData == null) {
      return Center(
        child: DefaultLoadingWidget(
          colorPalette: ColorPalette(),
        ),
      );
    }

    final companies =
        StoreProvider.of<AppState>(context).state.companiesState.companies ??
            [];

    final clusters = [];
    companies.forEach((element) {
      if (!clusters.contains(element.cluster)) {
        clusters.add(element.cluster);
      }
    });

    return Stack(
      children: [
        Positioned(
          top: 0.0 - (pixels),
          child: Image.asset(
            'res/images/home_top.png',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
        ),
        ListView(
          controller: scrollController,
          padding: EdgeInsets.only(
            top: 36.0,
          ),
          children: [
            Container(
              height: 75.0,
              child: Image.asset(
                'res/images/home_top_bumn.png',
              ),
            ),
            userWidget(context),
            SizedBox(
              height: 24.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1FA4CB),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                      bottomLeft: Radius.circular(4.0),
                      bottomRight: Radius.circular(4.0),
                    ),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: menuList(context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: CustomPaint(
                    painter: TrianglePainter(
                      strokeColor: Color(0xFF1FA4CB),
                      strokeWidth: 10,
                      paintingStyle: PaintingStyle.fill,
                      upsideDown: true,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Card(
                    elevation: 8.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Summary',
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Container(
                            height: 70.0,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                SummaryItemTop(
                                  title: 'BUMN',
                                  total: companies.length.toString(),
                                ),
                                SummaryItemTop(
                                  title: 'CLUSTER',
                                  total: clusters.length.toString(),
                                ),
                                SummaryItemTop(
                                  title: 'KELAS',
                                  total: '5',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          BumnByOwnershipWidget(
                            jenisController: widget.jenisController,
                          ),
                          // Container(
                          //   width: double.infinity,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(8.0),
                          //     border: Border.all(
                          //       color: Color(0xFF1FA4CA),
                          //       width: 1.0,
                          //     ),
                          //   ),
                          //   padding: EdgeInsets.only(
                          //     top: 16.0,
                          //     bottom: 16.0,
                          //   ),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Text(
                          //         'Posisi Keuangan',
                          //         style: TextStyle(
                          //           fontFamily: 'opensans',
                          //           fontWeight: FontWeight.w700,
                          //           fontSize: 12.0,
                          //         ),
                          //       ),
                          //       InkWell(
                          //         onTap: () =>
                          //             widget.actionMapper.openPosisiKeuangan(),
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(8.0),
                          //             color: Colors.white,
                          //           ),
                          //           padding: EdgeInsets.all(8.0),
                          //           child: Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.start,
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.center,
                          //             children: [
                          //               Image.asset(
                          //                 'res/images/finance_icon.png',
                          //                 width: 50.0,
                          //                 height: 40.0,
                          //               ),
                          //               SizedBox(
                          //                 width: 8.0,
                          //               ),
                          //               Expanded(
                          //                 child: Column(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.start,
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     Text(
                          //                       'Posisi Keuangan',
                          //                       style: TextStyle(
                          //                         fontFamily: 'poppins',
                          //                         fontWeight: FontWeight.w700,
                          //                         fontSize: 14.0,
                          //                       ),
                          //                     ),
                          //                     Row(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment.start,
                          //                       crossAxisAlignment:
                          //                           CrossAxisAlignment.center,
                          //                       children: posisiKeuanganData
                          //                           .keys
                          //                           .map((element) {
                          //                         final data =
                          //                             posisiKeuanganData[
                          //                                     element]
                          //                                 .firstWhere((a) =>
                          //                                     a.tahun ==
                          //                                     '2019');
                          //                         return Expanded(
                          //                           child: Column(
                          //                             mainAxisAlignment:
                          //                                 MainAxisAlignment
                          //                                     .start,
                          //                             crossAxisAlignment:
                          //                                 CrossAxisAlignment
                          //                                     .center,
                          //                             children: [
                          //                               SizedBox(
                          //                                 height: 8.0,
                          //                               ),
                          //                               Text(
                          //                                 element,
                          //                                 style: TextStyle(
                          //                                   fontFamily:
                          //                                       'poppins',
                          //                                   fontWeight:
                          //                                       FontWeight.w500,
                          //                                   fontSize: 12.0,
                          //                                   color: Color(
                          //                                       0xFF222933),
                          //                                 ),
                          //                               ),
                          //                               SizedBox(
                          //                                 height: 4.0,
                          //                               ),
                          //                               Text(
                          //                                 parseDouble(
                          //                                         data.jumlah)
                          //                                     .toStringAsFixed(
                          //                                         2),
                          //                                 style: TextStyle(
                          //                                   fontFamily:
                          //                                       'poppins',
                          //                                   fontWeight:
                          //                                       FontWeight.w500,
                          //                                   fontSize: 12.0,
                          //                                   color: Color(
                          //                                       0xFFD8B005),
                          //                                 ),
                          //                                 textAlign:
                          //                                     TextAlign.center,
                          //                               ),
                          //                               SizedBox(
                          //                                 height: 8.0,
                          //                               ),
                          //                             ],
                          //                           ),
                          //                         );
                          //                       }).toList(),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //               Icon(
                          //                 Icons.arrow_right_alt,
                          //                 color: Color(0xFF1B478D),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 54.0,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget menuList(BuildContext context) {
    return StoreConnector<AppState, User>(
      converter: (store) => store.state.authState.currentUser,
      builder: (context, user) {
        if (user == null) return CircularProgressIndicator();
        List<String> role = user.role;
        List<Widget> menus = [];
        if (role.contains("portofolio"))
          menus.add(
            MainMenu(
              colorPalette: widget.colorPalette,
              title: Strings.getString("HomePage.BusinessPortfolio"),
              imagePath: "res/images/business_portfolio.png",
              onTap: () {
                ApiStatistic().insertStatistic(
                    "Business Portofolio", "Main Page Business Portofolio");
                widget.actionMapper.goToBusinessPortfolio();
              },
            ),
          );
        if (role.contains("finance"))
          menus.add(
            MainMenu(
              colorPalette: widget.colorPalette,
              title: Strings.getString("HomePage.Finance"),
              imagePath: "res/images/finance.png",
              onTap: () {
                ApiStatistic().insertStatistic("Finance", "Main Page Finance");
                widget.actionMapper.goToFinance();
              },
            ),
          );
        if (role.contains("hc"))
          menus.add(
            MainMenu(
              colorPalette: widget.colorPalette,
              title: Strings.getString("HomePage.HumanCapital"),
              imagePath: "res/images/hc.png",
              onTap: () {
                // ApiStatistic().insertStatistic("Main Page Human Capital");
                ApiStatistic().insertStatistic(
                    "Human Capital", "Main Page Human Capital");
                widget.actionMapper.goToHumanCapital();
              },
              // onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => Dashboard(),
              //     )),
            ),
          );
        if (role.contains("legal"))
          menus.add(
            MainMenu(
              colorPalette: widget.colorPalette,
              title: Strings.getString("HomePage.Legal"),
              imagePath: "res/images/legal.png",
              onTap: () {
                ApiStatistic().insertStatistic("Legal", "Main Page Legal");
                widget.actionMapper.goToLegal();
              },
            ),
          );
        if (role.contains("csr"))
          menus.add(
            MainMenu(
              colorPalette: widget.colorPalette,
              title: Strings.getString("HomePage.CSR"),
              imagePath: "res/images/csr.png",
              onTap: () {
                ApiStatistic().insertStatistic("CSR", "Main Page CSR");
                widget.actionMapper.goToCSR();
              },
            ),
          );
        if (role.contains("event"))
          menus.add(
            MainMenu(
              colorPalette: widget.colorPalette,
              title: Strings.getString("HomePage.Event"),
              imagePath: "res/images/event.png",
              onTap: () {
                ApiStatistic().insertStatistic("Event", "Main Page Event");
                widget.actionMapper.goToEvent();
              },
            ),
          );
        if (role.contains("pmo"))
          menus.add(
            MainMenu(
              colorPalette: widget.colorPalette,
              title: Strings.getString("HomePage.PMO"),
              imagePath: "res/images/pmo.png",
              onTap: () {
                ApiStatistic().insertStatistic("PMO", "Main Page PMO");
                widget.actionMapper.goToPMO();
              },
            ),
          );
        menus.add(
          MainMenu(
            colorPalette: widget.colorPalette,
            title: 'Internal KBUMN',
            imagePath: "res/images/internal.png",
            onTap: () {
              ApiStatistic().insertStatistic(
                  "Internal KBUMN", "Main Page Internal KBUMN");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => InternalPage(),
                ),
              );
            },
          ),
        );
        menus.add(
          MainMenu(
            colorPalette: widget.colorPalette,
            title: 'Cosmic',
            imagePath: "res/images/cosmic.png",
            onTap: () {
              ApiStatistic().insertStatistic("Cosmic", "Main Page Cosmic");
              widget.actionMapper.goToCovid();
            },
          ),
        );
        return role == null || role.isEmpty
            ? Center(
                child: Text(
                  "Menu Tidak Tersedia untuk Akun Ini.",
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: GridView.count(
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 24,
                  crossAxisCount: 3,
                  children: menus,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1,
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: (ctx) => mainWidget(ctx),
      isHome: true,
    );
  }

  // Get.defaultDialog(
  //       radius: 1,
  //       barrierDismissible: false,
  //       title: "Terdapat Versi Terbaru Aplikasi",
  //       titleStyle: TextStyle(fontSize: 17),
  //       content: Container(
  //         padding: EdgeInsets.only(left: 10, right: 10),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             GestureDetector(
  //               onTap: () {
  //                 UrlNavigation().customeLaunch(
  //                     "https://play.google.com/store/apps/details?id=com.carryfy.carryfy_driver");
  //               },
  //               child: Container(
  //                 margin: EdgeInsets.symmetric(horizontal: 10),
  //                 padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
  //                 decoration: BoxDecoration(
  //                   color: color_snackbar,
  //                   borderRadius: BorderRadius.circular(5),
  //                 ),
  //                 child: Text(
  //                   "Update",
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
}
