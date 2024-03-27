// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laba_rugi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabaRugi _$LabaRugiFromJson(Map<String, dynamic> json) {
  return LabaRugi(
    id: json['id_angka'] as String,
    namaPerusahaan: json['nama_lengkap'] as String,
    tahun: json['tahun'] as String,
    jumlah: json['jumlah'] as String,
    periodeNama: json['periode_nama'] as String,
    satuan: json['satuan'] as String,
    jenisAkun: json['jenis_akun'] as String,
    jenisAkunId: json['jenis_akun_id'] as String,
  );
}
