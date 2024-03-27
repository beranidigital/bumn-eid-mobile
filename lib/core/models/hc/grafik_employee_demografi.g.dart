// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_employee_demografi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikEmployeeDemografi _$GrafikEmployeeDemografiFromJson(
    Map<String, dynamic> json) {
  return GrafikEmployeeDemografi(
    id: json['id_angka'] as String,
    namaLengkap: json['nama_lengkap'] as String,
    namaPendek: json['nama_pendek'] as String,
    tahun: json['tahun'] as int,
    totalPegawai: json['pegawai'] as int,
    pkwt: json['p_kontrak'] as int,
    pkwtt: json['p_tetap'] as int,
    pegawaiOrganik: json['p_organik'] as int,
    pegawaiTerampil: json['p_terampil'] as int,
  );
}
