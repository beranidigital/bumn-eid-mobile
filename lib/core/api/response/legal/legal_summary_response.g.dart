// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegalSummaryResponse _$LegalSummaryResponseFromJson(Map<String, dynamic> json) {
  return LegalSummaryResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: json['data'] == null
        ? null
        : LegalSummaryData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LegalSummaryResponseToJson(
        LegalSummaryResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
