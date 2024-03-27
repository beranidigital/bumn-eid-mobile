// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pref_jabatan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrefJabatan _$PrefJabatanFromJson(Map<String, dynamic> json) {
  return PrefJabatan(
    prefJabatan: json['pref_jabatan'] as String,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$PrefJabatanToJson(PrefJabatan instance) =>
    <String, dynamic>{
      'pref_jabatan': instance.prefJabatan,
      'total': instance.total,
    };
