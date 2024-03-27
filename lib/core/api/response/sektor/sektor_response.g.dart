// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sektor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SektorResponse _$SektorResponseFromJson(Map<String, dynamic> json) {
  return SektorResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Sektor.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SektorResponseToJson(SektorResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
