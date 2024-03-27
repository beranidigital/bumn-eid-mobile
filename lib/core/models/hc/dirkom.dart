import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dirkom.g.dart';

@JsonSerializable()
class Dirkom extends ResponseObject {
  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_pejabat')
  final String nama;

  @JsonKey(name: 'jabatan')
  final String jabatan;

  @JsonKey(name: 'sk_jabat')
  final String skJabat;

  @JsonKey(name: 'tgl_mulaijabat')
  final DateTime mulaiJabat;

  @JsonKey(name: 'tgl_akhirjabat')
  final DateTime akhirJabat;

  @JsonKey(name: 'dirkom')
  final String type;

  Dirkom({
    this.id,
    this.nama,
    this.jabatan,
    this.skJabat,
    this.mulaiJabat,
    this.akhirJabat,
    this.type,
  });

  factory Dirkom.fromJson(Map<String, dynamic> json) => _$DirkomFromJson(json);

  static get serializer => _$DirkomFromJson;

  Map toJson() {
    return _$DirkomToJson(this);
  }
}

enum DirkomType { DIREKTUR, KOMISARIS }
