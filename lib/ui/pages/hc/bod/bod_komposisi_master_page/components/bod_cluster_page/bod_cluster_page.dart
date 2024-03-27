import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_bod_cluster_response.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/components/bod_cluster_page/bod_cluster_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/components/bod_cluster_page/di/bod_cluster_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BODClusterPageData {

    final String cluster;
    final int jumlah;

    BODClusterPageData({
        @required
        this.cluster,
        @required
        this.jumlah
    });

}

// ignore: must_be_immutable
class BODClusterPage extends StatefulWidget with InjectableWidget {
    final BODClusterPageGraph _graph;

    //injected
    ColorPalette colorPalette;
    //injected
    BODClusterActionMapper actionMapper;
    //injected
    HcController hcController;

    @override
    BODClusterPageGraph graph() => _graph;

    BODClusterPage([graph]) : this._graph = graph ?? BODClusterPageGraph() {
        setup();
    }

    @override
    _BODClusterPageState createState() => _BODClusterPageState();
}

class _BODClusterPageState extends State<BODClusterPage> with AfterLayoutMixin<BODClusterPage> {

    GrafikBODClusterResponse data;
    bool isError = false;
    String currentWamen;
    final wamenList = Constants.wamenList;

    @override
    void afterFirstLayout(BuildContext context) {
        getData();
    }

    void getData({String wamen}) async {
        try {
            setState(() {
                this.data = null;
                this.isError = false;
            });
            GrafikBODClusterResponse data;
            if (wamen == null) {
                data = await widget.hcController.fetchGrafikBODCluster();
            } else {
                data = await widget.hcController.fetchGrafikBODWamen(wamen: wamen);
            }

            setState(() {
                this.data = data;
            });
        } catch (ex) {
            setState(() {
                isError = true;
            });
        }
    }

    Widget chartWidget(BuildContext context) {
        final filteredData = data.data.toList()..sort((a,b)=>b.jumlah.compareTo(a.jumlah));
        final mapData = filteredData.sublist(0,9).asMap().map((k,v) {
            return MapEntry(v.cluster ?? "Lain Lain", [BODClusterPageData(
                cluster: v.cluster ?? "Lain Lain",
                jumlah: v.jumlah
            )]);
        });
        return CustomPieChart(
            colorPalette: widget.colorPalette,
            tableData: mapData,
            customCountFunction: (list) => list.first.jumlah,
            customTotalCount: data.totalData,
            maxItemToShowLabel: 4,
        );
    }

    Widget tableWidget(BuildContext context) {
        final filteredData = data.data.toList()..sort((a,b)=>b.jumlah.compareTo(a.jumlah));
        return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomTable(
                colorPalette: widget.colorPalette,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                data: filteredData.asMap().map((k,v) => MapEntry(v.cluster ?? "Lain Lain", BODClusterPageData(
                    cluster: v.cluster,
                    jumlah: v.jumlah
                ))),
                headers: [
                    TableText(text: "Keterangan", flexColumnWidth: 130.0),
                    TableText(text: "Komposisi", type: TableTextType.NUMBER, flexColumnWidth: 100.0),
                ],
                showTriliun: false,
                rowDescriptor: (String key, BODClusterPageData datum)
                => TableRow(children: [
                    cell(
                        text: key ?? "-",
                        textAlign: TextAlign.start,

                    ),
                    cell(text: formatNumber(datum.jumlah), textAlign: TextAlign.end),
                ]),
                total: filteredData.fold(0, (a,b)=>a+b.jumlah),
            ),
        );
    }

    Widget filterWidget(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: FilterWidget(
                items: wamenList,
                currentItem: currentWamen ?? "-",
                title: "Filter Wamen",
                onChanged: (newWamen) {
                    final wamen = newWamen == "-" ? null : newWamen;
                    setState(() {
                      this.currentWamen = wamen;
                    });
                    getData(wamen: wamen);
                },
            ),
          ),
        );
    }

    Widget titleWidget(BuildContext context) {
        return Text(
            "Komposisi BOD Berdasarkan Cluster",
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
                filterWidget(context),
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
        return data == null
            ? isError ? CustomErrorWidget(onRetry: () => getData(),) : LoadingWidget(colorPalette: widget.colorPalette,)
            : mainWidget(context);
    }
}
