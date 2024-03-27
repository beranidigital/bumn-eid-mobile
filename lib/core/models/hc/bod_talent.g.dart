// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bod_talent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BODTalent _$BODTalentFromJson(Map<String, dynamic> json) {
  return BODTalent(
    id: json['id'] as int,
    companyId: json['id_angka'] as String,
    companyName: json['nama_lengkap'] as String,
    kelasBumn: json['kelas_bumn'] as String,
    name: json['nama'] as String,
    group: json['group_asal'] as String,
    wamenBumn: json['wamen_bumn'] as String,
    clusterBumn: json['cluster_bumn'] as String,
    bidang: json['bidang'] as String,
    companyShortName: json['nama_pendek'] as String,
    fungsiDireksi: json['fungsi_direksi'] as int,
    pangkat: json['pangkat'] as String,
    topBumn: json['top_bumn'] as String,
  );
}
