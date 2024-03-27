// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'third_party_loan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThirdPartyLoan _$ThirdPartyLoanFromJson(Map<String, dynamic> json) {
  return ThirdPartyLoan(
    companyId: json['id_angka'] as String,
    namaPerusahaan: json['nama_lengkap'] as String,
    tahun: json['tahun'] as int,
    jumlah: json['jumlah'] as String,
    kelas: json['kelas_bumn'] as String,
    cluster: json['cluster_bumn'] as String,
    id: json['id'] as int,
    wamen: json['wamen_bumn'] as String,
    satuan: json['satuan'] as String,
  );
}
