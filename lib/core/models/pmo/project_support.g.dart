// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_support.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectSupport _$ProjectSupportFromJson(Map<String, dynamic> json) {
  return ProjectSupport(
    id: json['id'] as int,
    idProject: json['id_projek'] as int,
    support: json['dukungan'] as String,
    kendala: json['kendala'] as String,
    kategori: json['kategori'] as String,
    kodeKategori: json['kode_kategori'] as String,
  );
}

Map<String, dynamic> _$ProjectSupportToJson(ProjectSupport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_projek': instance.idProject,
      'dukungan': instance.support,
      'kendala': instance.kendala,
      'kategori': instance.kategori,
      'kode_kategori': instance.kodeKategori,
    };
