// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegalResponse _$LegalResponseFromJson(Map<String, dynamic> json) {
  return LegalResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : LegalItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LegalResponseToJson(LegalResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
