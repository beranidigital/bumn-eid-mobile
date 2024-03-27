import 'package:bumn_eid/core/strings/strings.dart';
import 'package:bumn_eid/ui/modals/general_failed_dialog/general_failed_dialog.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FeatureNotAvailableDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GeneralFailedDialog(
      title: Strings.getString("FeatureNotAvailableDialog.Title"),
      errorMessage: Strings.getString("FeatureNotAvailableDialog.Message"),
    );
  }
}
