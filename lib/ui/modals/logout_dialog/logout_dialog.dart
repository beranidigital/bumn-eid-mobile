import 'package:bumn_eid/core/redux/actions/authentication/authentication_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/modals/general_prompt_dialog/general_prompt_dialog.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class LogoutDialog extends StatelessWidget {

  final Store<AppState> store;

  LogoutDialog({@required this.store});

  @override
  Widget build(BuildContext context) {
    return GeneralPromptDialog(
      title: "Keluar",
      message: "Apakah Anda yakin ingin keluar?",
      negativeButtonText: "Tidak",
      positiveButtonText: "Ya",
      onPositiveBtnClick: () {
        store.dispatch(LogOutAction());
      },
    );
  }
}
