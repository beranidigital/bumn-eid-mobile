// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cucu_perusahaan_deni_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CucuPerusahaanDeniResponse _$CucuPerusahaanDeniResponseFromJson(
    Map<String, dynamic> json) {
  return CucuPerusahaanDeniResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    companies: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : CucuPerusahaanDeni.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
