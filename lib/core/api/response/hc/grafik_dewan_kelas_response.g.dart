// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_dewan_kelas_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikDewanKelasResponse _$GrafikDewanKelasResponseFromJson(
    Map<String, dynamic> json) {
  return GrafikDewanKelasResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    rightFormation: (json['right formation'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikDewanKomisarisKelas.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
