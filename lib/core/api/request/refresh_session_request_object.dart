import 'package:bumn_eid/core/api/request/request_object.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_session_request_object.g.dart';

@JsonSerializable(createFactory: false)
class RefreshSessionRequestObject implements RequestObject {
  @JsonKey(name: 'refresh')
  final String refreshToken;

  const RefreshSessionRequestObject({
    @required this.refreshToken
  });

  Map getJsonBody() {
    return _$RefreshSessionRequestObjectToJson(this);
  }
}
