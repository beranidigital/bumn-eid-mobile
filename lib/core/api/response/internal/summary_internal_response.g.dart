// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_internal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryInternalResponse _$SummaryInternalResponseFromJson(
    Map<String, dynamic> json) {
  return SummaryInternalResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: json['data'] == null
        ? null
        : SummaryInternal.fromJson(json['data'] as Map<String, dynamic>),
  );
}
