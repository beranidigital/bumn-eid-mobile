import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ebitda.g.dart';

@JsonSerializable(createToJson: false)
class Ebitda extends ResponseObject with Sortable {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_lengkap')
  final String namaPerusahaan;

  @JsonKey(name: 'tahun')
  final int tahun;
  
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

  Ebitda({this.id, this.namaPerusahaan, this.tahun, this.jumlah, this.satuan, this.cluster, this.wamen, this.periodeNama});

  factory Ebitda.fromJson(Map<String, dynamic> json) =>
      _$EbitdaFromJson(json);

  static get serializer => _$EbitdaFromJson;

  @override
  num getNumber() {
    return jumlah;
  }

}