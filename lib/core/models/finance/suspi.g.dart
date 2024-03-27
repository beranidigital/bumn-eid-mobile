// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suspi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Suspi _$SuspiFromJson(Map<String, dynamic> json) {
  return Suspi(
    companyId: json['id_angka'] as String,
    namaPerusahaan: json['nama_lengkap'] as String,
    tahun: json['tahun'] as int,
    cadanganTeknisAsuransi: json['cadangan_teknis_asuransi'] as int,
    kelas: json['kelas_bumn'] as String,
    cluster: json['cluster_bumn'] as String,
    id: json['id'] as int,
    wamen: json['wamen_bumn'] as String,
    satuan: json['satuan'] as String,
    danaPihakTiga: json['dana_pihak_tiga'] as int,
    liabilitasLain: json['liabilitas_lain'] as int,
    pinjaman: json['pinjaman'] as int,
    suratUtang: json['surat_utang'] as int,
    utangUsaha: json['utang_usaha'] as int,
  );
}
