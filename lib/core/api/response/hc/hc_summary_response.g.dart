// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hc_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HcSummaryResponse _$HcSummaryResponseFromJson(Map<String, dynamic> json) {
  return HcSummaryResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: json['data'] == null
        ? null
        : HcSummary.fromJson(json['data'] as Map<String, dynamic>),
  );
}
