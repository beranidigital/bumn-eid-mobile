// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anak_perusahaan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnakPerusahaan _$AnakPerusahaanFromJson(Map<String, dynamic> json) {
  return AnakPerusahaan(
    id: json['id_angka'] as String,
    induk: json['induk'] as String,
    anak: json['anak'] as String,
    persentase: json['persentase'] as String,
  );
}

Map<String, dynamic> _$AnakPerusahaanToJson(AnakPerusahaan instance) =>
    <String, dynamic>{
      'id_angka': instance.id,
      'induk': instance.induk,
      'anak': instance.anak,
      'persentase': instance.persentase,
    };
