import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/api/response/covid/covid_company_list_response.dart';
import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/covid/covid_company_list.dart';
import 'package:bumn_eid/core/models/covid/covid_summary_review_cluster.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_timeline.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_timeline_page/covid_cluster_timeline_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_timeline_page/di/covid_cluster_timeline_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class CovidClusterTimelinePage extends StatefulWidget with InjectableWidget {
  final CovidClusterTimelinePageGraph _graph;

  final String cluster;

  //injected
  ColorPalette colorPalette;
  //injected
  CovidController covidController;
  //injected
  HcController hcController;
  //injected
  CovidClusterTimelineActionMapper actionMapper;
  //injected
  Store<AppState> store;

  CovidClusterTimelinePage(
      {@required this.cluster, CovidClusterTimelinePageGraph graph})
      : this._graph = graph ?? CovidClusterTimelinePageGraph() {
    setup();
  }

  @override
  CovidClusterTimelinePageGraph graph() => _graph;

  @override
  _CovidClusterTimelinePageState createState() =>
      _CovidClusterTimelinePageState();
}

class _CovidClusterTimelinePageState extends State<CovidClusterTimelinePage>
    with AfterLayoutMixin<CovidClusterTimelinePage> {
  bool isError = false;

  List<CovidSummaryReviewCluster> reviews;
  List<CovidCompanyList> jenisPerusahaan = [];
  List<CovidCompanyList> filteredProfilPerusahaan = [];
  TextEditingController _searchController = TextEditingController();

  CovidSummaryReviewCluster selectedReview;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return jenisPerusahaan != null &&
        jenisPerusahaan.isNotEmpty &&
        reviews != null;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      CovidCompanyListResponse companies = await widget.covidController
          .fetchCompaniesByCluster(cluster: widget.cluster);

      setState(() {
        this.jenisPerusahaan = companies.data;
        this.reviews = companies.review;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget timelineWidget() {
    CovidSummaryReviewCluster timelineReview;

    try {
      timelineReview = reviews.firstWhere((covid) {
        return covid.keterangan == "timeline";
      });
    } catch (ex) {
      print(ex);
    }

    List<CovidSummaryReviewCluster> datas = reviews.toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Timeline Detail",
                style: TextStyle(
                    color: Color(0xFF264E6E),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: timelineReview.reviewFile == null ||
                        timelineReview.reviewFile.isEmpty
                    ? null
                    : () => launchUrl(timelineReview.reviewFile.first),
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.colorPalette.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.cloud_download,
                          size: 16.0,
                          color: widget.colorPalette.white,
                        ),
                      ),
                      Text(
                        "Download",
                        style: TextStyle(
                            color: widget.colorPalette.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Timeline:",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Hingga ${dateTimeToString(parseDateTime(timelineReview?.tanggalReview))}",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: SumTypeText(
                  colorPalette: widget.colorPalette,
                  sum: parseDouble(timelineReview?.pencapaian),
                  sumColor: timelineReview?.getColor(),
                  sumText: "Pencapaian",
                  percentage: true,
                ),
              ),
            ],
          ),
        ),
        selectedReview != null
            ? selectedWeeklyReview(selectedReview)
            : weeklyReview(datas)
      ],
    );
  }

  Widget selectedWeeklyReview(CovidSummaryReviewCluster data) {
    final date = parseDateTime(data.tanggalReview);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 16.0),
            child: Text(
              "Weekly Review:",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () => {
                      setState(() {
                        this.selectedReview = null;
                      })
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Review ${dateTimeToString(date)}",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: data.getColor(),
                          borderRadius: BorderRadius.circular(8.0)),
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Text(
                        "Pencapaian: ${data.pencapaian} %",
                        style: TextStyle(color: widget.colorPalette.white),
                      ),
                    ),
                  ]..addAll(List.generate(data.reviewFile.length, (idx) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () => launchUrl(data.reviewFile[idx]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.cloud_download,
                                  color: widget.colorPalette.primary,
                                ),
                              ),
                              Text(
                                (idx + 1).toString(),
                                style: TextStyle(
                                    color: widget.colorPalette.black,
                                    fontSize: 16.0),
                              )
                            ],
                          ),
                        ),
                      );
                    })),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget weeklyReview(List<CovidSummaryReviewCluster> datas) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 16.0),
            child: Text(
              "Weekly Review:",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
          ),
          CustomTimeline(
            children: List.generate(datas.length, (idx) {
              final date = parseDateTime(datas[idx].tanggalReview);
              return Container(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Review ${dateTimeToString(date)}",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: datas[idx].getColor(),
                                borderRadius: BorderRadius.circular(8.0)),
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            child: Text(
                              "Pencapaian: ${datas[idx].pencapaian} %",
                              style:
                                  TextStyle(color: widget.colorPalette.white),
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: GestureDetector(
                        onTap: datas[idx].reviewFile == null ||
                                datas[idx].reviewFile.isEmpty
                            ? null
                            : () => {
                                  setState(() {
                                    this.selectedReview = datas[idx];
                                  })
                                },
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.colorPalette.primary,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Text(
                            "Detail",
                            style: TextStyle(
                                color: widget.colorPalette.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
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
            child: ListView(padding: const EdgeInsets.all(16.0), children: [
              timelineWidget(),
            ]),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Review Timeline ${widget.cluster}",
      body: (ctx) => mainWidget(context),
    );
  }
}
