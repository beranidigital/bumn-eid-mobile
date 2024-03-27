import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/bod_talent.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod_talent_fungsi_response.g.dart';

@JsonSerializable(createToJson: false)
class BODTalentFungsiResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final Map data;

  BODTalentFungsiResponse({this.success, this.message, this.data});

  factory BODTalentFungsiResponse.fromJson(Map<String, dynamic> json) =>
      _$BODTalentFungsiResponseFromJson(json);

  static get serializer => _$BODTalentFungsiResponseFromJson;
}