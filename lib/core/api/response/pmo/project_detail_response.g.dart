// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectDetailResponse _$ProjectDetailResponseFromJson(
    Map<String, dynamic> json) {
  return ProjectDetailResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    project: (json['project'] as List)
        ?.map((e) =>
            e == null ? null : ProjectItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    progress: (json['progress'] as List)
        ?.map((e) => e == null
            ? null
            : ProjectProgress.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    milestone: (json['milestone'] as List)
        ?.map((e) => e == null
            ? null
            : ProjectMilestone.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    support: (json['supports'] as List)
        ?.map((e) => e == null
            ? null
            : ProjectSupport.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    team: (json['team'] as List)
        ?.map((e) =>
            e == null ? null : ProjectTeam.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
