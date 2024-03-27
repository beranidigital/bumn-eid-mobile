// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jenis_kelamin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JenisKelamin _$JenisKelaminFromJson(Map<String, dynamic> json) {
  return JenisKelamin(
    jenisKelamin: json['jenis_kelamin'] as String,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$JenisKelaminToJson(JenisKelamin instance) =>
    <String, dynamic>{
      'jenis_kelamin': instance.jenisKelamin,
      'total': instance.total,
    };
