import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'capex.g.dart';

@JsonSerializable(createToJson: false)
class Capex extends ResponseObject {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_lengkap')
  final String namaPerusahaan;

  @JsonKey(name: 'tahun')
  final String tahun;

  @JsonKey(name: 'periode_nama')
  final String periodeNama;

  @JsonKey(name: 'jumlah')
  final String jumlah;

  @JsonKey(name: 'satuan')
  final String satuan;

  @JsonKey(name: 'cluster_bumn')
  final String cluster;

  @JsonKey(name: 'wamen_bumn')
  final String wamen;

  Capex({this.id, this.namaPerusahaan, this.tahun, this.jumlah, this.periodeNama, this.satuan, this.cluster, this.wamen});

  factory Capex.fromJson(Map<String, dynamic> json) =>
      _$CapexFromJson(json);

  static get serializer => _$CapexFromJson;

}