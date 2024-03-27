// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anggaran_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnggaranResponse _$AnggaranResponseFromJson(Map<String, dynamic> json) {
  return AnggaranResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    companies: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Anggaran.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
