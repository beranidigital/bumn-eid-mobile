// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_bahasa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentBahasa _$TalentBahasaFromJson(Map<String, dynamic> json) {
  return TalentBahasa(
    idUser: json['i_user'] as int,
    lisan: json['e_lisan'] as String,
    namaBahasa: json['n_bahasa'] as String,
    tulisan: json['e_tulisan'] as String,
  );
}

Map<String, dynamic> _$TalentBahasaToJson(TalentBahasa instance) =>
    <String, dynamic>{
      'i_user': instance.idUser,
      'e_lisan': instance.lisan,
      'e_tulisan': instance.tulisan,
      'n_bahasa': instance.namaBahasa,
    };
