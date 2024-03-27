// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_suspi_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikSuspiResponse _$GrafikSuspiResponseFromJson(Map<String, dynamic> json) {
  return GrafikSuspiResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : GrafikSuspi.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
