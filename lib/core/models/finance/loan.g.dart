// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loan _$LoanFromJson(Map<String, dynamic> json) {
  return Loan(
    companyId: json['id_angka'] as String,
    namaPerusahaan: json['nama_lengkap'] as String,
    tahun: json['tahun'] as int,
    efekLain: json['efeklain'] as String,
    kelas: json['kelas_bumn'] as String,
    cluster: json['cluster_bumn'] as String,
    id: json['id'] as int,
    wamen: json['wamen_bumn'] as String,
    satuan: json['satuan'] as String,
    sukuk: json['sukuk'] as String,
    obligasi: json['obligasi'] as String,
    ncd: json['ncd'] as String,
    mtn: json['mtn'] as String,
    jumlah: json['jumlah'] as String,
  );
}
