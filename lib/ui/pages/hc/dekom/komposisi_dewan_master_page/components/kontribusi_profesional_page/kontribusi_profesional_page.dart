import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_dewan_grouped_response.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/kontribusi_profesional_page/di/kontribusi_profesional_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/kontribusi_profesional_page/kontribusi_profesional_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class KontribusiProfesionalPageData {

    final String kategori;
    final int jumlah;

    KontribusiProfesionalPageData({
       @required
       this.kategori,
       @required
       this.jumlah
    });

}

// ignore: must_be_immutable
class KontribusiProfesionalPage extends StatefulWidget with InjectableWidget {
    final KontribusiProfesionalPageGraph _graph;

    //injected
    ColorPalette colorPalette;
    //injected
    KontribusiProfesionalActionMapper actionMapper;
    //injected
    HcController hcController;

    @override
    KontribusiProfesionalPageGraph graph() => _graph;

    KontribusiProfesionalPage([graph]) : this._graph = graph ?? KontribusiProfesionalPageGraph() {
        setup();
    }

    @override
    _KontribusiProfesionalPageState createState() => _KontribusiProfesionalPageState();
}

class _KontribusiProfesionalPageState extends State<KontribusiProfesionalPage> with AfterLayoutMixin<KontribusiProfesionalPage> {

    GrafikDewanGroupedResponse data;
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
            final data = await widget.hcController.fetchGrafikKomposisiDewanProfesional();

            if (!mounted) return;
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
        final mapData = data.data.asMap().map((k,v) => MapEntry(v.namaGroup, [KontribusiProfesionalPageData(
            kategori: v.namaGroup,
            jumlah: v.jumlah
        )]));
        return CustomPieChart(
            colorPalette: widget.colorPalette,
            tableData: mapData,
            customCountFunction: (list) => list.first.jumlah,
            customTotalCount: data.totalData,
            maxItemToShowLabel: 2,
        );
    }

    Widget tableWidget(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomTable(
                colorPalette: widget.colorPalette,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                data: data.data.asMap().map((k,v) => MapEntry(v.namaGroup, KontribusiProfesionalPageData(
                    kategori: v.namaGroup,
                    jumlah: v.jumlah
                ))),
                headers: [
                    TableText(text: "Keterangan", flexColumnWidth: 130.0),
                    TableText(text: "Komposisi", type: TableTextType.NUMBER, flexColumnWidth: 100.0),
                ],
                showTriliun: false,
                rowDescriptor: (String key, KontribusiProfesionalPageData datum)
                => TableRow(children: [
                    cell(
                        text: key,
                        textAlign: TextAlign.start,
                        onTap: () => widget.actionMapper.openKomposisiDetailed(komposisi: key)

                    ),
                    cell(text: formatNumber(datum.jumlah), textAlign: TextAlign.end),
                ]),
                total: data.data.fold(0, (a,b)=>a+b.jumlah),
            ),
        );
    }

    Widget titleWidget(BuildContext context) {
        return Text(
            "Komposisi Profesional Korporasi pada Dewan Komisaris / Dewan Pengawas",
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
        return data == null
            ? isError ? CustomErrorWidget(onRetry: () => getData(),) : LoadingWidget(colorPalette: widget.colorPalette,)
            : mainWidget(context);
    }
}
