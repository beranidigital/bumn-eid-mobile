import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'anggaran.g.dart';

@JsonSerializable(createToJson: false)
class Anggaran extends ResponseObject {

  @JsonKey(name: 'id_angka')
  final String companyId;

  @JsonKey(name: 'nama_lengkap')
  final String companyName;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'rencana')
  final String rencana;

  @JsonKey(name: 'realisasi')
  final String realisasi;

  @JsonKey(name: 'jenis_akun')
  final String jenisAkun;

  Anggaran({this.companyName, this.companyId, this.tahun, this.realisasi, this.jenisAkun, this.rencana});

  factory Anggaran.fromJson(Map<String, dynamic> json) =>
      _$AnggaranFromJson(json);

  static get serializer => _$AnggaranFromJson;

}