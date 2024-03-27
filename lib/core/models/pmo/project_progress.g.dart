// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectProgress _$ProjectProgressFromJson(Map<String, dynamic> json) {
  return ProjectProgress(
    id: json['id'] as int,
    idProject: json['id_projek'] as int,
    tanggal: json['tanggal'] as String,
    progress: json['progress_percent'] as String,
    description: json['uraian'] as String,
    status: json['status'] as String,
    statusCode: json['kode_status'] as String,
  );
}

Map<String, dynamic> _$ProjectProgressToJson(ProjectProgress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_projek': instance.idProject,
      'tanggal': instance.tanggal,
      'progress_percent': instance.progress,
      'uraian': instance.description,
      'status': instance.status,
      'kode_status': instance.statusCode,
    };
