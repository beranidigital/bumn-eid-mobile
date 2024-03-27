// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bod_potret_talent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BODPotretTalentResponse _$BODPotretTalentResponseFromJson(
    Map<String, dynamic> json) {
  return BODPotretTalentResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    personalData: (json['personal'] as List)
        ?.map((e) => e == null
            ? null
            : TalentPersonal.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pendidikan: (json['pendidikan'] as List)
        ?.map((e) => e == null
            ? null
            : TalentPendidikan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    bahasa: (json['bahasa'] as List)
        ?.map((e) =>
            e == null ? null : TalentBahasa.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    prestasi: (json['prestasi'] as List)
        ?.map((e) => e == null
            ? null
            : TalentPrestasi.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    families: (json['keluarga'] as List)
        ?.map((e) =>
            e == null ? null : TalentFamily.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    certifications: (json['sertifikasi'] as List)
        ?.map((e) => e == null
            ? null
            : TalentCertification.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : TalentDetail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    trainings: (json['pelatihan'] as List)
        ?.map((e) => e == null
            ? null
            : TalentTraining.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    karir: (json['karir'] as List)
        ?.map((e) =>
            e == null ? null : TalentKarir.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
