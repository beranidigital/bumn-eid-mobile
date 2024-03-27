import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent.dart';
import 'package:bumn_eid/core/models/hc/talent_additional_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_talent_response.g.dart';

@JsonSerializable(createToJson: false)
class BOD1TalentResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'additional data')
  final List<TalentAdditionalData> additionalData;

  @JsonKey(name: 'data')
  final BOD1Talent data;

  BOD1TalentResponse({this.success, this.message, this.data, this.additionalData});

  factory BOD1TalentResponse.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentResponseFromJson(json);

  static get serializer => _$BOD1TalentResponseFromJson;
}