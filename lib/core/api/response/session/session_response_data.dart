import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_response_data.g.dart';

@JsonSerializable(createToJson: false)
class SessionResponseData extends ResponseObject {
  @JsonKey(name: 'user')
  User user;

  @JsonKey(name: 'token')
  final String token;

  @JsonKey(name: 'role')
  final List<String> role;

  SessionResponseData({this.user, this.token, this.role});

  factory SessionResponseData.fromJson(Map<String, dynamic> json) =>
      _$SessionResponseDataFromJson(json);

  static get serializer => _$SessionResponseDataFromJson;
}