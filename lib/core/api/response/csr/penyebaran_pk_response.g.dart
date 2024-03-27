// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penyebaran_pk_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PenyebaranPkResponse _$PenyebaranPkResponseFromJson(Map<String, dynamic> json) {
  return PenyebaranPkResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : PkItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
