import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_talent_education.g.dart';

@JsonSerializable(createToJson: false)
class BOD1TalentEducation extends ResponseObject {

  @JsonKey(name: 'JENJANG')
  final String jenjang;

  @JsonKey(name: 'INSTANSI')
  final String instansi;

  @JsonKey(name: 'LULUS')
  final String tahunLulus;

  @JsonKey(name: 'KOTANEGARA')
  final String kotaNegara;

  @JsonKey(name: 'PENGHARGAAN')
  final String penghargaan;

  @JsonKey(name: 'JURUSAN')
  final String jurusan;

  BOD1TalentEducation({
    this.jenjang,
    this.instansi,
    this.tahunLulus,
    this.kotaNegara,
    this.penghargaan,
    this.jurusan
  });

  factory BOD1TalentEducation.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentEducationFromJson(json);

  static get serializer => _$BOD1TalentEducationFromJson;

}