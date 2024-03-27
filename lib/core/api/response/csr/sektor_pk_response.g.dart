// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sektor_pk_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SektorPkResponse _$SektorPkResponseFromJson(Map<String, dynamic> json) {
  return SektorPkResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : SektorPk.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
