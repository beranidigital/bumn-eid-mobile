import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/internal/summary_internal.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_card.dart';
import 'package:bumn_eid/ui/components/base_filter.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/default_loading_widget.dart';
import 'package:bumn_eid/ui/components/horizontal_bar_chart.dart';
import 'package:bumn_eid/ui/components/image_statistic.dart';
import 'package:bumn_eid/ui/components/loadable_widget.dart';
import 'package:bumn_eid/ui/components/vertical_bar_chart.dart';
import 'package:bumn_eid/ui/pages/internal/di/internal_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class InternalPage extends StatefulWidget with InjectableWidget {
  final InternalPageGraph _graph;

  // injected
  CompaniesController companiesController;
  // injected
  Store<AppState> store;

  InternalPage([graph]) : this._graph = graph ?? InternalPageGraph() {
    setup();
  }

  @override
  InternalPageGraph graph() => _graph;

  @override
  _InternalPageState createState() => _InternalPageState();
}

class _InternalPageState extends State<InternalPage> {
  SummaryInternal summaryInternal;

  String currentUsia;
  String currentPendidikan;
  String currentAgama;
  String currentStatus;

  getData() async {
    final prevData = summaryInternal;
    try {
      setState(() {
        summaryInternal = null;
      });

      final summaries = await widget.companiesController.fetchInternalSummary(
        usia: currentUsia,
        pendidikan: currentPendidikan,
        agama: currentAgama,
        statusPegawai: currentStatus,
      );

      setState(() {
        summaryInternal = summaries;
      });
    } catch (ex) {
      setState(() {
        summaryInternal = prevData;
      });
    }
  }

  Widget mainWidget(BuildContext context) {
    return LoadableWidget(
      fetchFunction: () async {
        await getData();

        return 0;
      },
      colorPalette: ColorPalette(),
      buildFunction: (ctx, data) {
        if (summaryInternal == null)
          return Center(
            child: DefaultLoadingWidget(
              colorPalette: ColorPalette(),
            ),
          );
        return ListView(
          padding: EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 58.0,
          ),
          children: [
            BaseFilter(
              onAgamaChanged: (a) {
                setState(() {
                  this.currentAgama = a;
                });
                getData();
              },
              onStatusPegawaiChanged: (a) {
                setState(() {
                  this.currentStatus = a;
                });
                getData();
              },
              onTingkatUmurChanged: (a) {
                setState(() {
                  this.currentUsia = a;
                });
                getData();
              },
              onTingkatPendidikanChanged: (a) {
                setState(() {
                  this.currentPendidikan = a;
                });
                getData();
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            BaseCard(
              title: 'Jumlah Pegawai',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Tidak termasuk PPNPN dan Staf Pendukung Pimpinan',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w300,
                      fontSize: 10.0,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  LayoutBuilder(builder: (
                    ctx,
                    constraints,
                  ) {
                    final total =
                        summaryInternal.summaryJumlahPegawai.totalPegawai;
                    final laki = summaryInternal
                        .summaryJumlahPegawai.jenisKelamin
                        .firstWhere((element) => element.jenisKelamin == 'L');
                    final perempuan = summaryInternal
                        .summaryJumlahPegawai.jenisKelamin
                        .firstWhere((element) => element.jenisKelamin == 'P');
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ImageStatistic(
                            image: 'res/images/ic_teamwork.png',
                            topText: total.toString(),
                            bottomText: 'Pegawai',
                          ),
                        ),
                        Expanded(
                          child: ImageStatistic(
                            image: 'res/images/ic_man.png',
                            topText:
                                '${laki.total} (${((laki.total / total) * 100).toStringAsFixed(2)}%)',
                            bottomText: 'Laki-laki',
                          ),
                        ),
                        Expanded(
                          child: ImageStatistic(
                            image: 'res/images/ic_woman.png',
                            topText:
                                '${perempuan.total} (${((perempuan.total / total) * 100).toStringAsFixed(2)}%)',
                            bottomText: 'Perempuan',
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            BaseCard(
              title: 'Kelompok Usia',
              child: VerticalBarChart(
                height: MediaQuery.of(context).size.height * 0.20,
                data: {
                  '-30': summaryInternal.summaryUsia.first.under30,
                  '30-39': summaryInternal.summaryUsia.first.between3039,
                  '40-49': summaryInternal.summaryUsia.first.between4049,
                  '50+': summaryInternal.summaryUsia.first.above50,
                },
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            BaseCard(
              title: 'Agama',
              child: CustomPieChart(
                tableData: summaryInternal.summaryAgama.asMap().map(
                    (key, value) =>
                        MapEntry(value.agama ?? '-', [value.total])),
                colorPalette: ColorPalette(),
                customTotalCount:
                    summaryInternal.summaryJumlahPegawai.totalPegawai,
                customCountFunction: (a) => a.first,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            BaseCard(
              title: 'Tingkat Pendidikan',
              child: VerticalBarChart(
                data: summaryInternal.summaryPendidikan.asMap().map(
                    (key, value) =>
                        MapEntry(value.pendidikan ?? '-', value.total)),
                height: MediaQuery.of(context).size.height * 0.20,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            BaseCard(
              title: 'Status Perkawinan',
              child: CustomPieChart(
                colorPalette: ColorPalette(),
                tableData: summaryInternal.summaryStatusNikah.asMap().map(
                    (key, value) =>
                        MapEntry(value.statusNikah ?? '-', [value.total])),
                customTotalCount:
                    summaryInternal.summaryJumlahPegawai.totalPegawai,
                customCountFunction: (a) => a.first,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            BaseCard(
              title: 'Status Pegawai',
              child: VerticalBarChart(
                height: MediaQuery.of(context).size.height * 0.2,
                data: summaryInternal.summaryStatusPegawai.asMap().map(
                    (key, value) => MapEntry(value.statusPegawai, value.total)),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            BaseCard(
              title: 'Tingkat Jabatan',
              child: HorizontalBarChart(
                data: summaryInternal.summaryJabatan
                    .asMap()
                    .map((key, value) => MapEntry(value.jabatan, value.total)),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            BaseCard(
              title: 'Distribusi Unit Kerja',
              child: HorizontalBarChart(
                data: summaryInternal.summaryUnitKerja.asMap().map(
                      (key, value) => MapEntry(
                        value.unitKerja ?? '-',
                        value.total,
                      ),
                    ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Internal',
      body: (ctx) => mainWidget(ctx),
    );
  }
}
