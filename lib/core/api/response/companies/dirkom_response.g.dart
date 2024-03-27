// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dirkom_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirkomResponse _$DirkomResponseFromJson(Map<String, dynamic> json) {
  return DirkomResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Dirkom.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
