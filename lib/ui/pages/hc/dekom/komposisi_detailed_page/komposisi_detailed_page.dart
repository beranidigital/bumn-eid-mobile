import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/dekom_detailed_item.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_detailed_page/di/komposisi_detailed_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_detailed_page/komposisi_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// ignore: must_be_immutable
class KomposisiDetailedPage extends StatefulWidget with InjectableWidget {
  final KomposisiDetailedPageGraph _graph;

  final String komposisi;

  //injected
  ColorPalette colorPalette;
  //injected
  KomposisiDetailedActionMapper actionMapper;
  //injected
  HcController hcController;

  @override
  KomposisiDetailedPageGraph graph() => _graph;

  KomposisiDetailedPage(
      {@required this.komposisi, KomposisiDetailedPageGraph graph})
      : this._graph = graph ?? KomposisiDetailedPageGraph() {
    setup();
  }

  @override
  _KomposisiDetailedPageState createState() => _KomposisiDetailedPageState();
}

class _KomposisiDetailedPageState extends State<KomposisiDetailedPage>
    with AfterLayoutMixin<KomposisiDetailedPage> {
  List<DekomDetailedItem> data;
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
      final data = await widget.hcController
          .fetchTalentByKomposisi(komposisi: widget.komposisi);

      setState(() {
        this.data = data;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        isError = true;
      });
    }
  }

  Widget listItem(DekomDetailedItem data) {
    return GestureDetector(
      onTap: () => widget.actionMapper.openTalentPage(
        id: data.id,
      ),
      child: Container(
        height: 100.0,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          elevation: 16.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data.nama,
                        maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        data.companyName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Periode ${data.periode}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: widget.colorPalette.primary,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data.sisaWaktu.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Hari",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${formatNumber(parseDouble(data.persentase))}%",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> listWidget(BuildContext context) {
    return List.generate(data.length, (idx) {
      return listItem(data[idx]);
    });
  }

  Widget titleWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        "Daftar Dewan Komisaris ${widget.komposisi}",
        textAlign: TextAlign.center,
        maxLines: 2,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        titleWidget(context),
      ]
        ..addAll(listWidget(context))
        ..add(LastUpdateWidget(
          store: StoreProvider.of<AppState>(context),
          pageName: "hc",
        )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Dewan Komisaris / Dewan Pengawas",
      body: (ctx) => SafeArea(
        child: data == null
            ? isError
                ? CustomErrorWidget(
                    onRetry: () => getData(),
                  )
                : LoadingWidget(
                    colorPalette: widget.colorPalette,
                  )
            : mainWidget(context),
      ),
    );
  }
}
