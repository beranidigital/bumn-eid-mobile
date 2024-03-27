// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_pool_by_class_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentPoolByClassResponse _$TalentPoolByClassResponseFromJson(
    Map<String, dynamic> json) {
  return TalentPoolByClassResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TalentPoolByClass.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
