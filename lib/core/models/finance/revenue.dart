import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'revenue.g.dart';

@JsonSerializable(createToJson: false)
class Revenue extends ResponseObject with Sortable {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_lengkap')
  final String namaPerusahaan;

  @JsonKey(name: 'tahun')
  final String tahun;
  
  @JsonKey(name: 'jumlah')
  final int jumlah;

  @JsonKey(name: 'satuan')
  final String satuan;

  @JsonKey(name: 'cluster_bumn')
  final String cluster;

  @JsonKey(name: 'wamen_bumn')
  final String wamen;

  @JsonKey(name: 'periode_nama')
  final String periodeNama;

  Revenue({this.id, this.namaPerusahaan, this.tahun, this.jumlah, this.satuan, this.cluster, this.wamen, this.periodeNama});

  factory Revenue.fromJson(Map<String, dynamic> json) =>
      _$RevenueFromJson(json);

  static get serializer => _$RevenueFromJson;

  @override
  num getNumber() {
    return jumlah;
  }

}