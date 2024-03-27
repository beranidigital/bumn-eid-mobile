// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suspi_deni.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuspiDeni _$SuspiDeniFromJson(Map<String, dynamic> json) {
  return SuspiDeni(
    companyId: json['id_angka'] as String,
    namaPerusahaan: json['nama_lengkap'] as String,
    tahun: json['tahun'] as int,
    jenisAkun: json['jenis_akun'] as String,
    id: json['id'] as int,
    kodeKategori: json['kode_kategori'] as int,
    satuan: json['satuan'] as String,
    jumlah: json['jumlah'] as String,
  );
}
