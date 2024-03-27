// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return Employee(
    jenisKelamin: json['jenis_kelamin'] as String,
    id: json['id'] as int,
    createdAt: json['created_at'] as int,
    agama: json['agama'] as String,
    eselon1: json['eselon_1'] as String,
    eselon2: json['eselon_2'] as int,
    idEselon1: json['eselon_1_id'] as int,
    idEselon2: json['eselon_2_id'] as int,
    idPegawai: json['pegawai_id'] as String,
    jabatan: json['jabatan'] as String,
    nama: json['pegawai_nama'] as String,
    nip: json['nip'] as String,
    pendidikan: json['pendidikan'] as String,
    prefJabatan: json['pref_jabatan'] as String,
    statusNikah: json['status_nikah'] as String,
    statusPegawai: json['status_pegawai'] as String,
    statusWargaNegara: json['status_wn'] as String,
    tanggalLahir: json['tgl_lahir'] == null
        ? null
        : DateTime.parse(json['tgl_lahir'] as String),
    tempatLahir: json['tempat_lahir'] as String,
    updatedAt: json['updated_at'] as int,
  );
}

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'pegawai_id': instance.idPegawai,
      'nip': instance.nip,
      'pegawai_nama': instance.nama,
      'jenis_kelamin': instance.jenisKelamin,
      'tempat_lahir': instance.tempatLahir,
      'tgl_lahir': instance.tanggalLahir?.toIso8601String(),
      'agama': instance.agama,
      'status_nikah': instance.statusNikah,
      'status_wn': instance.statusWargaNegara,
      'status_pegawai': instance.statusPegawai,
      'jabatan': instance.jabatan,
      'pref_jabatan': instance.prefJabatan,
      'pendidikan': instance.pendidikan,
      'eselon_1_id': instance.idEselon1,
      'eselon_1': instance.eselon1,
      'eselon_2_id': instance.idEselon2,
      'eselon_2': instance.eselon2,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
