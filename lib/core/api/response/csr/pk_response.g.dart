// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pk_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PkResponse _$PkResponseFromJson(Map<String, dynamic> json) {
  return PkResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : PkItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
