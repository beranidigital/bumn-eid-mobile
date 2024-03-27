// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_karir.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentKarir _$TalentKarirFromJson(Map<String, dynamic> json) {
  return TalentKarir(
    idUser: json['i_user'] as int,
    mulaiJabat: json['d_mulaijabat'] as String,
    akhirJabat: json['d_akhirjabat'] as String,
    periode: json['i_periode'] as String,
    asalInstansi: json['asal_instansi'] as String,
    idJabatan: json['i_jabatan'] as int,
    idPangkat: json['i_pangkat'] as int,
    statusKepegawaian: json['status_kepegawaian'] as String,
  );
}

Map<String, dynamic> _$TalentKarirToJson(TalentKarir instance) =>
    <String, dynamic>{
      'i_user': instance.idUser,
      'i_jabatan': instance.idJabatan,
      'i_pangkat': instance.idPangkat,
      'asal_instansi': instance.asalInstansi,
      'd_mulaijabat': instance.mulaiJabat,
      'd_akhirjabat': instance.akhirJabat,
      'i_periode': instance.periode,
      'status_kepegawaian': instance.statusKepegawaian,
    };
