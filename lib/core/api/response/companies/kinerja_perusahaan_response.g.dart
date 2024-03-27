// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kinerja_perusahaan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KinerjaPerusahaanResponse _$KinerjaPerusahaanResponseFromJson(
    Map<String, dynamic> json) {
  return KinerjaPerusahaanResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : KinerjaPerusahaan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
