// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bod1_talent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BOD1TalentResponse _$BOD1TalentResponseFromJson(Map<String, dynamic> json) {
  return BOD1TalentResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: json['data'] == null
        ? null
        : BOD1Talent.fromJson(json['data'] as Map<String, dynamic>),
    additionalData: (json['additional data'] as List)
        ?.map((e) => e == null
            ? null
            : TalentAdditionalData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
