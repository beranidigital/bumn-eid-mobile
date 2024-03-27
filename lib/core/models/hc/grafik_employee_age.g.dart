// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_employee_age.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikEmployeeAge _$GrafikEmployeeAgeFromJson(Map<String, dynamic> json) {
  return GrafikEmployeeAge(
    id: json['id_angka'] as String,
    namaLengkap: json['nama_lengkap'] as String,
    namaPendek: json['nama_pendek'] as String,
    tahun: json['tahun'] as int,
    diatas56: json['n_umur_a'] as int,
    antara4556: json['n_umur_b'] as int,
    antara3645: json['n_umur_c'] as int,
    antara2635: json['n_umur_d'] as int,
    dibawah25: json['n_umur_e'] as int,
  );
}
