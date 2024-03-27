// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_dewan_grouped_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikDewanGroupedResponse _$GrafikDewanGroupedResponseFromJson(
    Map<String, dynamic> json) {
  return GrafikDewanGroupedResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikDewanKomisarisGrouped.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
