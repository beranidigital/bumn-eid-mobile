// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suspi_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuspiResponse _$SuspiResponseFromJson(Map<String, dynamic> json) {
  return SuspiResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : SuspiDeni.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
