// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_bod_kelas_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikBODKelasResponse _$GrafikBODKelasResponseFromJson(
    Map<String, dynamic> json) {
  return GrafikBODKelasResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    proposedData: (json['right formation'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikBODKelas.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
