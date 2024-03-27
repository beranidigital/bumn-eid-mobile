import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_bahasa.g.dart';

@JsonSerializable()
class TalentBahasa extends ResponseObject {

  @JsonKey(name: 'i_user')
  final int idUser;

  @JsonKey(name: 'e_lisan')
  final String lisan;

  @JsonKey(name: 'e_tulisan')
  final String tulisan;

  @JsonKey(name: 'n_bahasa')
  final String namaBahasa;

  TalentBahasa({
    this.idUser,
    this.lisan,
    this.namaBahasa,
    this.tulisan
  });

  factory TalentBahasa.fromJson(Map<String, dynamic> json) =>
      _$TalentBahasaFromJson(json);

  static get serializer => _$TalentBahasaFromJson;

}