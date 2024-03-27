// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bl_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlResponse _$BlResponseFromJson(Map<String, dynamic> json) {
  return BlResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : BlItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
