// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_company_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidCompanyList _$CovidCompanyListFromJson(Map<String, dynamic> json) {
  return CovidCompanyList(
    jumlah: json['jumlah'] as int,
    idAngka: json['id_angka'] as String,
    namaLengkap: json['nama_lengkap'] as String,
    bumn: json['bumn'] as String,
    lastReview: json['last_review'] as String,
  );
}

Map<String, dynamic> _$CovidCompanyListToJson(CovidCompanyList instance) =>
    <String, dynamic>{
      'nama_lengkap': instance.namaLengkap,
      'id_angka': instance.idAngka,
      'bumn': instance.bumn,
      'jumlah': instance.jumlah,
      'last_review': instance.lastReview,
    };
