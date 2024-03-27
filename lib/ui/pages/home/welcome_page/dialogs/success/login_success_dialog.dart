import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/strings/strings.dart';
import 'package:bumn_eid/irwan_dev/services/storage_preferences.dart';
import 'package:bumn_eid/ui/modals/general_success_dialog/general_success_dialog.dart';
import 'package:bumn_eid/ui/pages/home/welcome_page/dialogs/success/di/login_success_dialog_graph.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class LoginSuccessDialog extends StatelessWidget with InjectableWidget {
  final LoginSuccessDialogGraph _graph;

  //injected
  Store<AppState> store;

  @override
  LoginSuccessDialogGraph graph() => _graph;

  LoginSuccessDialog({LoginSuccessDialogGraph graph})
      : this._graph = graph ?? LoginSuccessDialogGraph() {
    setup();
  }

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GeneralSuccessDialog(
      title: Strings.getString("LoginSuccessDialog.Title"),
      message: Strings.getString("LoginSuccessDialog.Message"),
      onButtonClick: () {
        // print("${now.day} -- ${now.month} -- ${now.year}");
        StoragePreferences.setTimeLogin(
            SessionLogin(bln: now.month, tgl: now.day, thn: now.year));
        store.dispatch(
            NavigateToNextAndReplaceAction(destination: HomePageDestination()));
      },
    );
  }
}
