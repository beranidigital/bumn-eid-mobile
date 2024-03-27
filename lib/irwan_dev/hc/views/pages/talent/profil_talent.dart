import 'package:bumn_eid/irwan_dev/hc/models/profil_talent_pool.dart';
import 'package:bumn_eid/irwan_dev/resources/list_color.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/background_stack.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/expansion_tile_2.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/header_pejabat.dart';
import 'package:flutter_typeahead/cupertino_flutter_typeahead.dart';

class ProfilTalent extends StatelessWidget {
  String nik;
  ProfilTalent({
    Key key,
    this.nik,
  }) : super(key: key);

  List<dynamic> printData = ["1"];
  String stringNull = "-";

  mainWidget(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          BackgroundStack(),
          FutureBuilder<ProfileTalentPool>(
            future: ListApiHC().getDetailTalent(nik),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var hasil = snapshot.data;
                print(hasil.personal.nama);
                return ListView(
                  padding: EdgeInsets.all(12),
                  children: [
                    HeaderPejabat(
                      name: "${hasil.personal.nama} ${hasil.personal.gelar}",
                      posisi: "${hasil.personal.jabatan}",
                      name_bumn: "${hasil.biodata.busnm}",
                      url: "http://itms.bumn.go.id/${hasil.foto[0].path_foto}",
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: decorBackContainer,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Status Talent",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    (hasil.biodata.status == "ready")
                                        ? "res/images/ic_ready.png"
                                        : (hasil.biodata.status == "eligible")
                                            ? "res/images/ic_eligible.png"
                                            : (hasil.biodata.status ==
                                                    "nominated")
                                                ? "res/images/ic_nominated.png"
                                                : "res/images/ic_selected.png",
                                    scale: 1.1,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${hasil.biodata.status}",
                                    style: TextStyle(color: colorBlueCustom),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Kriteria",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${hasil.biodata.kriteria}",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    // ExpansionTile2(
                    //   title: "Catatan",
                    //   modeET2: ModeET2.mode1,
                    //   titleSub: ["Catatan", "Catatan Lainnya"],
                    //   isiSub: [
                    //     "${hasil.biodata.catatan}",
                    //     "${hasil.biodata.catatan_lain}"
                    //   ],
                    // ),
                    ExpansionTile2(
                      title: "Catatan",
                      modeET2: ModeET2.mode1,
                      titleSub: ["Kompetensi", "Interest"],
                      isiSub: [
                        (hasil.summary.isEmpty || hasil.summary == null)
                            ? "-"
                            : "${hasil.summary[0].SUMMARY}",
                        (hasil.summary.isEmpty || hasil.summary == null)
                            ? "-"
                            : "${hasil.summary[0].INTEREST}"
                      ],
                    ),
                    ExpansionTile2(
                      title: "Biodata",
                      modeET2: ModeET2.mode1,
                      titleSub: [
                        "Nama",
                        "Gelar Akademik",
                        "Jenis Kelamin",
                        "Kewarganegaraan",
                        "Tempat, Tanggal Lahir",
                        "Agama",
                        "Golongan Darah",
                        "Suku",
                        "Alamat",
                        "Email",
                        "No. HP",
                        "Jenis Instansi",
                        "Asal Instansi",
                        "Jabatan Asal Instansi"
                      ],
                      isiSub: [
                        "${hasil.personal.nama}",
                        "${hasil.personal.gelar}",
                        (hasil.personal.jk == "L") ? "Laki-laki" : "Perempuan",
                        "WNI",
                        "${hasil.personal.ttl}",
                        "${hasil.personal.agama}",
                        "-",
                        "-",
                        "${hasil.personal.alamat}",
                        "${hasil.personal.email}",
                        "${hasil.personal.hp}",
                        "-",
                        "-",
                        "-",
                      ],
                    ),
                    ExpansionTile2(
                      title: "Pendidikan",
                      modeET2: ModeET2.mode2,
                      count: "Total Pendidikan : ${hasil.pendidikan.length}",
                      listView: ListView.builder(
                        shrinkWrap: true,
                        itemCount: hasil.pendidikan.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 17),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  listText("Jenjang - Perusahaan",
                                      "${hasil.pendidikan[index].JENJANG}-${hasil.pendidikan[index].JURUSAN}"),
                                  listText("Perguruan Tinggi",
                                      "${hasil.pendidikan[index].INSTANSI}"),
                                  listText("Tahun Lulus",
                                      "${hasil.pendidikan[index].LULUS}"),
                                  listText("Kota / Negara",
                                      "${hasil.pendidikan[index].KOTANEGARA}"),
                                  listText("Penghargaan yang Didapat", "-"),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ExpansionTile2(
                      modeET2: ModeET2.mode2,
                      title: "Pelatihan",
                      count: "Total Pelatihan : 0",
                      listView: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    ),
                    ExpansionTile2(
                      modeET2: ModeET2.mode2,
                      title: "Riwayat Jabatan",
                      count: "Total Riwayat : ${hasil.riwayatjabatan.length}",
                      listView: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: hasil.riwayatjabatan.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 17),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  listText("Jabatan",
                                      "${hasil.riwayatjabatan[index].JABATAN} ${hasil.riwayatjabatan[index].PERUSAHAAN}"),
                                  listText("Uraian Singkat Tugas dan Wewenang",
                                      "${hasil.riwayatjabatan[index].URAIAN}"),
                                  listText("Rentang Waktu",
                                      "${hasil.riwayatjabatan[index].WAKTU}"),
                                  listText("Achievement", "-"),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ExpansionTile2(
                      modeET2: ModeET2.mode2,
                      title: "Masterpiece",
                      count: "Total Masterpiece : 0",
                      listView: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    ),
                    ExpansionTile2(
                      modeET2: ModeET2.mode2,
                      title: "Riwayat Jabatan Lain",
                      count: "Total Riwayat : 0",
                      listView: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    ),
                    ExpansionTile2(
                      modeET2: ModeET2.mode3,
                      title: "Keahlian dan Interest",
                      titleKeahlian: "Jenis Keahlian",
                      titleInterest: "Interest",
                      listView: Text("-"),
                      listView1: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: hasil.peminatan.length,
                        itemBuilder: (context, index) {
                          return Text(
                              "${index + 1}. ${hasil.peminatan[index].POSISI}");
                        },
                      ),
                    ),
                    ExpansionTile2(
                      modeET2: ModeET2.mode2,
                      title: "Organisasi Formal",
                      count: "Total Organisasi : 0",
                      listView: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    ),
                    ExpansionTile2(
                      modeET2: ModeET2.mode2,
                      title: "Organisasi Non Formal",
                      count: "Total Organisasi : 0",
                      listView: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    ),
                    ExpansionTile2(
                      modeET2: ModeET2.mode2,
                      title: "Penghargaan",
                      count: "Total Penghargaan : ${hasil.penghargaan.length}",
                      listView: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: hasil.penghargaan.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 17),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  listText("Jenis Penghargaan",
                                      "${hasil.penghargaan[index].JENIS_PENGHARGAAN}"),
                                  listText("Tingkat",
                                      "${hasil.penghargaan[index].TINGKAT}"),
                                  listText("Diberikan Oleh",
                                      "${hasil.penghargaan[index].DIBERIKAN}"),
                                  listText("Tahun",
                                      "${hasil.penghargaan[index].TAHUN}"),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ExpansionTile2(
                      modeET2: ModeET2.mode2,
                      title: "Karya Ilmiah",
                      count: "Total Karya : 0",
                      listView: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    ),
                    ExpansionTile2(
                      modeET2: ModeET2.mode2,
                      title: "Pengalaman Lain",
                      count: "Total Pengalaman Lain : 0",
                      listView: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    ),
                    ExpansionTile2(
                      modeET2: ModeET2.mode2,
                      title: "Referensi CV",
                      count: "Total Referensi CV : 0",
                      listView: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    ),
                    ExpansionTile2(
                      modeET2: ModeET2.mode2,
                      title: "Keluarga",
                      count: "Total Keluarga : 0",
                      listView: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    ),
                    // ExpansionTile2(
                    //   title: "Organisasi Formal",
                    //   modeET2: ModeET2.mode2,
                    //   count: "Total Organisasi : -",
                    //   // listData: printData,
                    //   titleSub: [
                    //     "Nama Organisasi",
                    //     "Jabatan",
                    //     "Rentang Waktu",
                    //     "Uraian Singkat"
                    //   ],
                    //   isiSub: ["-", "-", "-", "-"],
                    // ),
                    // ExpansionTile2(
                    //   title: "Organisasi Non-Formal",
                    //   modeET2: ModeET2.mode2,
                    //   count: "Total Organisasi : -",
                    //   // listData: printData,
                    //   titleSub: [
                    //     "Nama Organisasi",
                    //     "Jabatan",
                    //     "Rentang Waktu",
                    //     "Uraian Singkat"
                    //   ],
                    //   isiSub: ["-", "-", "-", "-"],
                    // ),
                    // ExpansionTile2(
                    //   title: "Penghargaan",
                    //   modeET2: ModeET2.mode2,
                    //   count:
                    //       "Total Penghargaan : ${(penghargaan.isEmpty) ? stringNull : penghargaan.length}",
                    //   // listData: penghargaan,
                    //   titleSub: [
                    //     "Jenis Penghargaan",
                    //     "Tingkat",
                    //     "Diberikan Oleh",
                    //     "Tahun"
                    //   ],
                    //   isiSub: (penghargaan.isEmpty)
                    //       ? ["-", "-", "-", "-"]
                    //       : [
                    //           "${penghargaan[0]['JENIS_PENGHARGAAN']}",
                    //           "${penghargaan[0]['TINGKAT']}",
                    //           "${penghargaan[0]['DIBERIKAN']}",
                    //           "${penghargaan[0]['TAHUN']}"
                    //         ],
                    // ),
                    // ExpansionTile2(
                    //   title: "Karya Ilmiah",
                    //   modeET2: ModeET2.mode2,
                    //   count: "Total Karya Tulis Ilmihan : -",
                    //   // listData: printData,
                    //   titleSub: ["Judul", "Media Publikasi", "Tahun"],
                    //   isiSub: ["-", "-", "-"],
                    // ),
                    // ExpansionTile2(
                    //   title: "Pengalaman Lain",
                    //   modeET2: ModeET2.mode2,
                    //   count: "Total Pengalaman Lain : -",
                    //   // listData: printData,
                    //   titleSub: [
                    //     "Acara/Thema",
                    //     "Penyelenggara",
                    //     "Periode",
                    //     "Lokasi",
                    //     "Peserta"
                    //   ],
                    //   isiSub: ["-", "-", "-", "-", "-"],
                    // ),
                    // ExpansionTile2(
                    //   title: "Referensi CV",
                    //   modeET2: ModeET2.mode2,
                    //   count: "Total Reverensi CV : -",
                    //   // listData: printData,
                    //   titleSub: ["Nama", "Perusahaan", "Jabatan", "Nomor HP."],
                    //   isiSub: ["-", "-", "-", "-"],
                    // ),
                    // ExpansionTile2(
                    //   title: "Keluarga",
                    //   modeET2: ModeET2.mode2,
                    //   count: "Total Keluarga : 3",
                    //   // listData: printData,
                    //   titleSub: [
                    //     "Nama",
                    //     "Hubungan",
                    //     "Tempat, Tanggal Lahir",
                    //     "Tanggal Menikah",
                    //     "Pekerjaan",
                    //     "Keterangan"
                    //   ],
                    //   isiSub: ["-", "-", "-", "-", "-", "-"],
                    // ),
                    // ExpansionTile2(
                    //   title: "Uraian Kompetensi dan Uraian Kepribadian",
                    //   modeET2: ModeET2.mode1,
                    //   titleSub: ["Kompetensi", "Kepribadian"],
                    //   isiSub: ["-", "-"],
                    // ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Profil Talent",
      body: (ctx) => mainWidget(ctx),
    );
  }
}

Widget listText(String title, String subtitle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: color_yellow_custom,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      Text(
        subtitle,
        style: TextStyle(
          fontFamily: 'Poppins',
        ),
      ),
      SizedBox(height: 17),
    ],
  );
}
