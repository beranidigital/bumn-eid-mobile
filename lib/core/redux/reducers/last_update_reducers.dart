import 'package:bumn_eid/core/redux/actions/last_update/last_update_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/redux/states/last_updated/last_update_state.dart';

const Map<Type, Function> lastUpdateReducers = {
  //GotCompaniesAction
  GotLastUpdateData: _gotLastUpdateReducer
};

AppState _gotLastUpdateReducer(
    GotLastUpdateData action,
    AppState state,
    ) {
  LastUpdateState lastUpdateState =
  state.lastUpdateState.copyWith(lastUpdated: action.lastUpdate);
  return state.copyWith(
    lastUpdateState: lastUpdateState,
  );
}