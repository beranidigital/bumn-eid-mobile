// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dekom_detailed_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DekomDetailedItem _$DekomDetailedItemFromJson(Map<String, dynamic> json) {
  return DekomDetailedItem(
    id: json['id'] as int,
    nama: json['nama'] as String,
    persentase: json['persentase'] as String,
    akhirJabat: json['akhir_jabat'] as String,
    mulaiJabat: json['mulai_jabat'] as String,
    companyName: json['nama_lengkap'] as String,
    klasifikasi: json['klasifikasi_asal_instansi_dekom'] as String,
    sisaWaktu: json['sisa_in_days'] as int,
    periode: json['periode'] as String,
  );
}

Map<String, dynamic> _$DekomDetailedItemToJson(DekomDetailedItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'nama_lengkap': instance.companyName,
      'mulai_jabat': instance.mulaiJabat,
      'akhir_jabat': instance.akhirJabat,
      'persentase': instance.persentase,
      'periode': instance.periode,
      'klasifikasi_asal_instansi_dekom': instance.klasifikasi,
      'sisa_in_days': instance.sisaWaktu,
    };
