// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_dewan_kelas_detailed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikDewanKelasDetailedResponse _$GrafikDewanKelasDetailedResponseFromJson(
    Map<String, dynamic> json) {
  return GrafikDewanKelasDetailedResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikDewanKomisarisKelasDetailed.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
    proposedData: (json['proposed formation'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikDewanKomisarisKelasDetailedProposed.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}
