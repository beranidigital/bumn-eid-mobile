import 'package:bumn_eid/irwan_dev/hc/models/profil_pejabat_model.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/styles.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:flutter/material.dart';

import 'package:bumn_eid/irwan_dev/hc/api/list_api_hc.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/color_resources.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/background_stack.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/expansion_tile_2.dart';
import 'package:bumn_eid/irwan_dev/hc/views/widgets/header_pejabat.dart';

class ProfilPejabat extends StatelessWidget {
  final String idTalent;
  final String namaBumn;
  final String jabatanBumn;
  const ProfilPejabat({
    Key key,
    this.idTalent,
    this.namaBumn,
    this.jabatanBumn,
  }) : super(key: key);

  mainWidget(BuildContext context) {
    print("id ku ${idTalent}");
    return Container(
      child: Stack(
        children: [
          BackgroundStack(),
          Container(
            child: FutureBuilder<ProfilPejabatModel>(
              future: ListApiHC().getProfilPejabat(idTalent, context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var hasil = snapshot.data;
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    children: [
                      HeaderPejabat(
                        name:
                            "${hasil.biodata.nama_lengkap} ${hasil.biodata.gelar}",
                        posisi: "$jabatanBumn",
                        name_bumn: "$namaBumn",
                        url:
                            "https://png.pngtree.com/png-vector/20190710/ourlarge/pngtree-user-vector-avatar-png-image_1541962.jpg",
                      ),
                      SizedBox(height: 15),
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
                          "${hasil.biodata.nama_lengkap}",
                          "${hasil.biodata.gelar}",
                          (hasil.biodata.jenis_kelamin == "L")
                              ? "Laki-laki"
                              : "Perempuan",
                          "WNI",
                          "${hasil.biodata.tempat_lahir}, ${hasil.biodata.tanggal_lahir}",
                          "-",
                          "${hasil.biodata.gol_darah}",
                          "${hasil.biodata.suku}",
                          "${hasil.biodata.alamat}",
                          "${hasil.biodata.email}",
                          "${hasil.biodata.nomor_hp}",
                          "-",
                          "-",
                          "-",
                        ],
                      ),
                      ExpansionTile2(
                        title: "Pendidikan",
                        count: "Total Pendidikan : ${hasil.pendidikan.length}",
                        modeET2: ModeET2.mode2,
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
                                    listText("Jenjang - Penjurusan",
                                        "${hasil.pendidikan[index].nama}-${hasil.pendidikan[index].penjurusan}"),
                                    listText("Perguruan Tinggi",
                                        "${hasil.pendidikan[index].perguruan_tinggi}"),
                                    listText("Tahun Lulus",
                                        "${hasil.pendidikan[index].tahun}"),
                                    listText("Kota / Negara",
                                        "${hasil.pendidikan[index].kota} - ${hasil.pendidikan[index].negara}"),
                                    listText("Penghargaan yang Didapat",
                                        "${hasil.pendidikan[index].penghargaan}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ExpansionTile2(
                        title: "Pelatihan",
                        modeET2: ModeET2.mode2,
                        count: "Total Pelatihan : ${hasil.pelatihan.length}",
                        listView: ListView.builder(
                          shrinkWrap: true,
                          itemCount: hasil.pelatihan.length,
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
                                    listText(
                                        "Latihan dan Pengembangan Kompetensi",
                                        "${hasil.pelatihan[index].pengembangan_kompetensi}"),
                                    listText("Penyelenggara / Kota",
                                        "${hasil.pelatihan[index].penyelenggara} / ${hasil.pelatihan[index].kota}"),
                                    listText("Jenis Diklat",
                                        "${hasil.pelatihan[index].jenis_diklat}"),
                                    listText("Lama Diklat",
                                        "${hasil.pelatihan[index].lama_hari} Hari"),
                                    listText("Nomor Sertifikat",
                                        "${hasil.pelatihan[index].nomor_sertifikasi}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ExpansionTile2(
                        modeET2: ModeET2.mode2,
                        title: "Riwayat Jabatan",
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
                        title: "Riwayat Jabatan Lain",
                        modeET2: ModeET2.mode2,
                        count: "Total Riwayat : ${hasil.jabatanlain.length}",
                        listView: ListView.builder(
                          shrinkWrap: true,
                          itemCount: hasil.jabatanlain.length,
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
                                    listText("Jabatan",
                                        "${hasil.jabatanlain[index].penugasan} - ${hasil.jabatanlain[index].instansi}"),
                                    listText(
                                      "Uraian Singkat Tugas dan Wewenang",
                                      "${hasil.jabatanlain[index].tupoksi}",
                                    ),
                                    listText("Rentang Waktu",
                                        "${hasil.jabatanlain[index].tanggal_awal} - ${hasil.jabatanlain[index].tanggal_akhir}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ExpansionTile2(
                        title: "Keahlian dan Interest",
                        modeET2: ModeET2.mode3,
                        titleKeahlian: "Jenis Keahlian",
                        titleInterest: "Interest",
                        listView: ListView.builder(
                          shrinkWrap: true,
                          itemCount: hasil.keahlian.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Text(
                                "${index + 1}. ${hasil.keahlian[index].jenis_keahlian}");
                          },
                        ),
                        listView1: ListView.builder(
                          shrinkWrap: true,
                          itemCount: hasil.interest.length,
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
                                    listText("Ekonomi",
                                        "${hasil.interest[index].ekonomi}"),
                                    listText("Leadership",
                                        "${hasil.interest[index].leadership}"),
                                    listText("Sosial",
                                        "${hasil.interest[index].sosial}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ExpansionTile2(
                        title: "Organisasi Formal",
                        modeET2: ModeET2.mode2,
                        count:
                            "Total Organisasi : ${hasil.organisasiformal.length}",
                        listView: ListView.builder(
                          shrinkWrap: true,
                          itemCount: hasil.organisasiformal.length,
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
                                    listText("Nama Organisasi",
                                        "${hasil.organisasiformal[index].nama_organisasi}"),
                                    listText("Jabatan",
                                        "${hasil.organisasiformal[index].jabatan}"),
                                    listText("Rentang Waktu",
                                        "${hasil.organisasiformal[index].tanggal_awal} - ${hasil.organisasiformal[index].tanggal_akhir}"),
                                    listText("Kegiatan Organisasi",
                                        "${hasil.organisasiformal[index].kegiatan_organisasi}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ExpansionTile2(
                        title: "Organisasi Non-Formal",
                        modeET2: ModeET2.mode2,
                        count:
                            "Total Organisasi : ${hasil.organisasinonformal.length}",
                        listView: ListView.builder(
                          shrinkWrap: true,
                          itemCount: hasil.organisasinonformal.length,
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
                                    listText("Nama Organisasi",
                                        "${hasil.organisasinonformal[index].nama_organisasi}"),
                                    listText("Jabatan",
                                        "${hasil.organisasinonformal[index].jabatan}"),
                                    listText("Rentang Waktu",
                                        "${hasil.organisasinonformal[index].tanggal_awal} - ${hasil.organisasinonformal[index].tanggal_akhir}"),
                                    listText("Kegiatan Organisasi",
                                        "${hasil.organisasinonformal[index].kegiatan_organisasi}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ExpansionTile2(
                        title: "Penghargaan",
                        modeET2: ModeET2.mode2,
                        count:
                            "Total Penghargaan : ${hasil.penghargaan.length}",
                        listView: ListView.builder(
                          shrinkWrap: true,
                          itemCount: hasil.penghargaan.length,
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
                                    listText("Jenis Penghargaan",
                                        "${hasil.penghargaan[index].jenis_penghargaan}"),
                                    listText("Tingkat",
                                        "${hasil.penghargaan[index].tingkat}"),
                                    listText("Diberikan Oleh",
                                        "${hasil.penghargaan[index].pemberi_penghargaan}"),
                                    listText("Tahun",
                                        "${hasil.penghargaan[index].tahun}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ExpansionTile2(
                        title: "Karya Ilmiah",
                        modeET2: ModeET2.mode2,
                        count:
                            "Total Karya Ilmiah : ${hasil.karyailmiah.length}",
                        listView: ListView.builder(
                          shrinkWrap: true,
                          itemCount: hasil.karyailmiah.length,
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
                                    listText(
                                      "Judul",
                                      "${hasil.karyailmiah[index].judul}",
                                    ),
                                    listText(
                                      "Media Publikasi",
                                      "${hasil.karyailmiah[index].media_publikasi}",
                                    ),
                                    listText(
                                      "Tahun",
                                      "${hasil.karyailmiah[index].tahun}",
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ExpansionTile2(
                        title: "Pengalaman Lain",
                        modeET2: ModeET2.mode2,
                        count:
                            "Total Pengalaman Lain : ${hasil.pengalamanlain.length}",
                        listView: ListView.builder(
                          shrinkWrap: true,
                          itemCount: hasil.pengalamanlain.length,
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
                                    listText("Acara/Thema",
                                        "${hasil.pengalamanlain[index].acara}"),
                                    listText("Penyelenggara",
                                        "${hasil.pengalamanlain[index].penyelenggara}"),
                                    listText("Periode",
                                        "${hasil.pengalamanlain[index].periode}"),
                                    listText("Lokasi",
                                        "${hasil.pengalamanlain[index].lokasi}"),
                                    listText("Peserta",
                                        "${hasil.pengalamanlain[index].peserta}"),
                                  ],
                                ),
                              ),
                            );
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
                        title: "Keluarga",
                        modeET2: ModeET2.mode2,
                        count: "Total Keluarga : ${hasil.keluarga.length}",
                        listView: ListView.builder(
                          shrinkWrap: true,
                          itemCount: hasil.keluarga.length,
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
                                    listText("Nama",
                                        "${hasil.keluarga[index].nama}"),
                                    listText("Hubungan",
                                        "${hasil.keluarga[index].hubungan_keluarga}"),
                                    listText("Tempat, Tanggal Lahir",
                                        "${hasil.keluarga[index].tempat_lahir}, ${hasil.keluarga[index].tanggal_lahir}"),
                                    listText("Tanggal Menikah",
                                        "${hasil.keluarga[index].tanggal_menikah}"),
                                    listText("Pekerjaan",
                                        "${hasil.keluarga[index].pekerjaan}"),
                                    listText("Keterangan",
                                        "${hasil.keluarga[index].keterangan}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ExpansionTile2(
                        title: "Uraian Kompetensi dan Uraian Kepribadian",
                        modeET2: ModeET2.mode1,
                        titleSub: ["Kompetensi", "Kepribadian"],
                        isiSub: [
                          (hasil.summary.isEmpty || hasil.summary == null)
                              ? "-"
                              : "${hasil.summary[0].kompetensi}",
                          (hasil.summary.isEmpty || hasil.summary == null)
                              ? "-"
                              : "${hasil.summary[0].kepribadian}"
                        ],
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Profil Pejabat",
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
