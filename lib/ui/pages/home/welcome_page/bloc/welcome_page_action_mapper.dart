import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/authentication/authentication_actions.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class WelcomePageActionMapper extends ActionMapper {
  WelcomePageActionMapper(Store store) : super(store);

  submitLogin({
    @required String email,
    @required String password,
  }) =>
      dispatch(LogInAction(
        email: email,
        password: password,
      ));

  submitLoginQR({
    @required String code,
  }) =>
      dispatch(
        LogInAction(
          qrCode: code,
        ),
      );
}
