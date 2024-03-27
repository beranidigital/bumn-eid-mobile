import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_talent_performance.g.dart';

@JsonSerializable(createToJson: false)
class BOD1TalentPerformance extends ResponseObject {

  @JsonKey(name: 'NILAI_PERFORMANCE')
  final String nilai;

  @JsonKey(name: 'TAHUN_PENILAIAN')
  final String tahun;

  BOD1TalentPerformance({
    this.nilai,
    this.tahun,
  });

  factory BOD1TalentPerformance.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentPerformanceFromJson(json);

  static get serializer => _$BOD1TalentPerformanceFromJson;

}