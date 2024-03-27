import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'posisi_keuangan.g.dart';

@JsonSerializable(createToJson: false)
class PosisiKeuangan extends ResponseObject with Sortable {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_lengkap')
  final String namaPerusahaan;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'jumlah')
  final String jumlah;

  @JsonKey(name: 'satuan')
  final String satuan;

  @JsonKey(name: 'cluster_bumn')
  final String cluster;

  @JsonKey(name: 'sektor_bumn')
  final String sektor;

  @JsonKey(name: 'periode_nama')
  final String periodeNama;

  PosisiKeuangan({this.id, this.namaPerusahaan, this.tahun, this.jumlah, this.satuan, this.cluster, this.sektor, this.periodeNama});

  factory PosisiKeuangan.fromJson(Map<String, dynamic> json) =>
      _$PosisiKeuanganFromJson(json);

  static get serializer => _$PosisiKeuanganFromJson;

  @override
  num getNumber() {
    return parseDouble(jumlah);
  }



}