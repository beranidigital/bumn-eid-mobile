// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_potret_kerja_detailed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikPotretTugasDetailed _$GrafikPotretTugasDetailedFromJson(
    Map<String, dynamic> json) {
  return GrafikPotretTugasDetailed(
    id: json['id'] as int,
    nama: json['nama'] as String,
    namaPerusahaan: json['nama_lengkap'] as String,
    periode: json['periode'] as String,
    persentase: json['persentase'] as String,
    akhirJabat: json['akhir_jabat'] as String,
    sisaJabatanDays: json['sisa_in_days'] as int,
    fromItms: json['fromitms'] as bool,
  );
}
