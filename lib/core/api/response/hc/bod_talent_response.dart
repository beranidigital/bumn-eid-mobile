import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/bod_talent.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod_talent_response.g.dart';

@JsonSerializable(createToJson: false)
class BODTalentResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<BODTalent> data;

  BODTalentResponse({this.success, this.message, this.totalData, this.data});

  factory BODTalentResponse.fromJson(Map<String, dynamic> json) =>
      _$BODTalentResponseFromJson(json);

  static get serializer => _$BODTalentResponseFromJson;
}