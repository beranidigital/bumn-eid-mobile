import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_talent_assessment.g.dart';

@JsonSerializable(createToJson: false)
class BOD1TalentAssessment extends ResponseObject {

  @JsonKey(name: 'KOMPETENSI')
  final String kompetensi;

  @JsonKey(name: 'NILAI_KOMPETENSI')
  final String nilai;

  @JsonKey(name: 'TYPE_KOMPETENSI')
  final String tipe;

  BOD1TalentAssessment({
    this.kompetensi,
    this.nilai,
    this.tipe
  });

  factory BOD1TalentAssessment.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentAssessmentFromJson(json);

  static get serializer => _$BOD1TalentAssessmentFromJson;

}