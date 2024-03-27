// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_potret_tugas_detailed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikPotretTugasDetailedResponse _$GrafikPotretTugasDetailedResponseFromJson(
    Map<String, dynamic> json) {
  return GrafikPotretTugasDetailedResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total_data'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikPotretTugasDetailed.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
