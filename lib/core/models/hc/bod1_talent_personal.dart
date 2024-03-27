import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_talent_personal.g.dart';

@JsonSerializable(createToJson: false)
class BOD1TalentPersonal extends ResponseObject {

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'nama')
  final String nama;

  @JsonKey(name: 'gelar')
  final String gelar;

  @JsonKey(name: 'nik')
  final String nik;

  @JsonKey(name: 'ttl')
  final String ttl;

  @JsonKey(name: 'jk')
  final String gender;

  @JsonKey(name: 'agama')
  final String agama;

  @JsonKey(name: 'jabatan')
  final String jabatan;

  @JsonKey(name: 'alamat')
  final String alamat;

  @JsonKey(name: 'hp')
  final String hp;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'npwp')
  final String npwp;

  @JsonKey(name: 'sosmed')
  final String sosmed;

  @JsonKey(name: 'summary')
  final String summary;

  @JsonKey(name: 'interest')
  final String interest;

  @JsonKey(name: 'bumn')
  final String bumn;

  @JsonKey(name: 'kategori')
  final String kategori;

  @JsonKey(name: 'begda')
  final String begda;

  @JsonKey(name: 'enda')
  final String enda;

  BOD1TalentPersonal({
    this.id,
    this.nama,
    this.nik,
    this.jabatan,
    this.kategori,
    this.bumn,
    this.gender,
    this.agama,
    this.alamat,
    this.email,
    this.npwp,
    this.gelar,
    this.summary,
    this.begda,
    this.enda,
    this.hp,
    this.interest,
    this.sosmed,
    this.ttl
  });

  factory BOD1TalentPersonal.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentPersonalFromJson(json);

  static get serializer => _$BOD1TalentPersonalFromJson;

}