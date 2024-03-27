// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegalSummary _$LegalSummaryFromJson(Map<String, dynamic> json) {
  return LegalSummary(
    melibatkan_bumn: json['melibatkan_bumn'] as int,
    tingkat_banding: json['tingkat_banding'] as int,
    tingkat_kasasi: json['tingkat_kasasi'] as int,
    tingkat_pertama: json['tingkat_pertama'] as int,
    tingkat_pk: json['tingkat_pk'] as int,
    total_perkara: json['total_perkara'] as int,
  );
}

Map<String, dynamic> _$LegalSummaryToJson(LegalSummary instance) =>
    <String, dynamic>{
      'total_perkara': instance.total_perkara,
      'tingkat_pertama': instance.tingkat_pertama,
      'tingkat_banding': instance.tingkat_banding,
      'tingkat_kasasi': instance.tingkat_kasasi,
      'tingkat_pk': instance.tingkat_pk,
      'melibatkan_bumn': instance.melibatkan_bumn,
    };
