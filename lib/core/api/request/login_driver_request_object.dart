import 'package:bumn_eid/core/api/request/request_object.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_driver_request_object.g.dart';

@JsonSerializable(createFactory: false)
class LoginDriverRequestObject implements RequestObject {
  final String email;
  final String password;

  const LoginDriverRequestObject({
    @required this.email,
    @required this.password
  });

  Map getJsonBody() {
    return _$LoginDriverRequestObjectToJson(this);
  }
}
