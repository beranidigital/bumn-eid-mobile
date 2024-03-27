import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/api/response/session/session_response_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_response.g.dart';

@JsonSerializable(createToJson: false)
class SessionResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final SessionResponseData data;


  SessionResponse({this.success, this.message, this.data});

  factory SessionResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionResponseFromJson(json);

  static get serializer => _$SessionResponseFromJson;
}