// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_certification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentCertification _$TalentCertificationFromJson(Map<String, dynamic> json) {
  return TalentCertification(
    idUser: json['i_user'] as int,
    start: json['d_mulai'] as String,
    end: json['d_akhir'] as String,
    bidang: json['n_bidang'] as String,
    fax: json['e_fax'] as String,
    certificationName: json['n_sertifikasi'] as String,
    description: json['e_desc'] as String,
    idBidang: json['i_bidang'] as int,
    idCertification: json['i_sertifikasi'] as int,
    organizer: json['e_penyelenggara'] as String,
    phone: json['e_telp'] as String,
  );
}

Map<String, dynamic> _$TalentCertificationToJson(
        TalentCertification instance) =>
    <String, dynamic>{
      'i_user': instance.idUser,
      'i_sertifikasi': instance.idCertification,
      'n_sertifikasi': instance.certificationName,
      'i_bidang': instance.idBidang,
      'd_mulai': instance.start,
      'd_akhir': instance.end,
      'e_penyelenggara': instance.organizer,
      'e_telp': instance.phone,
      'e_fax': instance.fax,
      'e_desc': instance.description,
      'n_bidang': instance.bidang,
    };
