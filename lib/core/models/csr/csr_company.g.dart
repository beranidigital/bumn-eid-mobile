// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csr_company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CsrCompany _$CsrCompanyFromJson(Map<String, dynamic> json) {
  return CsrCompany(
    id: json['id_angka'] as String,
    nama: json['nama_lengkap'] as String,
    namaPendek: json['nama_pendek'] as String,
  );
}

Map<String, dynamic> _$CsrCompanyToJson(CsrCompany instance) =>
    <String, dynamic>{
      'id_angka': instance.id,
      'nama_lengkap': instance.nama,
      'nama_pendek': instance.namaPendek,
    };
