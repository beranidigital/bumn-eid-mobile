import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/talent_detail.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_expansion_tile.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_anak_talent_detail_page/dekom_anak_talent_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_anak_talent_detail_page/di/dekom_anak_talent_detail_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class DekomAnakTalentDetailPage extends StatefulWidget with InjectableWidget {
  final DekomAnakTalentDetailPageGraph _graph;

  final int id;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;
  //injected
  HcController hcController;
  //injected
  DekomAnakTalentDetailActionMapper actionMapper;

  DekomAnakTalentDetailPage(
      {@required this.id, DekomAnakTalentDetailPageGraph graph})
      : this._graph = graph ?? DekomAnakTalentDetailPageGraph() {
    setup();
  }

  @override
  DekomAnakTalentDetailPageGraph graph() => _graph;

  @override
  _DekomAnakTalentDetailPageState createState() =>
      _DekomAnakTalentDetailPageState();
}

class _DekomAnakTalentDetailPageState extends State<DekomAnakTalentDetailPage>
    with AfterLayoutMixin<DekomAnakTalentDetailPage> {
  bool isError = false;

  TalentDetail talent;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return talent != null;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      final fetchedDekomAnakTalent =
          await widget.hcController.fetchPejabatAnak(id: widget.id);

      setState(() {
        this.talent = fetchedDekomAnakTalent;
      });
    } catch (ex) {
      print(ex.toString());
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget talentInfo(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700);
    final itemStyle = TextStyle(
      fontSize: 16.0,
    );
    return CustomExpansionTile(
      colorPalette: widget.colorPalette,
      icon: Icons.info,
      text: "Identitas Diri",
      children: <Widget>[
        Container(
          color: Color(0xFFE7F0FF),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Nama Lengkap",
                style: titleStyle,
              ),
              Text(
                talent.name,
                style: itemStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Tempat, Tanggal Lahir",
                  style: titleStyle,
                ),
              ),
              Text(
                talent.birthDate,
                style: itemStyle,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget careerInfo(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700);
    final itemStyle = TextStyle(
      fontSize: 16.0,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        icon: Icons.info,
        text: "Karir",
        children: <Widget>[
          Container(
            color: Color(0xFFE7F0FF),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Periode",
                  style: titleStyle,
                ),
                Text(
                  talent.periode ?? "-",
                  style: itemStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "SK",
                    style: titleStyle,
                  ),
                ),
                Text(
                  talent.sk ?? "-",
                  style: itemStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Tanggal SK",
                    style: titleStyle,
                  ),
                ),
                Text(
                  talent.tanggalSk ?? "-",
                  style: itemStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Mulai Jabat",
                    style: titleStyle,
                  ),
                ),
                Text(
                  talent.mulaiJabat ?? "-",
                  style: itemStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Akhir Jabat",
                    style: titleStyle,
                  ),
                ),
                Text(
                  talent.akhirJabat ?? "-",
                  style: itemStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Instansi Asal",
                    style: titleStyle,
                  ),
                ),
                Text(
                  talent.instansiAsal ?? "-",
                  style: itemStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Tanggal Serah Terima",
                    style: titleStyle,
                  ),
                ),
                Text(
                  talent.tanggalSerahTerima ?? "-",
                  style: itemStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Keterangan Tambahan",
                    style: titleStyle,
                  ),
                ),
                Text(
                  talent.keterangan ?? "-",
                  style: itemStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget detailsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          talentInfo(context),
          careerInfo(context),
        ],
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return !isDataReady()
        ? isError
            ? CustomErrorWidget(
                onRetry: () => getData(),
              )
            : LoadingWidget(
                colorPalette: widget.colorPalette,
              )
        : ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Center(
                  child: Text(
                    talent.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: widget.colorPalette.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Text(
                    talent.bidang + ", " + talent.companyName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: widget.colorPalette.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              detailsList(context),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LastUpdateWidget(
                  store: StoreProvider.of<AppState>(context),
                  pageName: "hc",
                ),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Dekom Anak Perusahaan",
      body: (ctx) => mainWidget(context),
    );
  }
}
