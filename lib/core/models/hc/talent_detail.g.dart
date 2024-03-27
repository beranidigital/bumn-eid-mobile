// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentDetail _$TalentDetailFromJson(Map<String, dynamic> json) {
  return TalentDetail(
    id: json['id'] as int,
    companyId: json['id_angka'] as String,
    companyName: json['nama_lengkap'] as String,
    kelasBumn: json['kelas_bumn'] as String,
    name: json['nama'] as String,
    group: json['group_asal'] as String,
    asdep: json['asdep'] as String,
    klasifikasi: json['klasifikasi_asal_instansi_dekom'] as String,
    wamenBumn: json['wamen_bumn'] as String,
    clusterBumn: json['cluster_bumn'] as String,
    bidang: json['bidang'] as String,
    companyShortName: json['nama_pendek'] as String,
    fungsiDireksi: json['fungsi_direksi'] as int,
    pangkat: json['pangkat'] as String,
    topBumn: json['top_bumn'] as String,
    akhirJabat: json['akhir_jabat'] as String,
    keterangan: json['keterangan'] as String,
    birthDate: json['tgl_lahir'] as String,
    instansiAsal: json['instansi_asal'] as String,
    mulaiJabat: json['mulai_jabat'] as String,
    periode: json['periode'] as String,
    sisaMasaJabatan: json['sisa_masa_jabatan'] as String,
    sk: json['sk'] as String,
    skAkhir: json['sk_akhir'] as String,
    skHenti: json['sk_henti'] as String,
    tanggalAkhirRups: json['tanggal_akhir_rups'] as String,
    tanggalSerahTerima: json['tgl_serah_terima'] as String,
    tanggalSk: json['tanggal_sk'] as String,
    gender: json['jenis_kelamin'] as String,
    kelompokUsia: json['kelompok_usia'] as String,
    klasifikasiGroupAsal: json['klasifikasi_group_asal'] as String,
    skalaJabatan: json['skala_jabatan_bumn'] as String,
    statusBumn: json['status_bumn'] as String,
    usia: json['usia'] as int,
    kategoriPangkat: json['kategori_pangkat'] as String,
  );
}
