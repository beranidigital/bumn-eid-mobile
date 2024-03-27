import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/api/response/hc/bod1_talent_response.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_performance.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_personal.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_photo.dart';
import 'package:bumn_eid/core/models/hc/talent_additional_data.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_item.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_expansion_tile.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_detail_page/di/talent_pool_detail_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_detail_page/talent_pool_detail_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class TalentPoolDetailPage extends StatefulWidget with InjectableWidget {
  final TalentPoolDetailPageGraph _graph;

  final TalentPoolItem profile;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;
  //injected
  HcController hcController;
  //injected
  TalentPoolDetailActionMapper actionMapper;

  TalentPoolDetailPage(
      {@required this.profile, TalentPoolDetailPageGraph graph})
      : this._graph = graph ?? TalentPoolDetailPageGraph() {
    setup();
  }

  @override
  TalentPoolDetailPageGraph graph() => _graph;

  @override
  _TalentPoolDetailPageState createState() => _TalentPoolDetailPageState();
}

class _TalentPoolDetailPageState extends State<TalentPoolDetailPage>
    with AfterLayoutMixin<TalentPoolDetailPage> {
  bool isError = false;

  BOD1TalentResponse response;
  BOD1Talent data;

  TalentAdditionalData getAdditionalData() =>
      response.additionalData.isEmpty ? null : response.additionalData?.first;
  BOD1TalentPhoto getPhoto() => data.photos.isEmpty ? null : data.photos?.first;
  BOD1TalentPersonal getPersonalData() =>
      data.personal.isEmpty ? null : data.personal?.first;
  BOD1TalentPerformance getPerformanceData() =>
      data.performance.isEmpty ? null : data.performance?.first;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return data != null && response != null;
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      final data =
          await widget.hcController.fetchBOD1Talent(nik: widget.profile.nik);

      setState(() {
        this.data = data.data;
        this.response = data;
      });
    } catch (ex) {
      print(ex.toString());
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget userImage(BuildContext context) {
    return getPhoto() == null
        ? circleUser(context)
        : Container(
            alignment: Alignment.center,
            height: 84.0,
            width: 84.0,
            child: CachedNetworkImage(
              imageUrl: "http://itms.bumn.go.id/" + getPhoto().path,
              placeholder: (context, _) => CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    widget.colorPalette.primary),
              ),
            ),
          );
  }

  Widget circleUser(BuildContext context) {
    final gender = getPersonalData()?.gender;
    return Container(
      height: 84.0,
      width: 84.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: gender == "L"
          ? Icon(
              Icons.person,
              size: 50,
            )
          : Image(
              image: AssetImage("res/images/ic_woman.png"),
              fit: BoxFit.scaleDown,
              height: 50,
              width: 50,
            ),
    );
  }

  Widget feedbackInfo(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700);
    final itemStyle = TextStyle(
      fontSize: 16.0,
    );
    return CustomExpansionTile(
      colorPalette: widget.colorPalette,
      icon: Icons.info,
      text: "Feedback",
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
                "Status Talent",
                style: titleStyle,
              ),
              Text(
                getAdditionalData().status ?? "-",
                style: itemStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Feedback",
                  style: titleStyle,
                ),
              ),
              Text(
                getAdditionalData()?.feedback ?? "-",
                style: itemStyle,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget taniInfo(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700);
    final itemStyle = TextStyle(
      fontSize: 16.0,
    );
    final dataTani = data.tani;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        icon: Icons.info,
        text: "TANI",
        children: <Widget>[
          Container(
            color: Color(0xFFE7F0FF),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(dataTani.length, (idx) {
                final datum = dataTani[idx];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Annual Income: Rp. ${formatNumber(parseInt(datum.tani)) ?? "-"}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget talentPoolInfo(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700);
    final itemStyle = TextStyle(
      fontSize: 16.0,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CustomExpansionTile(
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
                  getPersonalData().nama ?? "-",
                  style: itemStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Jenis Kelamin",
                    style: titleStyle,
                  ),
                ),
                Text(
                  getPersonalData()?.gender == "L" ? "Laki-Laki" : "Perempuan",
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
                  getPersonalData().ttl ?? "-",
                  style: itemStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Agama",
                    style: titleStyle,
                  ),
                ),
                Text(
                  getPersonalData()?.agama ?? "-",
                  style: itemStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "No. Telepon",
                    style: titleStyle,
                  ),
                ),
                Text(
                  getPersonalData()?.hp ?? "-",
                  style: itemStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Email",
                    style: titleStyle,
                  ),
                ),
                Text(
                  getPersonalData()?.email ?? "-",
                  style: itemStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Alamat",
                    style: titleStyle,
                  ),
                ),
                Text(
                  getPersonalData()?.alamat ?? "-",
                  style: itemStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget educationInfo(BuildContext context) {
    final data = this.data.pendidikan;
    return data.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.school,
              text: "Pendidikan",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(data.length, (idx) {
                      final datum = data[idx];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Nama Instansi: ${datum.instansi ?? "-"}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Jenjang: ${datum.jenjang ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Jurusan: ${datum.jurusan ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Tahun Selesai: ${datum.tahunLulus ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
  }

  Widget jabatanInfo(BuildContext context) {
    final data = this.data.jabatan;
    return data.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.work,
              text: "Riwayat Jabatan",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(data.length, (idx) {
                      final datum = data[idx];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Nama Instansi: ${datum.perusahaan ?? "-"}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Jabatan: ${datum.jabatan ?? "-"}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Uraian: ${datum.uraian ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Tahun Mulai: ${datum.mulai ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Tahun Selesai: ${datum.akhir ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
  }

  Widget rewardInfo(BuildContext context) {
    final data = this.data.penghargaan;
    return data.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.info_outline,
              text: "Penghargaan",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(data.length, (idx) {
                      final datum = data[idx];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Jenis: ${datum.jenisPenghargaan ?? "-"}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Tingkat: ${datum.tingkat ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Tahun: ${datum.tahun ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
  }

  Widget trackRecordInfo(BuildContext context) {
    final data = this.data.track;
    return data.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.info_outline,
              text: "Track Record",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(data.length, (idx) {
                      final datum = data[idx];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Kriteria: ${datum.kriteria ?? "-"}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Keterangan: ${datum.value ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
  }

  Widget kekayaanInfo(BuildContext context) {
    final data = this.data.lhkpn;
    return data.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.attach_money,
              text: "Info Kekayaan",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(data.length, (idx) {
                      final datum = data[idx];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Tanggal Pelaporan: ${datum.tanggalPelaporan ?? "-"}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Jumlah IDR: ${formatNumber(parseInt(datum.jumlahKekayaanRp)) ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Jumlah USD: ${formatNumber(parseInt(datum.jumlahKekayaanUsd)) ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
  }

  Widget kesehatanInfo(BuildContext context) {
    final data = this.data.kesehatan;
    return data.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.local_hospital,
              text: "Riwayat Kesehatan",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(data.length, (idx) {
                      final datum = data[idx];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Tahun: ${datum.tahun ?? "-"}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Nilai Kesehatan: ${datum.nilai ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Instansi: ${datum.instansi ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
  }

  Widget summaryInfo(BuildContext context) {
    final data = this.data.summary;
    final titleStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700);
    return data.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.info,
              text: "Summary",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(data.length, (idx) {
                      final datum = data[idx];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Summary",
                                style: titleStyle,
                              ),
                            ),
                            datum.summary == null
                                ? Container()
                                : Html(
                                    data: cleanseString(datum.summary),
                                    defaultTextStyle: TextStyle(fontSize: 18.0),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Interest",
                                style: titleStyle,
                              ),
                            ),
                            datum.interest == null
                                ? Container()
                                : Html(
                                    data: cleanseString(datum.interest),
                                    defaultTextStyle: TextStyle(fontSize: 18.0),
                                  ),
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
  }

  Widget assessmentDomesticInfo(BuildContext context) {
    final data = this.data.assessmentDomestic;
    return data.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.local_hospital,
              text: "Assessment Domestic",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(data.length, (idx) {
                      final datum = data[idx];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Kompetensi: ${datum.kompetensi ?? "-"}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Nilai: ${datum.nilai ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
  }

  Widget assessmentGlobalInfo(BuildContext context) {
    final data = this.data.assessmentGlobal;
    return data.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.local_hospital,
              text: "Assessment Global",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(data.length, (idx) {
                      final datum = data[idx];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Kompetensi: ${datum.kompetensi ?? "-"}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Nilai: ${datum.nilai ?? "-"}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
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
          feedbackInfo(context),
          taniInfo(context),
          talentPoolInfo(context),
          educationInfo(context),
          jabatanInfo(context),
          summaryInfo(context),
          kesehatanInfo(context),
          rewardInfo(context),
          trackRecordInfo(context),
          kekayaanInfo(context),
          assessmentDomesticInfo(context),
          assessmentGlobalInfo(context),
        ],
      ),
    );
  }

  Widget topWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Center(
          child: userImage(context),
        ),
        Center(
          child: Text(
            widget.profile.nama,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: widget.colorPalette.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        Center(
          child: Text(
            widget.profile.nik ?? "-",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.colorPalette.black,
              fontSize: 16.0,
            ),
          ),
        ),
        Center(
          child: Text(
            widget.profile.jabatan ?? "-",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.colorPalette.black,
              fontSize: 16.0,
            ),
          ),
        ),
        Center(
          child: Text(
            widget.profile.namaPerusahaan ?? "-",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.colorPalette.black,
              fontSize: 16.0,
            ),
          ),
        )
      ],
    );
  }

  Widget scoreCard({
    @required String title,
    @required String nilai,
    @required String keterangan,
  }) {
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, offset: Offset(2.0, 2.0)),
                    BoxShadow(color: Colors.black26, offset: Offset(-2.0, 2.0)),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        nilai,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: widget.colorPalette.primary),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1.0,
                    color: Colors.black26,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Center(
                      child: Text(
                        keterangan,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget scoreList() {
    String domestic = "-";
    String global = "-";
    try {
      if (data?.assessmentDomestic != null &&
          data.assessmentDomestic.isNotEmpty) {
        domestic = (data.assessmentDomestic.fold(0, (a, b) => a + b.nilai) /
                data.assessmentDomestic.length)
            .toString();
      }
      if (data?.assessmentGlobal != null && data.assessmentGlobal.isNotEmpty) {
        global = (data.assessmentGlobal.fold(0, (a, b) => a + b.nilai) /
                data.assessmentGlobal.length)
            .toString();
      }
    } catch (ex) {
      ex.toString();
    }

    String perf;
    try {
      perf = data?.performance?.first?.nilai;
    } catch (ex) {
      perf = "-";
    }
    return Container(
      height: 150,
      child: Row(
        children: <Widget>[
          Expanded(
            child: scoreCard(
                title: "Performance", nilai: perf ?? "-", keterangan: ""),
          ),
          Expanded(
            child: scoreCard(
                title: "Domestic", keterangan: "-", nilai: domestic ?? "-"),
          ),
          Expanded(
            child: scoreCard(
                title: "Global", nilai: global ?? "-", keterangan: ""),
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
                customText: "Data tidak tersedia di ITMS",
              )
            : LoadingWidget(
                colorPalette: widget.colorPalette,
              )
        : Container(
            color: Color(0xFFEEEFF3),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: topWidget(context),
                ),
                scoreList(),
                detailsList(context),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: LastUpdateWidget(
                    store: StoreProvider.of<AppState>(context),
                    pageName: "hc",
                  ),
                )
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Talent Pool Detail",
      body: (ctx) => mainWidget(context),
    );
  }
}
