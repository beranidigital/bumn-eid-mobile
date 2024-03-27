// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bod_talent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BODTalentResponse _$BODTalentResponseFromJson(Map<String, dynamic> json) {
  return BODTalentResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : BODTalent.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
