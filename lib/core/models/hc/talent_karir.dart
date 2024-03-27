import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_karir.g.dart';

@JsonSerializable()
class TalentKarir extends ResponseObject {

  @JsonKey(name: 'i_user')
  final int idUser;

  @JsonKey(name: 'i_jabatan')
  final int idJabatan;

  @JsonKey(name: 'i_pangkat')
  final int idPangkat;

  @JsonKey(name: 'asal_instansi')
  final String asalInstansi;

  @JsonKey(name: 'd_mulaijabat')
  final String mulaiJabat;

  @JsonKey(name: 'd_akhirjabat')
  final String akhirJabat;

  @JsonKey(name: 'i_periode')
  final String periode;

  @JsonKey(name: 'status_kepegawaian')
  final String statusKepegawaian;

  TalentKarir({
    this.idUser,
    this.mulaiJabat,
    this.akhirJabat,
    this.periode,
    this.asalInstansi,
    this.idJabatan,
    this.idPangkat,
    this.statusKepegawaian,
  });

  factory TalentKarir.fromJson(Map<String, dynamic> json) =>
      _$TalentKarirFromJson(json);

  static get serializer => _$TalentKarirFromJson;

}