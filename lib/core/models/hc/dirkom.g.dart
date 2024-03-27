// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dirkom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dirkom _$DirkomFromJson(Map<String, dynamic> json) {
  return Dirkom(
    id: json['id_angka'] as String,
    nama: json['nama_pejabat'] as String,
    jabatan: json['jabatan'] as String,
    skJabat: json['sk_jabat'] as String,
    mulaiJabat: json['tgl_mulaijabat'] == null
        ? null
        : DateTime.parse(json['tgl_mulaijabat'] as String),
    akhirJabat: json['tgl_akhirjabat'] == null
        ? null
        : DateTime.parse(json['tgl_akhirjabat'] as String),
    type: json['dirkom'] as String,
  );
}

Map<String, dynamic> _$DirkomToJson(Dirkom instance) => <String, dynamic>{
      'id_angka': instance.id,
      'nama_pejabat': instance.nama,
      'jabatan': instance.jabatan,
      'sk_jabat': instance.skJabat,
      'tgl_mulaijabat': instance.mulaiJabat?.toIso8601String(),
      'tgl_akhirjabat': instance.akhirJabat?.toIso8601String(),
      'dirkom': instance.type,
    };
