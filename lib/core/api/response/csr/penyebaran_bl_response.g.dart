// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penyebaran_bl_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PenyebaranBlResponse _$PenyebaranBlResponseFromJson(Map<String, dynamic> json) {
  return PenyebaranBlResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : BlItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
