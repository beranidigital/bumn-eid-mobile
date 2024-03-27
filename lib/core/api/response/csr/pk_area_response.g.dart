// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pk_area_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PkAreaResponse _$PkAreaResponseFromJson(Map<String, dynamic> json) {
  return PkAreaResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : PkItemArea.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
