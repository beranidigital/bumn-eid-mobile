// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pinjaman_lain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PinjamanLain _$PinjamanLainFromJson(Map<String, dynamic> json) {
  return PinjamanLain(
    companyId: json['id_angka'] as String,
    namaPerusahaan: json['nama_lengkap'] as String,
    tahun: json['tahun'] as int,
    utangBank: json['utang_bank'] as int,
    kelas: json['kelas_bumn'] as String,
    cluster: json['cluster_bumn'] as String,
    utangRi: json['utang_ri'] as int,
    wamen: json['wamen_bumn'] as String,
    satuan: json['satuan'] as String,
    utangSp: json['utang_sp'] as int,
    pinjSubordinasi: json['pinj_subordinasi'] as int,
    jumlah: json['jumlah'] as int,
  );
}
