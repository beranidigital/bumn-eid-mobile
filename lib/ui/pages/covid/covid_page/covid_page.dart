import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/api/response/covid/covid_summary_response.dart';
import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/covid/covid_cluster.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/basic_menu.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/small_pie_chart_menu.dart';
import 'package:bumn_eid/ui/pages/covid/covid_page/covid_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_page/di/covid_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class CovidPage extends StatefulWidget with InjectableWidget {
  final CovidPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  CovidActionMapper actionMapper;
  //injected
  CovidController covidController;
  //injected
  Store<AppState> store;

  @override
  CovidPageGraph graph() => _graph;

  CovidPage([graph]) : this._graph = graph ?? CovidPageGraph() {
    setup();
  }

  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage>
    with AfterLayoutMixin<CovidPage> {
  String selected = "timeline";

  bool isError = false;
  List<CovidCluster> clusters;
  CovidSummaryResponse summaryData;
  String currentSelectedTimeline;

  bool isDataReady() {
    return summaryData != null &&
        clusters != null &&
        currentSelectedTimeline != null;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  getData() async {
    try {
      final summaryData = await widget.covidController.fetchCovidSummary();
      final clusterData = await widget.covidController.fetchCovidCluster();

      setState(() {
        this.summaryData = summaryData;
        this.clusters = clusterData;
        this.currentSelectedTimeline = dateTimeToString(
            parseDateTime(summaryData.review.first.tanggalReview));
      });
    } catch (ex) {
      print(ex);
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget tabItem({String text, bool selected, VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: selected
                      ? widget.colorPalette.black
                      : widget.colorPalette.mediumGrey,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0),
            ),
          ),
          Container(
            width: 85,
            height: 4,
            color: selected ? widget.colorPalette.primary : Colors.transparent,
          )
        ],
      ),
    );
  }

  Widget tabWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: tabItem(
              text: "Timeline BUMN",
              selected: selected == "timeline",
              onTap: () {
                setState(() {
                  this.selected = "timeline";
                });
              }),
        ),
        Expanded(
          child: tabItem(
              text: "Status Orang",
              selected: selected == "status",
              onTap: () {
                setState(() {
                  this.selected = "status";
                });
              }),
        ),
        Expanded(
          child: tabItem(
              text: "Readiness",
              selected: selected == "readiness",
              onTap: () {
                setState(() {
                  this.selected = "readiness";
                });
              }),
        ),
      ],
    );
  }

  Widget statusChart() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: widget.colorPalette.primary,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8),
            margin: EdgeInsets.only(bottom: 16),
            child: Center(
              child: Text(
                "${summaryData.data.kasusTotal} Kasus Positif",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Color(0xFFFFE351),
                  padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8),
                  margin: EdgeInsets.only(right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${summaryData.data.kasusDirawat}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "PDP",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Color(0xFFFF6F77),
                  padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8),
                  margin: EdgeInsets.only(right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${summaryData.data.kasusMeninggal}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Meninggal",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Color(0xFF7CC38C),
                  padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8),
                  margin: EdgeInsets.only(right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${summaryData.data.kasusSembuh}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "ODP",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget readinessChart(BuildContext context) {
    final Map<String, int> data = {
      "Ready": summaryData.data.progressTotallyReady.toInt(),
      "Almost Ready": summaryData.data.progressAlmostReady.toInt(),
      "Not Ready": summaryData.data.progressNotReady.toInt(),
    };
    final Map<String, Color> colorMap = {
      "Ready": Colors.greenAccent,
      "Almost Ready": Colors.yellowAccent,
      "Not Ready": Colors.redAccent,
    };

    final centerSpaceRadius = MediaQuery.of(context).size.width * 0.06;
    final radius = centerSpaceRadius * 2;

    return SmallPieChartMenu(
      colorPalette: widget.colorPalette,
      title: "Readiness",
      onTap: null,
      chartData: data,
      withTitle: false,
      legendTextSize: 15.0,
      radius: radius,
      centerSpaceRadius: centerSpaceRadius,
      textSize: 16.0,
      colorMap: colorMap,
      sortKeys: false,
    );
  }

  Widget timelineChart(BuildContext context) {
    final data = summaryData.review.firstWhere((datum) {
      return dateTimeToString(parseDateTime(datum.tanggalReview)) ==
          this.currentSelectedTimeline;
    });

    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FilterWidget(
            title: "",
            withTitle: false,
            items: summaryData.review.map((review) {
              return dateTimeToString(parseDateTime(review.tanggalReview));
            }).toList(),
            width: 150,
            currentItem: currentSelectedTimeline,
            onChanged: (newTimeline) {
              setState(() {
                this.currentSelectedTimeline = newTimeline;
              });
            },
          ),
          Expanded(
            child: CustomPieChart(
              colorPalette: widget.colorPalette,
              tableData: {
                "100 %": [data.timelineGreen],
                "81 - 99 %": [data.timelineYellow],
                "0 - 80 %": [data.timelineRed],
              },
              colorMap: {
                "100 %": Color(0xFF39A952),
                "81 - 99 %": Color(0xFFD8B005),
                "0 - 80 %": Color(0xFF94171F),
              },
              sortKeys: false,
              customTotalCount: data.timelineAll,
              customCountFunction: (List datas) {
                return datas.first;
              },
            ),
          )
        ],
      ),
    );
  }

  Widget summary(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          tabWidget(),
          Expanded(
              child: selected == "readiness"
                  ? readinessChart(context)
                  : selected == "status"
                      ? statusChart()
                      : timelineChart(context)),
          GestureDetector(
            onTap: () {
              if (selected == "timeline") {
                widget.actionMapper.openClusterBumn();
              } else {
                widget.actionMapper.openTotalBumn();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: widget.colorPalette.primary,
                  borderRadius: BorderRadius.circular(4.0)),
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Center(
                child: Text(
                  "Lihat Detail",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget menuList(BuildContext context) {
    final List<String> clusterNames = [];
    clusters.forEach((cluster) {
      if (!clusterNames.contains(cluster.clusterBumn))
        clusterNames.add(cluster.clusterBumn);
    });
    return Container(
      color: widget.colorPalette.defaultBg,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: BasicMenu(
                    title: "Total Progress",
                    subtitle: "",
                    onTap: () => widget.actionMapper.openTotalBumn(),
                    bgColor: Color(0xFFD4DBFF),
                    bottomColor: Color(0xFF6778DB),
                    textColor: Colors.black,
                    total: summaryData.data.progressAllBumn.toInt(),
                    percentage: true,
                    bottomText: "From All BUMN",
                  ),
                ),
                Expanded(
                  child: BasicMenu(
                    title: "",
                    subtitle: "",
                    onTap: () => widget.actionMapper.openClusterBumn(),
                    bgColor: Color(0xFFFFE1E8),
                    bottomColor: Color(0xFFBC1A5E),
                    textColor: Colors.black,
                    total: summaryData.data.progressClusterTertinggi.toInt(),
                    totalText: "${clusterNames.length} Cluster",
                    percentage: false,
                    bottomText: "By Covid Cluster",
                  ),
                ),
              ],
            ),
            Expanded(
              child: summary(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'COSMIC',
      body: (ctx) => !isDataReady()
          ? isError
              ? CustomErrorWidget(
                  onRetry: () => getData(),
                )
              : LoadingWidget(
                  colorPalette: widget.colorPalette,
                )
          : menuList(context),
    );
  }
}
