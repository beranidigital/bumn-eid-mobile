// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_kelas_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidKelasResponse _$CovidKelasResponseFromJson(Map<String, dynamic> json) {
  return CovidKelasResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : CovidKelas.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
