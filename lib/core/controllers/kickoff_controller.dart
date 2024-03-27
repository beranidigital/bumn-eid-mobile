import 'dart:convert';

import 'package:bumn_eid/core/controllers/last_update_controller.dart';
import 'package:bumn_eid/core/controllers/one_signal_controller.dart';
import 'package:bumn_eid/core/controllers/secure_storage_controller.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/models/common/user.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/actions/authentication/authentication_actions.dart';
import 'package:bumn_eid/core/redux/actions/companies/companies_actions.dart';
import 'package:bumn_eid/core/redux/actions/last_update/last_update_actions.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/irwan_dev/services/session_logout.dart';
import 'package:bumn_eid/irwan_dev/services/storage_preferences.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class KickOffController {
  final Store<AppState> store;
  final SecureStorageController secureStorageController;
  final SessionController sessionController;
  final LastUpdateController lastUpdateController;
  final OneSignalController oneSignalController;

  KickOffController({
    @required this.store,
    @required this.secureStorageController,
    @required this.sessionController,
    @required this.lastUpdateController,
    @required this.oneSignalController,
  });

  void start() async {
    // do what you want to do on app start

    final currentUser = await secureStorageController.getUser();

    // int i = 0;

    // TODO : Set Session User
    // print("Session User ${StoragePreferences.getTimeLogin().toString()}");

    // SessionLogin dateTimeSave =
    //     new SessionLogin.fromMap(jsonDecode(StoragePreferences.getTimeLogin()));

    // var hasil = await SessionLogout()
    //     .methodSession(dateTimeSave.tgl, dateTimeSave.bln, dateTimeSave.thn);

    // if (hasil != 1) {
    if (currentUser != null) {
      // if (i == 1) {
      store.dispatch(LoadUserAction(user: currentUser));
      sessionController.setUser(currentUser);
      store.dispatch(
          NavigateToNextAndReplaceAction(destination: HomePageDestination()));
    }
    // } else {
    // await secureStorageController.saveUser(new User());
    // }

    final companies = await secureStorageController.getCompanies();
    if (companies != null) {
      store.dispatch(GotCompaniesAction(companies: companies));
    }

    if (currentUser != null) {
      final lastUpdates = await lastUpdateController.fetchLastUpdate();
      if (lastUpdates != null) {
        store.dispatch(GotLastUpdateData(lastUpdate: lastUpdates));
      }
    }

    oneSignalController.initOneSignal();
  }
}
