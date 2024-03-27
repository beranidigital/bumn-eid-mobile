
import 'package:bumn_eid/core/redux/actions/authentication/authentication_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/redux/states/auth/auth_state.dart';

const Map<Type, Function> authReducers = {
  //LogInSuccessAction
  LogInSuccessAction: _loginSuccessReducer,

  //LoadUserAction
  LoadUserAction: _loadUserReducer,

  //LogOutAction
  LogOutAction: _logOutReducer,
};

AppState _loginSuccessReducer(
    LogInSuccessAction action,
    AppState state,
    ) {
  AuthState authState =
  state.authState.copyWith(currentUser: action.user);
  return state.copyWith(
    authState: authState,
  );
}

AppState _logOutReducer(
    LogOutAction action,
    AppState state,
    ) {
  return state.copyWith(
    authState: AuthState(),
  );
}

AppState _loadUserReducer(
    LoadUserAction action,
    AppState state
    ) {
  final authState = state.authState.copyWith(
    currentUser: action.user
  );
  return state.copyWith(
    authState: authState
  );
}