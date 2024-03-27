import 'package:bumn_eid/core/api/response/session/session_response.dart';
import 'package:bumn_eid/core/controllers/secure_storage_controller.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/exceptions/unexpected_exception.dart';
import 'package:bumn_eid/core/exceptions/user_friendly_exception.dart';
import 'package:bumn_eid/core/models/common/user.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/actions/authentication/authentication_actions.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/irwan_dev/services/storage_preferences.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

/// This middleware will intercept every action related to the Authentication actions.
class AuthenticationMiddleware implements MiddlewareClass<AppState> {
  final SessionController sessionController;
  final SecureStorageController secureStorageController;

  AuthenticationMiddleware(
      {@required this.sessionController,
      @required this.secureStorageController});

  @override
  call(Store store, action, next) {
    if (action is LogInAction) {
      _handleLoginAction(store, action);
    } else if (action is LogInSuccessAction) {
      _handleLogInSuccessAction(store, action);
    } else if (action is LogInFailedAction) {
      _handleLogInFailedAction(store, action);
    } else if (action is LogOutAction) {
      _handleLogoutAction(store, action);
    }

    // Make sure to forward actions to the next middleware in the chain!
    next(action);
  }

  Future<void> _handleLoginAction(
      Store<AppState> store, LogInAction action) async {
    try {
      store.dispatch(ShowDialogAction(destination: LoadingDialogDestination()));

      SessionResponse response;
      if (action.qrCode != null && action.qrCode.isNotEmpty) {
        response = await sessionController.loginWithQR(
          qrCode: action.qrCode,
        );
      } else {
        response = await sessionController.login(
            email: action.email, password: action.password);
      }

      User newUser = User(
          id: response.data.user.id,
          email: response.data.user.email,
          name: response.data.user.name,
          token: response.data.user.token,
          role: response.data.role);

      if (newUser.role == null || newUser.role.isEmpty)
        throw new CustomException("Tidak memiliki Akses!", Exception());
      else
        store.dispatch(LogInSuccessAction(user: newUser));
    } on UserFriendlyException catch (ex) {
      store.dispatch(LogInFailedAction(exception: ex));
    }
  }

  Future<void> _handleLogInSuccessAction(
      Store<AppState> store, LogInSuccessAction action) async {
    await secureStorageController.saveUser(action.user);
    // print(
    //     "Berhasil Connect ${action.user.email} ${action.user.id} ${action.user.name}");
    await StoragePreferences.setIdUser(action.user.id);
    ApiStatistic().insertStatistic("Form Login", "Login Sukses");
    store.dispatch(ShowDialogAction(
        destination: LoginSuccessDialogDestination(),
        barrierDismissible: false));
  }

  Future<void> _handleLogInFailedAction(
      Store<AppState> store, LogInFailedAction action) async {
    store.dispatch(NavigateBackAction());

    store.dispatch(ShowDialogAction(
        destination: LoginFailedDialogDestination(exception: action.exception),
        barrierDismissible: false));
  }

  Future<void> _handleLogoutAction(
      Store<AppState> store, LogOutAction action) async {
    await secureStorageController.deleteUser();
    store.dispatch(NavigateToNextAndReplaceAction(
      destination: WelcomePageDestination(),
    ));
  }
}
