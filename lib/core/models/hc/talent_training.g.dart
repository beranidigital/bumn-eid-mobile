// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_training.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentTraining _$TalentTrainingFromJson(Map<String, dynamic> json) {
  return TalentTraining(
    idUser: json['i_user'] as int,
    bidang: json['n_bidang'] as String,
    idBidang: json['i_bidang'] as int,
    idTraining: json['i_pelatihan'] as int,
    organizer: json['e_instansi'] as String,
    tahun: json['i_tahun'] as String,
    address: json['e_alamat'] as String,
    lama: json['n_lama'] as String,
    namaPelatihan: json['n_pelatihan'] as String,
  );
}

Map<String, dynamic> _$TalentTrainingToJson(TalentTraining instance) =>
    <String, dynamic>{
      'i_user': instance.idUser,
      'i_pelatihan': instance.idTraining,
      'i_bidang': instance.idBidang,
      'e_instansi': instance.organizer,
      'e_alamat': instance.address,
      'i_tahun': instance.tahun,
      'n_lama': instance.lama,
      'n_bidang': instance.bidang,
      'n_pelatihan': instance.namaPelatihan,
    };
