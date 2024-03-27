// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jumlah_mitra_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JumlahMitraResponse _$JumlahMitraResponseFromJson(Map<String, dynamic> json) {
  return JumlahMitraResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : JumlahMitra.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
