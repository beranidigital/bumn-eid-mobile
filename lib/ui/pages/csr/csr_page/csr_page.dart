import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/pages/csr/csr_page/csr_bl.dart';
import 'package:bumn_eid/ui/pages/csr/csr_page/csr_page_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/csr_page/csr_pk.dart';
import 'package:bumn_eid/ui/pages/csr/csr_page/csr_summary.dart';
import 'package:bumn_eid/ui/pages/csr/csr_page/di/csr_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/padi/views/ui/padi_home.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class CsrPage extends StatefulWidget with InjectableWidget {
  final CsrPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  CsrPageActionMapper actionMapper;
  //injected
  Store<AppState> store;
  //injected
  CsrController csrController;

  @override
  CsrPageGraph graph() => _graph;

  CsrPage([graph]) : this._graph = graph ?? CsrPageGraph() {
    setup();
  }

  @override
  _CsrPageState createState() => _CsrPageState();
}

class _CsrPageState extends State<CsrPage> {
  Widget menuList(BuildContext context) {
    return Container(
      color: Color(0xFFF0F4FA),
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16.0,
      ),
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 8.0,
          ),
          CsrSummary(
            csrController: widget.csrController,
          ),
          SizedBox(
            height: 16.0,
          ),
          CsrPK(
            csrController: widget.csrController,
          ),
          SizedBox(
            height: 16.0,
          ),
          CsrBL(
            csrController: widget.csrController,
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset("res/images/vector_csr.png"),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Pasar Digital UMKM Indonesia",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    GestureDetector(
                      onTap: () async{
                        //TODO : Mau diubah ke under maintenance
                        ApiStatistic().insertStatistic("CSR", "Main Page PADI");
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(""),
                              titleTextStyle: TextStyle(fontSize: 0.1),
                              content: Container(
                                child: Column(
                                  children: [
                                    Image.asset(""),
                                    Text("Under Maintenance!!"),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => PadiHome()));
                      },
                      child: Text(
                        "Selengkapnya>>",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: color_blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: color_blue, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Total UMKM",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              "29012",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: color_blue, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Total UMKM",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              "29012",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Center(
            child: LastUpdateWidget(
              pageName: "csr",
              store: widget.store,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'CSR',
      body: (ctx) => menuList(ctx),
    );
  }
}
