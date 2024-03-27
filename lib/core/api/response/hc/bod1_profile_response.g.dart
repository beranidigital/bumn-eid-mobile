// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bod1_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BOD1ProfileResponse _$BOD1ProfileResponseFromJson(Map<String, dynamic> json) {
  return BOD1ProfileResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : BOD1Profile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
