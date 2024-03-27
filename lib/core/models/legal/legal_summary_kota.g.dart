// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_summary_kota.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegalSummaryKota _$LegalSummaryKotaFromJson(Map<String, dynamic> json) {
  return LegalSummaryKota(
    total_kasus: json['total_kasus'] as int,
    kota: json['kota'] as String,
    tahun: json['tahun'] as int,
  );
}

Map<String, dynamic> _$LegalSummaryKotaToJson(LegalSummaryKota instance) =>
    <String, dynamic>{
      'tahun': instance.tahun,
      'kota': instance.kota,
      'total_kasus': instance.total_kasus,
    };
