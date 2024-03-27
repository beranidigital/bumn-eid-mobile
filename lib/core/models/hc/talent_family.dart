import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_family.g.dart';

@JsonSerializable()
class TalentFamily extends ResponseObject {

  @JsonKey(name: 'i_user')
  final int idUser;

  @JsonKey(name: 'i_keluarga')
  final int idKeluarga;

  @JsonKey(name: 'i_family')
  final int idFamily;

  @JsonKey(name: 'n_keluarga')
  final String namaKeluarga;

  @JsonKey(name: 'e_bplace')
  final String tempatLahir;

  @JsonKey(name: 'd_born')
  final String tanggalLahir;

  @JsonKey(name: 'e_education')
  final String education;

  @JsonKey(name: 'e_pekerjaan')
  final String occupation;

  @JsonKey(name: 'n_family')
  final String hubungan;

  TalentFamily({
    this.education,
    this.hubungan,
    this.idFamily,
    this.idKeluarga,
    this.idUser,
    this.namaKeluarga,
    this.occupation,
    this.tanggalLahir,
    this.tempatLahir
  });

  factory TalentFamily.fromJson(Map<String, dynamic> json) =>
      _$TalentFamilyFromJson(json);

  static get serializer => _$TalentFamilyFromJson;

}