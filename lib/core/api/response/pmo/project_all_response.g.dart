// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_all_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectAllResponse _$ProjectAllResponseFromJson(Map<String, dynamic> json) {
  return ProjectAllResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ProjectItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
