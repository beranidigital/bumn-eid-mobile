import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_list_bar_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/components/komposisi_bod_page/di/komposisi_bod_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/components/komposisi_bod_page/komposisi_bod_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class KomposisiBODTableData {

    final String kategori;
    final double realization;

    KomposisiBODTableData({
       @required
       this.kategori,
       @required
       this.realization,
    });

}

class KomposisiBODPageData with ListBarChartDataType{

    final String kategori;
    final double percentage;

    KomposisiBODPageData({
       @required
       this.kategori,
       @required
       this.percentage,
    });

  @override
  String getColorKey() {
    return "Realisasi";
  }

  @override
  int getX() {
    return kategori.hashCode;
  }

  @override
  double getY() {
    return percentage;
  }

}

// ignore: must_be_immutable
class KomposisiBODPage extends StatefulWidget with InjectableWidget {
    final KomposisiBODPageGraph _graph;

    //injected
    ColorPalette colorPalette;
    //injected
    KomposisiBODActionMapper actionMapper;
    //injected
    HcController hcController;

    @override
    KomposisiBODPageGraph graph() => _graph;

    KomposisiBODPage([graph]) : this._graph = graph ?? KomposisiBODPageGraph() {
        setup();
    }

    @override
    _KomposisiBODPageState createState() => _KomposisiBODPageState();
}

class _KomposisiBODPageState extends State<KomposisiBODPage> with AfterLayoutMixin<KomposisiBODPage> {

    int totalData;
    Map<String, List<KomposisiBODPageData>> tableData;
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
            Map<String, List<KomposisiBODPageData>> chartData = {};
            final data = await widget.hcController.fetchGrafikKomposisiBOD();

            data.realizationData.forEach((datum) {
                    chartData[datum.kategori] = [KomposisiBODPageData(
                        percentage: datum.jumlah.toDouble(),
                        kategori: datum.kategori,
                    )];
            });

            setState(() {
              this.totalData = data.totalData;
            });

            processData(chartData);
        } catch (ex) {
            print(ex.toString());
            setState(() {
                isError = true;
            });
        }
    }

    processData(Map<String, List<KomposisiBODPageData>> chartData) {
        chartData.values.forEach(
                (list) {
                list.sort((KomposisiBODPageData a, KomposisiBODPageData b)
                => a.kategori.compareTo(b.kategori));
            }
        );

        setState(() {
            this.tableData = chartData;
        });
    }

    Widget chartWidget(BuildContext context) {
        return CustomListBarChart(
            colorPalette: widget.colorPalette,
            chartHeight: 300,
            data: tableData,
            intervalY: 50,
            width: 18,
            barSpace: 0,
            leftPadding: 24,
            bottomRotateAngle: 300,
            reservedBottomSize: 48,
            keyToColor: {
                "Realisasi": Color(0xFF4572E5),
            },
        );
    }

    Widget tableWidget(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomTable<KomposisiBODTableData>(
                colorPalette: widget.colorPalette,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                data: tableData.map((k,v) => MapEntry(k, KomposisiBODTableData(
                    kategori: v.first.kategori,
                    realization: v.first.percentage,
                ))),
                headers: [
                    TableText(text: "Keterangan", flexColumnWidth: 130.0),
                    TableText(text: "Realisasi", type: TableTextType.NUMBER, flexColumnWidth: 100.0),
                ],
                showTriliun: false,
                rowDescriptor: (String key, KomposisiBODTableData data)
                => TableRow(children: [
                    cell(
                        text: data.kategori,
                        textAlign: TextAlign.start,

                    ),
                    cell(text: "${(data.realization/totalData * 100).toStringAsFixed(0)}%", textAlign: TextAlign.end),
                ]),
            ),
        );
    }

    Widget titleWidget(BuildContext context) {
        return Text(
            "Komposisi BOD",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.0
            ),
        );
    }

    Widget mainWidget(BuildContext context) {
        return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
                titleWidget(context),
                chartWidget(context),
                tableWidget(context),
                LastUpdateWidget(
                    store: StoreProvider.of<AppState>(context),
                    pageName: "hc",
                )
            ],
        );
    }

    @override
    Widget build(BuildContext context) {
        return tableData == null
            ? isError ? CustomErrorWidget(onRetry: () => getData(),) : LoadingWidget(colorPalette: widget.colorPalette,)
            : mainWidget(context);
    }
}
