import 'package:bumn_eid/core/api/request/request_object.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_driver_qr_request_object.g.dart';

@JsonSerializable(createFactory: false)
class LoginDriverQRRequestObject implements RequestObject {
  final String qrCode;

  const LoginDriverQRRequestObject({
    @required this.qrCode,
  });

  Map getJsonBody() {
    return _$LoginDriverQRRequestObjectToJson(this);
  }
}
