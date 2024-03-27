// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_summary_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegalSummaryData _$LegalSummaryDataFromJson(Map<String, dynamic> json) {
  return LegalSummaryData(
    legalSummaryAll: json['summary_all'] == null
        ? null
        : LegalSummary.fromJson(json['summary_all'] as Map<String, dynamic>),
    summary_bumn: (json['summary_bumn'] as List)
        ?.map((e) => e == null
            ? null
            : LegalSummaryBumn.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    summary_jenis: json['summary_jenis'] == null
        ? null
        : LegalSummaryJenis.fromJson(
            json['summary_jenis'] as Map<String, dynamic>),
    summary_kota: (json['summary_kota'] as List)
        ?.map((e) => e == null
            ? null
            : LegalSummaryKota.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LegalSummaryDataToJson(LegalSummaryData instance) =>
    <String, dynamic>{
      'summary_all': instance.legalSummaryAll,
      'summary_jenis': instance.summary_jenis,
      'summary_bumn': instance.summary_bumn,
      'summary_kota': instance.summary_kota,
    };
