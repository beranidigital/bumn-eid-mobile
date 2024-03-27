// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bod1_class_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BOD1ClassResponse _$BOD1ClassResponseFromJson(Map<String, dynamic> json) {
  return BOD1ClassResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    companies: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : BOD1Class.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
