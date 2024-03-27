import 'package:bumn_eid/irwan_dev/padi/api/all_api.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bumn_eid/irwan_dev/padi/views/ui/detail_four.dart';
import 'package:bumn_eid/irwan_dev/padi/views/ui/detail_one.dart';
import 'package:bumn_eid/irwan_dev/padi/views/ui/detail_three.dart';
import 'package:bumn_eid/irwan_dev/padi/views/ui/detail_two.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/charts/item_bar_chart_two.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_bar_chart_one.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_container.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_filter.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_line_chart.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_menu_one.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_menu_two.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_pie_chart_one.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_pie_chart_two.dart';
import 'package:bumn_eid/irwan_dev/padi/views/widgets/item_table_one.dart';
import 'package:bumn_eid/irwan_dev/padi/views/ui/detail_five.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';

class PadiHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "PaDI UMKM",
      body: (ctx) => mainWidget(context),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   MediaQueryData mediaQueryData = MediaQuery.of(context);
  //   return new Scaffold(
  //     appBar: new AppBar(
  //       centerTitle: true,
  //       title: new Text("PaDI UMKM"),
  //     ),
  //     body:
  //   );
  // }

  mainWidget(BuildContext context) {
    return new FutureBuilder<Map<String, dynamic>>(
      future: AllApi.getDataSummary(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var summary_all = snapshot.data['summary_all'];
          var summary_tren_transaksi = snapshot.data['summary_tren_transaksi'];
          var summary_source_of_budget =
              snapshot.data['summary_source_of_budget'];
          var summary_level_umkm = snapshot.data['summary_level_umkm'];
          var summary_top5_category_project =
              snapshot.data['summary_top5_category_project'];
          var summary_value_project = snapshot.data['summary_value_project'];
          var summary_top5_pembiayaan_umkm =
              snapshot.data['summary_top5_pembiayaan_umkm'];
          return new ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            children: [
              new SizedBox(
                height: 10.0,
              ),
              // new SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: new Row(
              //     children: [
              //       ItemFilter(
              //         title: "Filter",
              //         icon: Icons.filter_list,
              //       ),
              //       ItemFilter(
              //         title: "1 Des - 20 Des 2020",
              //         icon: Icons.calendar_today_outlined,
              //       ),
              //       ItemFilter(
              //         title: "Eproc",
              //         icon: Icons.check_circle_outline,
              //       ),
              //       ItemFilter(
              //         title: "Mikro",
              //         icon: Icons.check_circle_outline,
              //       ),
              //       ItemFilter(
              //         title: "Jasa Keuangan",
              //         icon: Icons.check_circle_outline,
              //       ),
              //     ],
              //   ),
              // ),

              new Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: [
                  ItemMenuOne(
                    title: "BUMN",
                    total: "${summary_all['total_bumn']}",
                    height: 8.5,
                    width: 3.4,
                    onTap: () {
                      ApiStatistic()
                          .insertStatistic("CSR", "Level 1 BUMN PADI");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return new DetailOne(title: "BUMN");
                          },
                        ),
                      );
                    },
                    click: true,
                  ),
                  ItemMenuOne(
                      title: "UMKM Register",
                      total: "${summary_all['umkm_register']}",
                      height: 8.5,
                      width: 3.4,
                      onTap: () {
                        ApiStatistic().insertStatistic(
                            "CSR", "Level 1 UMKM Register PADI");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return new DetailFive(title: "Sebaran Transaksi");
                            },
                          ),
                        );
                      },
                      click: true),
                  ItemMenuOne(
                      title: "UMKM Handle Project",
                      total: "${summary_all['umkm_handle_project']}",
                      height: 8.5,
                      width: 3.4,
                      onTap: () {
                        ApiStatistic().insertStatistic(
                            "CSR", "Level 1 UMKM Handle Project PADI");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return new DetailFive(title: "Sebaran Transaksi");
                            },
                          ),
                        );
                      },
                      click: true),
                  ItemMenuTwo(
                    click: true,
                    title: "Jumlah Transaksi",
                    total: "${summary_all['jumlah_transaksi']}",
                    height: 10,
                    width: 2.25,
                    onTap: () {
                      ApiStatistic().insertStatistic(
                          "CSR", "Level 1 Jumlah Transaksi PADI");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return new DetailFive(title: "Sebaran Transaksi");
                          },
                        ),
                      );
                    },
                  ),
                  ItemMenuTwo(
                    click: true,
                    title: "Nominal Transaksi",
                    total: "${summary_all['total_nominal_transaksi']}",
                    height: 10,
                    width: 2.25,
                    onTap: () {
                      ApiStatistic().insertStatistic(
                          "CSR", "Level 1 Nominal Transaksi PADI");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return new DetailFive(title: "Sebaran Transaksi");
                          },
                        ),
                      );
                    },
                  ),
                  ItemMenuOne(
                    title: "Pengampu",
                    total: "${summary_all['total_pengampu']}",
                    height: 8.5,
                    width: 3.45,
                    onTap: () {
                      ApiStatistic()
                          .insertStatistic("CSR", "Level 1 Pengampu PADI");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return new DetailTwo(title: "UMKM Pengampu");
                          },
                        ),
                      );
                    },
                    click: true,
                  ),
                  ItemMenuOne(
                      title: "Pembiayaan UMKM",
                      total: "${summary_all['total_kategori']}",
                      height: 8.5,
                      width: 3.45,
                      onTap: () {
                        ApiStatistic().insertStatistic(
                            "CSR", "Level 1 Pembiayaan UMKM PADI");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return new DetailThree(title: "Pembiayaan UMKM");
                            },
                          ),
                        );
                      },
                      click: true),
                  ItemMenuOne(
                    title: "Kategori",
                    total: "${summary_all['umkm_handle_project']}",
                    height: 8.5,
                    width: 3.45,
                    click: true,
                    onTap: () {
                      ApiStatistic()
                          .insertStatistic("CSR", "Level 1 Kategori PADI");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return new DetailFour(title: "Kategori Project");
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              new ItemContainer(
                title: "BUMN",
                widget: [
                  ItemLineChart(
                    title: "Tren Trasaksi",
                  ),
                  ItemPieChartOne(
                    list_data: summary_source_of_budget,
                    title: "Source Budget",
                  )
                ],
              ),
              new ItemContainer(
                title: "UMKM",
                widget: [
                  ItemPieChartTwo(
                    title: "Level UMKM By Jumlah",
                  ),
                  ItemBarChartOne(
                    title: "Level UMKM BY Transaksi",
                  ),
                  ItemBarChartTwo(
                    listData: summary_top5_category_project,
                    title: "Top 5 Category Project",
                  )
                ],
              ),
              new ItemTableOne(
                title: "Tabulasi Value Project",
              ),
              new ItemTableOne(
                title: "Top 5 Pembiayan UMKM",
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
