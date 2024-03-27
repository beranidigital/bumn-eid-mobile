import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pkbl.g.dart';

@JsonSerializable(createToJson: false)
class Pkbl extends ResponseObject {

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'satuan')
  final String satuan;

  @JsonKey(name: 'pk_dana_tersedia')
  final String pkTersedia;

  @JsonKey(name: 'bl_dana_tersedia')
  final String blTersedia;

  @JsonKey(name: 'pk_penyaluran_dana')
  final String pkTersalurkan;

  @JsonKey(name: 'bl_penyaluran_dana')
  final String blTersalurkan;

  Pkbl({this.tahun, this.satuan, this.pkTersedia, this.blTersedia, this.pkTersalurkan, this.blTersalurkan});

  factory Pkbl.fromJson(Map<String, dynamic> json) =>
      _$PkblFromJson(json);

  static get serializer => _$PkblFromJson;

}