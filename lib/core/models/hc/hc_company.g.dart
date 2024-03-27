// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hc_company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HcCompany _$HcCompanyFromJson(Map<String, dynamic> json) {
  return HcCompany(
    id: json['id_angka'] as String,
    nama: json['nama_lengkap'] as String,
    namaPendek: json['nama_pendek'] as String,
    jumlahDireksi: json['jumlah_direksi'] as int,
    jumlahKomisaris: json['jumlah_komisaris'] as int,
    cluster: json['cluster_bumn'] as String,
    kelas: json['kelas_bumn'] as String,
    wamen: json['wamen_bumn'] as String,
  );
}

Map<String, dynamic> _$HcCompanyToJson(HcCompany instance) => <String, dynamic>{
      'id_angka': instance.id,
      'nama_lengkap': instance.nama,
      'nama_pendek': instance.namaPendek,
      'jumlah_direksi': instance.jumlahDireksi,
      'jumlah_komisaris': instance.jumlahKomisaris,
      'cluster_bumn': instance.cluster,
      'kelas_bumn': instance.kelas,
      'wamen_bumn': instance.wamen,
    };
