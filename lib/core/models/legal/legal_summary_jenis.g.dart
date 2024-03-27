// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_summary_jenis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegalSummaryJenis _$LegalSummaryJenisFromJson(Map<String, dynamic> json) {
  return LegalSummaryJenis(
    arbitrase: json['arbitrase'] as int,
    judicial_review: json['judicial_review'] as int,
    Perdata: json['Perdata'] as int,
  );
}

Map<String, dynamic> _$LegalSummaryJenisToJson(LegalSummaryJenis instance) =>
    <String, dynamic>{
      'arbitrase': instance.arbitrase,
      'judicial_review': instance.judicial_review,
      'Perdata': instance.Perdata,
    };
