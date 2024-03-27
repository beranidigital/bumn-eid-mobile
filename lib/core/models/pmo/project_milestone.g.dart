// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_milestone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectMilestone _$ProjectMilestoneFromJson(Map<String, dynamic> json) {
  return ProjectMilestone(
    id: json['id'] as int,
    idProject: json['id_projek'] as int,
    bulan: json['bulan'] as String,
    tahun: json['tahun'] as String,
    description: json['uraian'] as String,
  );
}

Map<String, dynamic> _$ProjectMilestoneToJson(ProjectMilestone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_projek': instance.idProject,
      'bulan': instance.bulan,
      'tahun': instance.tahun,
      'uraian': instance.description,
    };
