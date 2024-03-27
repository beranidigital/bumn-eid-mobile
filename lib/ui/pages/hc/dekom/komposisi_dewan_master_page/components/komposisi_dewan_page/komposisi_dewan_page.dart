import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_list_bar_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/komposisi_dewan_page/di/komposisi_dewan_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/komposisi_dewan_page/komposisi_dewan_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

enum KomposisiDewanPageType {
    TARGET,
    REALISASI
}

class KomposisiDewanTableData {

    final String kategori;
    final double target;
    final double percentageRealization;

    KomposisiDewanTableData({
       @required
       this.kategori,
       @required
       this.target,
       @required
       this.percentageRealization
    });

}

class KomposisiDewanPageData with ListBarChartDataType{

    final String kategori;
    final double percentage;
    final KomposisiDewanPageType type;

    KomposisiDewanPageData({
       @required
       this.kategori,
       @required
       this.percentage,
       @required
       this.type,
    });

  @override
  String getColorKey() {
    return type == KomposisiDewanPageType.REALISASI ? "Realisasi" : "Target";
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
class KomposisiDewanPage extends StatefulWidget with InjectableWidget {
    final KomposisiDewanPageGraph _graph;

    //injected
    ColorPalette colorPalette;
    //injected
    KomposisiDewanActionMapper actionMapper;
    //injected
    HcController hcController;

    @override
    KomposisiDewanPageGraph graph() => _graph;

    KomposisiDewanPage([graph]) : this._graph = graph ?? KomposisiDewanPageGraph() {
        setup();
    }

    @override
    _KomposisiDewanPageState createState() => _KomposisiDewanPageState();
}

class _KomposisiDewanPageState extends State<KomposisiDewanPage> with AfterLayoutMixin<KomposisiDewanPage> {

    Map<String, List<KomposisiDewanPageData>> tableData;
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
            Map<String, List<KomposisiDewanPageData>> chartData = {};
            final data = await widget.hcController.fetchGrafikKomposisiDewan();

            data.proposedData.forEach((datum) {
                chartData[datum.nama] = [KomposisiDewanPageData(
                    percentage: datum.jumlah.toDouble(),
                    type: KomposisiDewanPageType.TARGET,
                    kategori: datum.nama,
                )];
            });

            data.realizationData.forEach((datum) {
                if (chartData.containsKey(datum.kategori)) {
                    chartData[datum.kategori].add(KomposisiDewanPageData(
                        percentage: (datum.jumlah / data.totalData) * 100,
                        type: KomposisiDewanPageType.REALISASI,
                        kategori: datum.kategori,
                    ));
                }
            });

            if (!mounted) return;
            processData(chartData);
        } catch (ex) {
            print(ex.toString());
            setState(() {
                isError = true;
            });
        }
    }

    processData(Map<String, List<KomposisiDewanPageData>> chartData) {
        chartData.values.forEach(
                (list) {
                list.sort((KomposisiDewanPageData a, KomposisiDewanPageData b)
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
            intervalY: 20,
            width: 18,
            barSpace: 0,
            bottomRotateAngle: 300,
            reservedBottomSize: 48,
            keyToColor: {
                "Realisasi": Color(0xFFFBD300),
                "Target": Color(0xFF4572E5),
            },
        );
    }

    Widget tableWidget(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomTable<KomposisiDewanTableData>(
                colorPalette: widget.colorPalette,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                data: tableData.map((k,v) => MapEntry(k, KomposisiDewanTableData(
                    kategori: v.first.kategori,
                    target: v.first.percentage,
                    percentageRealization: v.last.percentage,
                ))),
                headers: [
                    TableText(text: "Keterangan", flexColumnWidth: 130.0),
                    TableText(text: "Target", type: TableTextType.NUMBER, flexColumnWidth: 100.0),
                    TableText(text: "Realisasi", type: TableTextType.NUMBER, flexColumnWidth: 100.0),
                ],
                showTriliun: false,
                rowDescriptor: (String key, KomposisiDewanTableData data)
                => TableRow(children: [
                    cell(
                        text: data.kategori,
                        textAlign: TextAlign.start,
                    ),
                    cell(text: "${data.target.toStringAsFixed(0)}%", textAlign: TextAlign.end),
                    cell(text: "${data.percentageRealization.toStringAsFixed(0)}%", textAlign: TextAlign.end),
                ]),
            ),
        );
    }

    Widget titleWidget(BuildContext context) {
        return Text(
            "Komposisi Dewan Komisaris dan Dewan Pengawas",
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
