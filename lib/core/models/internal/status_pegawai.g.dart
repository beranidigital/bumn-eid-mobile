// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_pegawai.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusPegawai _$StatusPegawaiFromJson(Map<String, dynamic> json) {
  return StatusPegawai(
    statusPegawai: json['status_pegawai'] as String,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$StatusPegawaiToJson(StatusPegawai instance) =>
    <String, dynamic>{
      'status_pegawai': instance.statusPegawai,
      'total': instance.total,
    };
