// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_dewan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikDewanResponse _$GrafikDewanResponseFromJson(Map<String, dynamic> json) {
  return GrafikDewanResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total data'] as int,
    proposedData: (json['proposed formation'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikDewanKomisarisProposed.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    realizationData: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikDewanKomisarisRealization.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}
