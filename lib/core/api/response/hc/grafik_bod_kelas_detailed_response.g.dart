// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_bod_kelas_detailed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikBODKelasDetailedResponse _$GrafikBODKelasDetailedResponseFromJson(
    Map<String, dynamic> json) {
  return GrafikBODKelasDetailedResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikBODKelasDetailed.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    proposedData: (json['proposed formation'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikBODKelasDetailedProposed.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}
