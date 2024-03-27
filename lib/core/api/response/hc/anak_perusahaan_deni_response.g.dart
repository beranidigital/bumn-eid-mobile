// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anak_perusahaan_deni_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnakPerusahaanDeniResponse _$AnakPerusahaanDeniResponseFromJson(
    Map<String, dynamic> json) {
  return AnakPerusahaanDeniResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    companies: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AnakPerusahaanDeni.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
