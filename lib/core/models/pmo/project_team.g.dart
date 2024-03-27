// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectTeam _$ProjectTeamFromJson(Map<String, dynamic> json) {
  return ProjectTeam(
    id: json['id'] as int,
    idProject: json['id_projek'] as int,
    jenisTim: json['jenis_tim'] as String,
    namaJabatan: json['nama_jabatan'] as String,
    instansi: json['instansi'] as String,
    pic: json['pic'] as String,
  );
}

Map<String, dynamic> _$ProjectTeamToJson(ProjectTeam instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_projek': instance.idProject,
      'jenis_tim': instance.jenisTim,
      'nama_jabatan': instance.namaJabatan,
      'instansi': instance.instansi,
      'pic': instance.pic,
    };
