import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/api/response/hc/bod_potret_talent_response.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/talent_detail.dart';
import 'package:bumn_eid/core/models/hc/talent_personal.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_expansion_tile.dart';
import 'package:bumn_eid/ui/components/last_update_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_potret_tugas_page/potret_talent_detail_page/di/potret_talent_detail_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_potret_tugas_page/potret_talent_detail_page/potret_talent_detail_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class PotretTalentDetailPage extends StatefulWidget with InjectableWidget {
  final PotretTalentDetailPageGraph _graph;

  final bool isBod;
  final int id;
  final bool now;
  final bool withCv;
  final bool fromItms;

  //injected
  ColorPalette colorPalette;
  //injected
  Store<AppState> store;
  //injected
  HcController hcController;
  //injected
  PotretTalentDetailActionMapper actionMapper;

  PotretTalentDetailPage(
      {@required this.id,
      @required this.now,
      this.isBod = true,
      this.withCv = false,
      this.fromItms = false,
      PotretTalentDetailPageGraph graph})
      : this._graph = graph ?? PotretTalentDetailPageGraph() {
    setup();
  }

  @override
  PotretTalentDetailPageGraph graph() => _graph;

  @override
  _PotretTalentDetailPageState createState() => _PotretTalentDetailPageState();
}

class _PotretTalentDetailPageState extends State<PotretTalentDetailPage>
    with AfterLayoutMixin<PotretTalentDetailPage> {
  bool isError = false;

  BODPotretTalentResponse data;

  TalentDetail getTalent() => data.data?.first;

  TalentPersonal getPersonalData() =>
      data.personalData.isEmpty ? null : data.personalData?.first;

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
      final data = await widget.hcController
          .fetchPotretTalentDetail(id: widget.id, now: widget.now);

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

  Widget userImage(BuildContext context) {
    return getPersonalData()?.photo == null
        ? circleUser(context)
        : Container(
            alignment: Alignment.center,
            height: 84.0,
            width: 84.0,
            child: CachedNetworkImage(
              imageUrl: getPersonalData()?.photo,
              placeholder: (context, _) => CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    widget.colorPalette.primary),
              ),
            ),
          );
  }

  Widget circleUser(BuildContext context) {
    final gender = getTalent()?.gender;
    final personalDataGender =
        getPersonalData()?.gender == "Perempuan" ? "P" : "L";
    final lastGender = gender ?? personalDataGender;
    return Container(
      height: 84.0,
      width: 84.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: lastGender == "L"
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
                getTalent().name ?? "-",
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
                getPersonalData()?.gender ?? "-",
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
                getTalent().birthDate ?? "-",
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
                  "Status Perkawinan",
                  style: titleStyle,
                ),
              ),
              Text(
                getPersonalData()?.statusPerkawinan ?? "-",
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
    );
  }

  Widget currentCareerInfo(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700);
    final itemStyle = TextStyle(
      fontSize: 16.0,
    );
    return Padding(
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
                Text(
                  "Periode",
                  style: titleStyle,
                ),
                Text(
                  getTalent().periode ?? "-",
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
                  getTalent().sk ?? "-",
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
                  getTalent().tanggalSk ?? "-",
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
                  getTalent().mulaiJabat ?? "-",
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
                  getTalent().akhirJabat ?? "-",
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
                  getTalent().instansiAsal ?? "-",
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
                  getTalent().tanggalSerahTerima ?? "-",
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
                  getTalent().keterangan ?? "-",
                  style: itemStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget familyInfo(BuildContext context) {
    return data.families.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.info,
              text: "Keluarga",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(data.families.length, (idx) {
                      final datum = data.families[idx];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Nama Keluarga: ${datum.namaKeluarga ?? "-"}",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text("Hubungan: ${datum.hubungan ?? "-"}"),
                            Text("Pekerjaan: ${datum.occupation ?? "-"}"),
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

  Widget pendidikanInfo(BuildContext context) {
    return data.pendidikan.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.info,
              text: "Pendidikan",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(data.pendidikan.length, (idx) {
                      final datum = data.pendidikan[idx];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Nama Instansi: ${datum.instansi ?? "-"}",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Alamat: ${datum.alamat ?? "-"}",
                            ),
                            Text("Jenjang: ${datum.degree ?? "-"}"),
                            Text("Jurusan: ${datum.jurusan ?? "-"}"),
                            Text("Tahun Mulai: ${datum.tahunMulai ?? "-"}"),
                            Text("Tahun Selesai: ${datum.tahunSelesai ?? "-"}"),
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

  Widget karirInfo(BuildContext context) {
    return data.karir.isEmpty
        ? Container()
        : Padding(
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
                    children: List.generate(data.karir.length, (idx) {
                      final datum = data.karir[idx];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Nama Instansi: ${datum.asalInstansi ?? "-"}",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Tahun Mulai: ${datum.mulaiJabat ?? "-"}",
                            ),
                            Text("Tahun Akhir: ${datum.akhirJabat ?? "-"}"),
                            Text("Periode: ${datum.periode ?? "-"}"),
                            Text("Status: ${datum.statusKepegawaian ?? "-"}"),
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

  Widget trainingInfo(BuildContext context) {
    return data.trainings.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.info,
              text: "Pelatihan",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(data.trainings.length, (idx) {
                      final datum = data.trainings[idx];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Nama Pelatihan: ${datum.namaPelatihan ?? "-"}",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text("Bidang: ${datum.bidang ?? "-"}"),
                            Text("Instansi: ${datum.organizer ?? "-"}"),
                            Text("Lama: ${datum.lama ?? "-"}"),
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

  Widget certificationInfo(BuildContext context) {
    return data.certifications.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.info,
              text: "Sertifikasi",
              children: <Widget>[
                Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(data.certifications.length, (idx) {
                      final datum = data.certifications[idx];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Nama Sertifikasi: ${datum.certificationName ?? "-"}",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text("Bidang: ${datum.bidang ?? "-"}"),
                            Text("Mulai: ${datum.start ?? "-"}"),
                            Text("Akhir: ${datum.end ?? "-"}"),
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

  Widget cvInfo(BuildContext context) {
    final url = getTalent().keterangan;
    return !widget.withCv
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomExpansionTile(
              colorPalette: widget.colorPalette,
              icon: Icons.info,
              text: "Uploaded CV",
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
                                  "Buka CV di Browser",
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
          talentInfo(context),
          currentCareerInfo(context),
          familyInfo(context),
          pendidikanInfo(context),
          karirInfo(context),
          trainingInfo(context),
          certificationInfo(context),
          cvInfo(context),
        ],
      ),
    );
  }

  Widget topWidget() {
    final bidang = getTalent().bidang ?? "-";
    final companyName = getTalent().companyName ?? "-";
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              bidang + ", " + companyName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.colorPalette.black,
                fontSize: 16.0,
              ),
            ),
            getTalent().klasifikasi == null
                ? Container()
                : Text(
                    getTalent().klasifikasi,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: widget.colorPalette.black,
                      fontSize: 16.0,
                    ),
                  )
          ],
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
        : ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              userImage(context),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Center(
                  child: Text(
                    getTalent().name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: widget.colorPalette.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              topWidget(),
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
      title: widget.isBod ? "BOD" : "Dewan Komisaris / Dewan Pengawas",
      body: (ctx) => mainWidget(context),
    );
  }
}
