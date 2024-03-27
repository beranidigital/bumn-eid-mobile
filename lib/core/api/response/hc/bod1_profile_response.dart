import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/bod1_profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_profile_response.g.dart';

@JsonSerializable(createToJson: false)
class BOD1ProfileResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<BOD1Profile> data;

  BOD1ProfileResponse({this.success, this.message, this.data});

  factory BOD1ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$BOD1ProfileResponseFromJson(json);

  static get serializer => _$BOD1ProfileResponseFromJson;
}