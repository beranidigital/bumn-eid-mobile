import 'package:bumn_eid/core/controllers/secure_storage_controller.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/redux/middlewares/authentication_middleware.dart';
import 'package:bumn_eid/core/redux/middlewares/navigation_middleware.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/redux/reducers/reducer.dart' as Reducer;
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:redux/redux.dart';

Store<AppState> createStore() {
  final navigatorKey = Injector.appInstance.getDependency<GlobalKey<NavigatorState>>();
  final sessionController = Injector.appInstance.getDependency<SessionController>();
  final secureStorageController = Injector.appInstance.getDependency<SecureStorageController>();
  return Store<AppState>(
    Reducer.reduce,
    initialState: AppState(),
    middleware: [
      NavigationMiddleware(navigatorKey: navigatorKey),
      AuthenticationMiddleware(sessionController: sessionController, secureStorageController: secureStorageController),
    ],
  );
}