import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drop_talent_item.g.dart';

@JsonSerializable(createToJson: false)
class DropTalentItem extends ResponseObject {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'jabatan')
  final String jabatan;

  @JsonKey(name: 'nik')
  final String nik;

  @JsonKey(name: 'nama')
  final String nama;

  @JsonKey(name: 'bumn')
  final String bumn;

  @JsonKey(name: 'busnm')
  final String busnm;

  @JsonKey(name: 'kategori')
  final String kategori;

  @JsonKey(name: 'id_angka')
  final String id_angka;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'nilai_domestic')
  final String nilai_domestic;

  @JsonKey(name: 'nilai_global')
  final String nilai_global;

  @JsonKey(name: 'hasil_domestic')
  final String hasil_domestic;

  @JsonKey(name: 'hasil_global')
  final String hasil_global;

  @JsonKey(name: 'lainnya_tclust')
  final String lainnya_tclust;

  @JsonKey(name: 'mobility')
  final String mobility;

  @JsonKey(name: 'feedback')
  final String feedback;

  @JsonKey(name: 'mobility_kategori')
  final String mobility_kategori;

  DropTalentItem({this.status, this.id, this.nama, this.bumn, this.nik, this.feedback, this.mobility, this.kategori,
  this.jabatan, this.busnm, this.hasil_domestic, this.hasil_global, this.id_angka, this.lainnya_tclust, this.mobility_kategori,
  this.nilai_domestic, this.nilai_global});

  factory DropTalentItem.fromJson(Map<String, dynamic> json) =>
      _$DropTalentItemFromJson(json);

  static get serializer => _$DropTalentItemFromJson;

}