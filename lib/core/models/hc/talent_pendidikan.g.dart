// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_pendidikan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentPendidikan _$TalentPendidikanFromJson(Map<String, dynamic> json) {
  return TalentPendidikan(
    idUser: json['i_user'] as int,
    alamat: json['e_alamat'] as String,
    telepon: json['e_telp'] as String,
    degree: json['n_education'] as String,
    idPendidikan: json['i_pendidikan'] as int,
    instansi: json['n_pendidikan'] as String,
    jurusan: json['e_jurusan'] as String,
    kepalaInstansi: json['e_kepala'] as String,
    program: json['e_program'] as String,
    tahunMulai: json['i_mtahun'] as int,
    tahunSelesai: json['i_ltahun'] as int,
  );
}

Map<String, dynamic> _$TalentPendidikanToJson(TalentPendidikan instance) =>
    <String, dynamic>{
      'i_user': instance.idUser,
      'i_pendidikan': instance.idPendidikan,
      'n_education': instance.degree,
      'n_pendidikan': instance.instansi,
      'e_jurusan': instance.jurusan,
      'e_program': instance.program,
      'i_mtahun': instance.tahunMulai,
      'i_ltahun': instance.tahunSelesai,
      'e_alamat': instance.alamat,
      'e_telp': instance.telepon,
      'e_kepala': instance.kepalaInstansi,
    };
