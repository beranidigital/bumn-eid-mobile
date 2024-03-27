// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_potret_tugas_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikPotretTugasResponse _$GrafikPotretTugasResponseFromJson(
    Map<String, dynamic> json) {
  return GrafikPotretTugasResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikPotretTugas.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
