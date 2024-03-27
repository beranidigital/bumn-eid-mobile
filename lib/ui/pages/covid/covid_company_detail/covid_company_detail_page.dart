import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/api/response/covid/covid_detail_response.dart';
import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/models/covid/covid_review.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/utils.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_expansion_tile.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/covid/covid_company_detail/covid_company_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_company_detail/di/covid_company_detail_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class CovidCompanyDetailPage extends StatefulWidget with InjectableWidget {
  final CovidCompanyDetailPageGraph _graph;

  final String id;

  //injected
  ColorPalette colorPalette;

  //injected
  Store<AppState> store;

  //injected
  CompaniesController companiesController;

  //injected
  CovidController covidController;

  //injected
  CovidCompanyDetailActionMapper actionMapper;

  CovidCompanyDetailPage({@required this.id, CovidCompanyDetailPageGraph graph})
      : this._graph = graph ?? CovidCompanyDetailPageGraph() {
    setup();
  }

  @override
  CovidCompanyDetailPageGraph graph() => _graph;

  @override
  _CovidCompanyDetailPageState createState() => _CovidCompanyDetailPageState();
}

class _CovidCompanyDetailPageState extends State<CovidCompanyDetailPage>
    with AfterLayoutMixin<CovidCompanyDetailPage> {
  bool isError = false;

  ProfilPerusahaan company;
  CovidDetailResponse data;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return company != null && data != null;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      final fetchedCompany =
          await widget.companiesController.fetchCompany(id: widget.id);
      final data =
          await widget.covidController.fetchCompanyById(companyId: widget.id);

      setState(() {
        this.company = fetchedCompany;
        this.data = data;
      });
    } catch (ex) {
      print(ex.toString());
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget trueFalseWidget({String title, bool value, String url}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: url == null ? null : () => launchUrl(url),
              child: Icon(
                value ? Icons.cloud_download : Icons.close,
                color: value
                    ? widget.colorPalette.primary
                    : widget.colorPalette.error,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget taskForce(BuildContext context) {
    return CustomExpansionTile(
      colorPalette: widget.colorPalette,
      text: "Task Force",
      trailingWidget: SumTypeText(
        sumText: "Skor",
        colorPalette: widget.colorPalette,
        sum: data.data.first.jumlahTaskforce,
        sumColor: Color(0xFF0D8B005),
        isCentered: true,
        percentage: true,
      ),
      children: <Widget>[
        Container(
          color: widget.colorPalette.white,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              trueFalseWidget(
                  title: "SK Penugasan",
                  value: data.data.first.isTaskForce == "sudah",
                  url: data.data.first.taskForce),
            ],
          ),
        )
      ],
    );
  }

  Widget protokol(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        text: "Protokol",
        trailingWidget: SumTypeText(
          sumText: "Skor",
          colorPalette: widget.colorPalette,
          sum: data.data.first.jumlahProtokol,
          sumColor: Color(0xFF0D8B005),
          isCentered: true,
          percentage: true,
        ),
        children: <Widget>[
          Container(
            color: widget.colorPalette.white,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                trueFalseWidget(
                    title: "SOP utk Karyawan",
                    value: data.data.first.isSopKaryawan == "sudah",
                    url: data.data.first.sopKaryawan),
                trueFalseWidget(
                    title: "SOP utk Pelanggan",
                    value: data.data.first.isSopPelanggan == "sudah",
                    url: data.data.first.sopPelanggan),
                trueFalseWidget(
                    title: "SOP utk Supplier",
                    value: data.data.first.isSopSupplier == "sudah",
                    url: data.data.first.sopSupplier),
                trueFalseWidget(
                    title: "SOP utk Mitra Usaha",
                    value: data.data.first.isSopMitra == "sudah",
                    url: data.data.first.sopMitra),
                trueFalseWidget(
                    title: "SOP utk Stakeholder Lainnya",
                    value: data.data.first.isSopStakeholder == "sudah",
                    url: data.data.first.sopStakeholder),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget sosialisasi(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        text: "Sosialisasi",
        trailingWidget: SumTypeText(
          sumText: "Skor",
          colorPalette: widget.colorPalette,
          sum: data.data.first.jumlahSosialisasi,
          sumColor: Color(0xFF0D8B005),
          isCentered: true,
          percentage: true,
        ),
        children: <Widget>[
          Container(
            color: widget.colorPalette.white,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                trueFalseWidget(
                    title: "Sosialisasi utk Karyawan",
                    value: data.data.first.isSosialisasi == "sudah",
                    url: data.data.first.sosialisasi),
                trueFalseWidget(
                    title: "Sosialisasi utk Pelanggan",
                    value: data.data.first.isSosialisasiplgn == "sudah",
                    url: data.data.first.sosialisasiplgn),
                trueFalseWidget(
                    title: "Sosialisasi utk Supplier",
                    value: data.data.first.isSosialisasiSupplier == "sudah",
                    url: data.data.first.sosialisasiSupplier),
                trueFalseWidget(
                    title: "Sosialisasi utk Mitra",
                    value: data.data.first.isSosialisasiMitra == "sudah",
                    url: data.data.first.sosialisasiMitra),
                trueFalseWidget(
                    title: "Sosialisasi utk Stakeholder Lainnya",
                    value: data.data.first.isSosialisasiStake == "sudah",
                    url: data.data.first.sosialisasiStake),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget statusChart() {
    final summaryData = data.review.firstWhere((covid) {
      return covid.keterangan == "timeline";
    });
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
                "${summaryData.total ?? "-"} Kasus Positif",
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
                        "${summaryData.dirawat ?? "-"}",
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
                        "${summaryData.meninggal ?? "-"}",
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
                        "${summaryData.sembuh ?? "-"}",
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

  Widget campaign(BuildContext context) {
    final url = data.review.first.campaign;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        icon: Icons.info,
        text: "Kampanye Positif",
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
                            "Buka Campaign di Browser",
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

  Widget reviewPeriodik(BuildContext context) {
    List<CovidReview> reviews = data.review.toList()
      ..removeWhere((covid) {
        return covid.keterangan != "weekly_review";
      });

    CovidReview timelineReview;

    try {
      timelineReview = data.review.firstWhere((covid) {
        return covid.keterangan == "timeline";
      });
    } catch (ex) {
      print(ex);
    }
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        icon: Icons.info,
        text: "Review Secara Periodik",
        children: <Widget>[
          Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  reviews.isEmpty
                      ? Text("Data tidak tersedia")
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 4,
                                        child: Text(
                                          "Timeline Hingga ${dateTimeToString(parseDateTime(timelineReview.tanggal))}",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: SumTypeText(
                                          headerTextSize: 12.0,
                                          colorPalette: widget.colorPalette,
                                          sum: parseDouble(
                                              timelineReview.pencapaian),
                                          sumColor: timelineReview.getColor(),
                                          sumText: "Pencapaian",
                                          percentage: true,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () => timelineReview
                                                      .reviewFile ==
                                                  null
                                              ? null
                                              : launchUrl(
                                                  timelineReview.reviewFile),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Icon(
                                              timelineReview.reviewFile == null
                                                  ? Icons.close
                                                  : Icons.cloud_download,
                                              color: timelineReview
                                                          .reviewFile ==
                                                      null
                                                  ? widget.colorPalette.error
                                                  : widget.colorPalette.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 1.0,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.black12,
                                ),
                              ],
                            )
                          ]..addAll(List.generate(reviews.length, (idx) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          flex: 4,
                                          child: Text(
                                            "Weekly Review ${dateTimeToString(parseDateTime(reviews[idx].tanggal))}",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: SumTypeText(
                                            headerTextSize: 12.0,
                                            colorPalette: widget.colorPalette,
                                            sum: parseDouble(
                                                reviews[idx].pencapaian),
                                            sumColor: reviews[idx].getColor(),
                                            sumText: "Pencapaian",
                                            percentage: true,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: GestureDetector(
                                            onTap: () => reviews[idx]
                                                        .reviewFile ==
                                                    null
                                                ? null
                                                : launchUrl(
                                                    reviews[idx].reviewFile),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Icon(
                                                reviews[idx].reviewFile == null
                                                    ? Icons.close
                                                    : Icons.cloud_download,
                                                color: reviews[idx]
                                                            .reviewFile ==
                                                        null
                                                    ? widget.colorPalette.error
                                                    : widget
                                                        .colorPalette.primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 1.0,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.black12,
                                  ),
                                ],
                              );
                            })),
                        )
                ],
              ))
        ],
      ),
    );
  }

  Widget readiness() {
    String review = "-";
    try {
      review = data.data.first.lastUpdate ?? "-";
    } catch (ex) {
      print(ex);
    }
    return Center(
      child: Container(
        width: 0.5 * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: getColorByJumlah(data.data.first.grandTotal),
            borderRadius: BorderRadius.circular(16.0)),
        margin: EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Center(
          child: Text(
            "Review $review: ${data.data.first.grandTotal}%",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
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
          readiness(),
          taskForce(context),
          protokol(context),
          sosialisasi(context),
          statusChart(),
          campaign(context),
          reviewPeriodik(context)
        ],
      ),
    );
  }

  Widget companyImage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 84.0,
      width: 84.0,
      child: CachedNetworkImage(
        imageUrl: company.logo,
        placeholder: (context, _) => CircularProgressIndicator(
          valueColor:
              new AlwaysStoppedAnimation<Color>(widget.colorPalette.primary),
        ),
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
                companyImage(context),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Text(
                      company.nama,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: widget.colorPalette.darkGrey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
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
      title: company == null ? "Profil BUMN" : company.namaPendek,
      body: (ctx) => mainWidget(context),
    );
  }
}
