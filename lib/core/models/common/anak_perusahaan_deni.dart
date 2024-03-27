import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'anak_perusahaan_deni.g.dart';

@JsonSerializable()
class AnakPerusahaanDeni extends ResponseObject {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_induk')
  final String induk;

  @JsonKey(name: 'nama_anak')
  final String anak;

  @JsonKey(name: 'jumlah_pejabat')
  final int jumlahPejabat;

  AnakPerusahaanDeni({
    this.id,
    this.induk,
    this.anak,
    this.jumlahPejabat,
  });

  factory AnakPerusahaanDeni.fromJson(Map<String, dynamic> json) =>
      _$AnakPerusahaanDeniFromJson(json);

  static get serializer => _$AnakPerusahaanDeniFromJson;

}