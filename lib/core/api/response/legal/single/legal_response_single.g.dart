// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_response_single.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegalResponseSingle _$LegalResponseSingleFromJson(Map<String, dynamic> json) {
  return LegalResponseSingle(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: json['data'] == null
        ? null
        : LegalItem.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LegalResponseSingleToJson(
        LegalResponseSingle instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
