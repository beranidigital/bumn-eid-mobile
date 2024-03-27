// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_prestasi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentPrestasi _$TalentPrestasiFromJson(Map<String, dynamic> json) {
  return TalentPrestasi(
    idUser: json['i_user'] as int,
    tahun: json['e_year'] as String,
    namaPrestasi: json['n_prestasi'] as String,
    organizer: json['e_penyelenggara'] as String,
    deskripsi: json['e_desc'] as String,
    bidang: json['n_bidang'] as String,
    lingkup: json['n_lingkup'] as String,
  );
}

Map<String, dynamic> _$TalentPrestasiToJson(TalentPrestasi instance) =>
    <String, dynamic>{
      'i_user': instance.idUser,
      'e_year': instance.tahun,
      'e_penyelenggara': instance.organizer,
      'n_prestasi': instance.namaPrestasi,
      'e_desc': instance.deskripsi,
      'n_bidang': instance.bidang,
      'n_lingkup': instance.lingkup,
    };
