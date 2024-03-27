// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectItem _$ProjectItemFromJson(Map<String, dynamic> json) {
  return ProjectItem(
    id: json['id'] as int,
    kode: json['kode_projek'] as int,
    nama: json['nama_projek'] as String,
    pic: json['pic'] as String,
    progress: json['progress'] as String,
    keterangan: json['keterangan'] as String,
    tahun: json['tahun'] as int,
    bulan: json['id_bulan'] as int,
    bulanString: json['bulan'] as String,
  );
}

Map<String, dynamic> _$ProjectItemToJson(ProjectItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kode_projek': instance.kode,
      'nama_projek': instance.nama,
      'pic': instance.pic,
      'progress': instance.progress,
      'keterangan': instance.keterangan,
      'id_bulan': instance.bulan,
      'bulan': instance.bulanString,
      'tahun': instance.tahun,
    };
