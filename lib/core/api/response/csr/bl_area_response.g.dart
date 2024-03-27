// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bl_area_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlAreaResponse _$BlAreaResponseFromJson(Map<String, dynamic> json) {
  return BlAreaResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : BlItemArea.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
