import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_personal.g.dart';

@JsonSerializable()
class TalentPersonal extends ResponseObject {

  @JsonKey(name: 'i_user')
  final int idUser;

  @JsonKey(name: 'n_fname')
  final String name;

  @JsonKey(name: 'e_gelar')
  final String gelar;

  @JsonKey(name: 'n_gender')
  final String gender;

  @JsonKey(name: 'e_telp')
  final String telepon;

  @JsonKey(name: 'n_agama')
  final String agama;

  @JsonKey(name: 'n_married')
  final String statusPerkawinan;

  @JsonKey(name: 'e_email')
  final String email;

  @JsonKey(name: 'e_bplace')
  final String tempatLahir;

  @JsonKey(name: 'd_born')
  final String tanggalLahir;

  @JsonKey(name: 'e_npwp')
  final String npwp;

  @JsonKey(name: 'e_naddress')
  final String alamat;

  @JsonKey(name: 'foto_user')
  final String photo;

  TalentPersonal({
    this.idUser,
    this.name,
    this.telepon,
    this.agama,
    this.gelar,
    this.gender,
    this.statusPerkawinan,
    this.tempatLahir,
    this.tanggalLahir,
    this.alamat,
    this.email,
    this.npwp,
    this.photo
  });

  factory TalentPersonal.fromJson(Map<String, dynamic> json) =>
      _$TalentPersonalFromJson(json);

  static get serializer => _$TalentPersonalFromJson;

}