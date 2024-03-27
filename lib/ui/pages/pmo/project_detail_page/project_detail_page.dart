import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/api/response/pmo/project_detail_response.dart';
import 'package:bumn_eid/core/controllers/pmo_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/pmo/project_item.dart';
import 'package:bumn_eid/core/models/pmo/project_progress.dart';
import 'package:bumn_eid/core/models/pmo/project_support.dart';
import 'package:bumn_eid/core/models/pmo/project_team.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_expansion_tile.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/pmo/project_detail_page/di/project_detail_page_graph.dart';
import 'package:bumn_eid/ui/pages/pmo/project_detail_page/project_detail_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:timeline/model/timeline_model.dart';
import 'package:timeline/timeline.dart';

// ignore: must_be_immutable
class ProjectDetailPage extends StatefulWidget with InjectableWidget {
  final ProjectDetailPageGraph _graph;

  final int id;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;
  //injected
  PMOController pmoController;
  //injected
  ProjectDetailActionMapper actionMapper;

  ProjectDetailPage({@required this.id, ProjectDetailPageGraph graph})
      : this._graph = graph ?? ProjectDetailPageGraph() {
    setup();
  }

  @override
  ProjectDetailPageGraph graph() => _graph;

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage>
    with AfterLayoutMixin<ProjectDetailPage> {
  bool isError = false;

  ProjectDetailResponse data;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return data != null;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      final data = await widget.pmoController.fetchProjectDetail(id: widget.id);

      setState(() {
        this.data = data;
      });
    } catch (ex) {
      print(ex.toString());
      setState(() {
        this.isError = true;
      });
    }
  }

  ProjectItem getProject() => data.project.first;

  Widget progressInfo(BuildContext context) {
    return data.progress.isEmpty
        ? Container()
        : CustomExpansionTile(
            colorPalette: widget.colorPalette,
            icon: Icons.info,
            text: "Progress",
            children: <Widget>[
              Container(
                color: Color(0xFFE7F0FF),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(data.progress.length,
                      (idx) => progressItem(data.progress[idx])),
                ),
              )
            ],
          );
  }

  Widget progressItem(ProjectProgress item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Deskripsi: ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(
            item.description ?? "-",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Text(
            "Status: ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(
            item.status ?? "-",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Text(
            "Progress (in percent): ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(
            "${item.progress ?? "-"} %",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget teamItem(ProjectTeam item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Nama: ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(
            item.pic ?? "-",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Text(
            "Tim: ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(
            item.jenisTim ?? "-",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Text(
            "Jabatan: ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(
            "${item.namaJabatan ?? "-"}",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Text(
            "Instansi: ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(
            "${item.instansi ?? "-"}",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget teamInfo(BuildContext context) {
    return data.team.isEmpty
        ? Container()
        : CustomExpansionTile(
            colorPalette: widget.colorPalette,
            icon: Icons.info,
            text: "Team",
            children: <Widget>[
              Container(
                color: Color(0xFFE7F0FF),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      data.team.length, (idx) => teamItem(data.team[idx])),
                ),
              )
            ],
          );
  }

  Widget milestoneInfo(BuildContext context) {
    return data.milestone.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.info,
              text: "Milestone",
              children: <Widget>[
                Container(
                  height: data.milestone.length * 100.0,
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: TimelineComponent(
                    timelineList: data.milestone
                        .map((item) => TimelineModel(
                            id: item.id.toString(),
                            description: item.description,
                            title: "${item.bulan ?? "-"} ${item.tahun}"))
                        .toList(),
                    descriptionColor: widget.colorPalette.black,
                  ),
                )
              ],
            ),
          );
  }

  Widget supportItem(ProjectSupport item) {
    final content = item.kodeKategori == "1" ? item.support : item.kendala;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "- $content" ?? "-",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget kendalaInfo(BuildContext context) {
    final data =
        this.data.support.where((item) => item.kodeKategori == "2").toList();
    return data.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.info,
              text: "Kendala",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        data.length, (idx) => supportItem(data[idx])),
                  ),
                )
              ],
            ),
          );
  }

  Widget supportInfo(BuildContext context) {
    final data =
        this.data.support.where((item) => item.kodeKategori == "1").toList();
    return data.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.info,
              text: "Dukungan",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        data.length, (idx) => supportItem(data[idx])),
                  ),
                )
              ],
            ),
          );
  }

  Widget keteranganInfo(BuildContext context) {
    final url = this.data.project.first.keterangan;
    return url.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.info,
              text: "Keterangan",
              children: <Widget>[
                Container(
                    color: Color(0xFFE7F0FF),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        url == null || url.isEmpty
                            ? Text("Data tidak tersedia")
                            : GestureDetector(
                                child: Text(
                                  "Buka Keterangan di Browser",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      decoration: TextDecoration.underline),
                                ),
                                onTap: () {
                                  launchUrl(url);
                                },
                              )
                      ],
                    ))
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
          teamInfo(context),
          progressInfo(context),
          milestoneInfo(context),
          kendalaInfo(context),
          supportInfo(context),
          keteranganInfo(context)
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
        : Container(
            color: widget.colorPalette.defaultBg,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Text(
                      getProject().nama,
                      style: TextStyle(
                          color: widget.colorPalette.black, fontSize: 18.0),
                    ),
                  ),
                ),
                detailsList(context)
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Detail Program Prioritas',
      body: (context) => mainWidget(context),
    );
  }
}
