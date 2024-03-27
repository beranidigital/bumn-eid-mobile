// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csr_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CsrItem _$CsrItemFromJson(Map<String, dynamic> json) {
  return CsrItem(
    companyId: json['id_angka'] as String,
    nama: json['nama_lengkap'] as String,
    tahun: json['tahun'] as int,
    kota: json['kota'] as String,
    periodeNama: json['periode_nama'] as String,
    bentukCsr: json['bentuk_csr'] as String,
    danaCsr: json['dana_csr'] as String,
    propinsi: json['propinsi'] as String,
    cluster: json['cluster_bumn'] as String,
    wamen: json['wamen_bumn'] as String,
    sektorId: json['sektor_id'] as String,
    sektorBumn: json['sektor_bumn'] as String,
    lat: json['lat'] as String,
    lng: json['lng'] as String,
  );
}

Map<String, dynamic> _$CsrItemToJson(CsrItem instance) => <String, dynamic>{
      'id_angka': instance.companyId,
      'nama_lengkap': instance.nama,
      'tahun': instance.tahun,
      'periode_nama': instance.periodeNama,
      'bentuk_csr': instance.bentukCsr,
      'dana_csr': instance.danaCsr,
      'kota': instance.kota,
      'propinsi': instance.propinsi,
      'cluster_bumn': instance.cluster,
      'wamen_bumn': instance.wamen,
      'sektor_id': instance.sektorId,
      'sektor_bumn': instance.sektorBumn,
      'lat': instance.lat,
      'lng': instance.lng,
    };
