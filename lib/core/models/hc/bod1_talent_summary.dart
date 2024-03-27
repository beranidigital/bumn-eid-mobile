import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_talent_summary.g.dart';

@JsonSerializable(createToJson: false)
class BOD1TalentSummary extends ResponseObject {

  @JsonKey(name: 'SUMMARY')
  final String summary;

  @JsonKey(name: 'INTEREST')
  final String interest;

  BOD1TalentSummary({
    this.summary,
    this.interest,
  });

  factory BOD1TalentSummary.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentSummaryFromJson(json);

  static get serializer => _$BOD1TalentSummaryFromJson;

}