import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/models/csr/pk_item.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_detailed/component/sektor_penyaluran_company/di/sektor_penyaluran_company_page_graph.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_detailed/component/sektor_penyaluran_company/sektor_penyaluran_company_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SektorPenyaluranCompanyPage extends StatefulWidget with InjectableWidget {
    final SektorPenyaluranCompanyPageGraph _graph;

    final String tahun;
    final String sektor;

    //injected
    ColorPalette colorPalette;
    //injected
    SektorPenyaluranCompanyActionMapper actionMapper;
    //injected
    CsrController csrController;

    @override
    SektorPenyaluranCompanyPageGraph graph() => _graph;

    SektorPenyaluranCompanyPage({
        @required
        this.tahun,
        @required
        this.sektor,
        SektorPenyaluranCompanyPageGraph graph
    }) : this._graph = graph ?? SektorPenyaluranCompanyPageGraph() {
        setup();
    }

    @override
    _SektorPenyaluranCompanyPageState createState() => _SektorPenyaluranCompanyPageState();
}

class _SektorPenyaluranCompanyPageState extends State<SektorPenyaluranCompanyPage> with AfterLayoutMixin<SektorPenyaluranCompanyPage> {

    Map<String, List<PkItem>> data;
    bool isError = false;

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
            final Map<String, List<PkItem>> map = {};
            List<PkItem> data = await widget.csrController.fetchPkByCompany(sektor: widget.sektor);
            data.forEach((item) {
               if (!map.containsKey(item.nama)) {
                   map[item.nama] = [item];
               } else {
                   map[item.nama].add(item);
               }
            });

            if (!mounted) return;
            setState(() {
                this.data = map;
            });
        } catch (ex) {
            print(ex);
            setState(() {
                isError = true;
            });
        }
    }

    Widget tableWidget(BuildContext context) {
        final Map<String, double> sortedData = data.map((k,v) => MapEntry(k, v.fold(0, (a,PkItem b) {
            final total = b.tahun.toString() == widget.tahun ? b.totalDana() : 0;
            return a+total;
        })));
        return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomTable<double>(
                colorPalette: widget.colorPalette,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                data: sortedData.sortBasedOnValue(),
                headers: [
                    TableText(text: "Nama Perusahaan", flexColumnWidth: 130.0),
                    TableText(text: "Realisasi", type: TableTextType.NUMBER, flexColumnWidth: 100.0),
                ],
                showTriliun: false,
                rowDescriptor: (String key, double datum)
                {
                    final total = datum/Constants.billion;
                    return TableRow(children: [
                        cell(
                            text: key ?? "-",
                            textAlign: TextAlign.start,
    //                        onTap: () => widget.actionMapper.openKomposisiDetailed(komposisi: key)
                        ),
                        cell(text: "${formatNumber(total)} M", textAlign: TextAlign.end),
                    ]);
                },
                total: data.values.fold(0, (a,b)=>a+ b.fold(0, (c,d)=> c+d.totalDana())),
            ),
        );
    }

    Widget mainWidget(BuildContext context) {
        return ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: <Widget>[
                tableWidget(context)
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
