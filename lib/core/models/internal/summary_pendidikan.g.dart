// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_pendidikan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryPendidikan _$SummaryPendidikanFromJson(Map<String, dynamic> json) {
  return SummaryPendidikan(
    under30: json['under_30'] as int,
    between3039: json['between_30_39'] as int,
    between4049: json['between_40_49'] as int,
    above50: json['above_50'] as int,
  );
}

Map<String, dynamic> _$SummaryPendidikanToJson(SummaryPendidikan instance) =>
    <String, dynamic>{
      'under_30': instance.under30,
      'between_30_39': instance.between3039,
      'between_40_49': instance.between4049,
      'above_50': instance.above50,
    };
