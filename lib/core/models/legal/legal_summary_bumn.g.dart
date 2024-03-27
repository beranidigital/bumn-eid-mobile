// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_summary_bumn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegalSummaryBumn _$LegalSummaryBumnFromJson(Map<String, dynamic> json) {
  return LegalSummaryBumn(
    total_perkara: json['total_perkara'] as int,
    bumn: json['bumn'] as String,
    bumn_id: json['bumn_id'] as String,
  );
}

Map<String, dynamic> _$LegalSummaryBumnToJson(LegalSummaryBumn instance) =>
    <String, dynamic>{
      'bumn_id': instance.bumn_id,
      'bumn': instance.bumn,
      'total_perkara': instance.total_perkara,
    };
