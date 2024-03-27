// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sektor_pk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SektorPk _$SektorPkFromJson(Map<String, dynamic> json) {
  return SektorPk(
    sektor: json['sektor_usaha'] as String,
    tahun: json['tahun'] as int,
    jumlah: json['jumlah'] as String,
  );
}

Map<String, dynamic> _$SektorPkToJson(SektorPk instance) => <String, dynamic>{
      'sektor_usaha': instance.sektor,
      'tahun': instance.tahun,
      'jumlah': instance.jumlah,
    };
