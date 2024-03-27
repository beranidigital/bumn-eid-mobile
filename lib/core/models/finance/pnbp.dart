import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pnbp.g.dart';

@JsonSerializable(createToJson: false)
class Pnbp extends ResponseObject with Sortable{

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_lengkap')
  final String namaPerusahaan;

  @JsonKey(name: 'tahun')
  final String tahun;
  
  @JsonKey(name: 'jumlah')
  final String jumlah;

  @JsonKey(name: 'satuan')
  final String satuan;

  @JsonKey(name: 'cluster_bumn')
  final String cluster;

  @JsonKey(name: 'wamen_bumn')
  final String wamen;

  @JsonKey(name: 'periode_nama')
  final String periodeNama;

  Pnbp({this.id, this.namaPerusahaan, this.tahun, this.jumlah, this.satuan, this.cluster, this.wamen, this.periodeNama});

  factory Pnbp.fromJson(Map<String, dynamic> json) =>
      _$PnbpFromJson(json);

  static get serializer => _$PnbpFromJson;

  @override
  num getNumber() {
    return int.parse(jumlah);
  }

}