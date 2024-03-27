// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_bod_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikBODResponse _$GrafikBODResponseFromJson(Map<String, dynamic> json) {
  return GrafikBODResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total data'] as int,
    realizationData: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikBODRealization.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
