import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cucu_perusahaan_deni.g.dart';

@JsonSerializable()
class CucuPerusahaanDeni extends ResponseObject {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_cucu')
  final String cucu;

  @JsonKey(name: 'nama_anak')
  final String anak;

  @JsonKey(name: 'jumlah_pejabat')
  final int jumlahPejabat;

  CucuPerusahaanDeni({
    this.id,
    this.cucu,
    this.anak,
    this.jumlahPejabat,
  });

  factory CucuPerusahaanDeni.fromJson(Map<String, dynamic> json) =>
      _$CucuPerusahaanDeniFromJson(json);

  static get serializer => _$CucuPerusahaanDeniFromJson;

}