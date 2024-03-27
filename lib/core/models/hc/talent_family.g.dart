// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_family.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentFamily _$TalentFamilyFromJson(Map<String, dynamic> json) {
  return TalentFamily(
    education: json['e_education'] as String,
    hubungan: json['n_family'] as String,
    idFamily: json['i_family'] as int,
    idKeluarga: json['i_keluarga'] as int,
    idUser: json['i_user'] as int,
    namaKeluarga: json['n_keluarga'] as String,
    occupation: json['e_pekerjaan'] as String,
    tanggalLahir: json['d_born'] as String,
    tempatLahir: json['e_bplace'] as String,
  );
}

Map<String, dynamic> _$TalentFamilyToJson(TalentFamily instance) =>
    <String, dynamic>{
      'i_user': instance.idUser,
      'i_keluarga': instance.idKeluarga,
      'i_family': instance.idFamily,
      'n_keluarga': instance.namaKeluarga,
      'e_bplace': instance.tempatLahir,
      'd_born': instance.tanggalLahir,
      'e_education': instance.education,
      'e_pekerjaan': instance.occupation,
      'n_family': instance.hubungan,
    };
