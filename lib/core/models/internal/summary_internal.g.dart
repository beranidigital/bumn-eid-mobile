// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_internal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryInternal _$SummaryInternalFromJson(Map<String, dynamic> json) {
  return SummaryInternal(
    summaryJumlahPegawai: json['summary_jumlah_pegawai'] == null
        ? null
        : SummaryJumlahPegawai.fromJson(
            json['summary_jumlah_pegawai'] as Map<String, dynamic>),
    summaryUsia: (json['summary_usia'] as List)
        ?.map((e) =>
            e == null ? null : SummaryUsia.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    summaryPendidikan: (json['summary_pendidikan'] as List)
        ?.map((e) =>
            e == null ? null : Pendidikan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    summaryAgama: (json['summary_agama'] as List)
        ?.map(
            (e) => e == null ? null : Agama.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    summaryStatusNikah: (json['summary_status_nikah'] as List)
        ?.map((e) =>
            e == null ? null : StatusNikah.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    summaryStatusPegawai: (json['summary_status_pegawai'] as List)
        ?.map((e) => e == null
            ? null
            : StatusPegawai.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    summaryJabatan: (json['summary_jabatan'] as List)
        ?.map((e) =>
            e == null ? null : Jabatan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    summaryUnitKerja: (json['summary_unit_kerja'] as List)
        ?.map((e) =>
            e == null ? null : UnitKerja.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    summaryPrefJabatan: (json['summary_pref_jabatan'] as List)
        ?.map((e) =>
            e == null ? null : PrefJabatan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SummaryInternalToJson(SummaryInternal instance) =>
    <String, dynamic>{
      'summary_jumlah_pegawai': instance.summaryJumlahPegawai,
      'summary_usia': instance.summaryUsia,
      'summary_pendidikan': instance.summaryPendidikan,
      'summary_agama': instance.summaryAgama,
      'summary_status_nikah': instance.summaryStatusNikah,
      'summary_status_pegawai': instance.summaryStatusPegawai,
      'summary_jabatan': instance.summaryJabatan,
      'summary_unit_kerja': instance.summaryUnitKerja,
      'summary_pref_jabatan': instance.summaryPrefJabatan,
    };
