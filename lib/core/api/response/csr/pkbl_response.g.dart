// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pkbl_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PkblResponse _$PkblResponseFromJson(Map<String, dynamic> json) {
  return PkblResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Pkbl.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
