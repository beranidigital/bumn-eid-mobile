import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dekom_detailed_item.g.dart';

@JsonSerializable()
class DekomDetailedItem extends ResponseObject {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'nama')
  final String nama;

  @JsonKey(name: 'nama_lengkap')
  final String companyName;

  @JsonKey(name: 'mulai_jabat')
  final String mulaiJabat;

  @JsonKey(name: 'akhir_jabat')
  final String akhirJabat;

  @JsonKey(name: 'persentase')
  final String persentase;

  @JsonKey(name: 'periode')
  final String periode;

  @JsonKey(name: 'klasifikasi_asal_instansi_dekom')
  final String klasifikasi;

  @JsonKey(name: 'sisa_in_days')
  final int sisaWaktu;

  DekomDetailedItem({
    this.id,
    this.nama,
    this.persentase,
    this.akhirJabat,
    this.mulaiJabat,
    this.companyName,
    this.klasifikasi,
    this.sisaWaktu,
    this.periode
  });

  factory DekomDetailedItem.fromJson(Map<String, dynamic> json) =>
      _$DekomDetailedItemFromJson(json);

  static get serializer => _$DekomDetailedItemFromJson;

}