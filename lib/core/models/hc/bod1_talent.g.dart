// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bod1_talent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BOD1Talent _$BOD1TalentFromJson(Map<String, dynamic> json) {
  return BOD1Talent(
    penghargaan: (json['penghargaan'] as List)
        ?.map((e) => e == null
            ? null
            : BOD1TalentPenghargaan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    summary: (json['summary'] as List)
        ?.map((e) => e == null
            ? null
            : BOD1TalentSummary.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    jabatan: (json['riwayatjabatan'] as List)
        ?.map((e) => e == null
            ? null
            : BOD1TalentJabatan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pendidikan: (json['pendidikan'] as List)
        ?.map((e) => e == null
            ? null
            : BOD1TalentEducation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    assessmentDomestic: (json['assmkomp_domestic'] as List)
        ?.map((e) => e == null
            ? null
            : BOD1TalentAssessment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    assessmentGlobal: (json['assmkomp_global'] as List)
        ?.map((e) => e == null
            ? null
            : BOD1TalentAssessment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    kesehatan: (json['kes'] as List)
        ?.map((e) => e == null
            ? null
            : BOD1TalentKesehatan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    lhkpn: (json['lhkpn'] as List)
        ?.map((e) => e == null
            ? null
            : BOD1TalentLkhpn.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    peminatan: (json['peminatan'] as List)
        ?.map((e) => e == null
            ? null
            : BOD1TalentPeminatan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    performance: (json['perf'] as List)
        ?.map((e) => e == null
            ? null
            : BOD1TalentPerformance.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    personal: (json['personal'] as List)
        ?.map((e) => e == null
            ? null
            : BOD1TalentPersonal.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    tani: (json['tani'] as List)
        ?.map((e) => e == null
            ? null
            : BOD1TalentTani.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    track: (json['track'] as List)
        ?.map((e) => e == null
            ? null
            : BOD1TalentTrack.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    photos: (json['foto'] as List)
        ?.map((e) => e == null
            ? null
            : BOD1TalentPhoto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
