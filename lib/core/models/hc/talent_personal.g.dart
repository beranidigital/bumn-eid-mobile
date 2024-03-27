// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_personal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentPersonal _$TalentPersonalFromJson(Map<String, dynamic> json) {
  return TalentPersonal(
    idUser: json['i_user'] as int,
    name: json['n_fname'] as String,
    telepon: json['e_telp'] as String,
    agama: json['n_agama'] as String,
    gelar: json['e_gelar'] as String,
    gender: json['n_gender'] as String,
    statusPerkawinan: json['n_married'] as String,
    tempatLahir: json['e_bplace'] as String,
    tanggalLahir: json['d_born'] as String,
    alamat: json['e_naddress'] as String,
    email: json['e_email'] as String,
    npwp: json['e_npwp'] as String,
    photo: json['foto_user'] as String,
  );
}

Map<String, dynamic> _$TalentPersonalToJson(TalentPersonal instance) =>
    <String, dynamic>{
      'i_user': instance.idUser,
      'n_fname': instance.name,
      'e_gelar': instance.gelar,
      'n_gender': instance.gender,
      'e_telp': instance.telepon,
      'n_agama': instance.agama,
      'n_married': instance.statusPerkawinan,
      'e_email': instance.email,
      'e_bplace': instance.tempatLahir,
      'd_born': instance.tanggalLahir,
      'e_npwp': instance.npwp,
      'e_naddress': instance.alamat,
      'foto_user': instance.photo,
    };
