import 'package:bumn_eid/core/strings/strings.dart';
import 'package:bumn_eid/ui/modals/general_failed_dialog/general_failed_dialog.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginFailedDialog extends StatelessWidget {
  String errorMessage;

  LoginFailedDialog({
    @required
    this.errorMessage
  });

  @override
  Widget build(BuildContext context) {
    return GeneralFailedDialog(
      title: Strings.getString("LoginFailedDialog.Title"),
      errorMessage: errorMessage ?? Strings.getString("LoginFailedDialog.DefaultMessage"),
    );
  }
}
