import 'package:bumn_eid/core/exceptions/user_friendly_exception.dart';
import 'package:bumn_eid/core/models/common/user.dart';
import 'package:flutter/material.dart';

class LogInAction {
  final String email;
  final String password;
  final String qrCode;

  LogInAction({
    this.email,
    this.password,
    this.qrCode,
  });
}

class LogInSuccessAction {
  final User user;

  LogInSuccessAction({@required this.user});
}

class LogInFailedAction {
  final UserFriendlyException exception;

  LogInFailedAction({@required this.exception});
}

class LogOutAction {}

class LoadUserAction {
  final User user;

  LoadUserAction({@required this.user});
}
