import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class BusinessPortfolioActionMapper extends ActionMapper {
  BusinessPortfolioActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(
      ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openSearchModal() => _featureNotAvailable();

  openJenisBumn() =>
      dispatch(NavigateToNextAction(destination: DBJenisBumnPageDestination()));

  openTotalBumn() =>
      dispatch(NavigateToNextAction(destination: TotalBumnPageDestination()));

  openSectorBumn() =>
      dispatch(NavigateToNextAction(destination: SektorBumnPageDestination()));

  openClusterBumn() =>
      dispatch(NavigateToNextAction(destination: ClusterBumnPageDestination()));

  openWamenI() => dispatch(NavigateToNextAction(
          destination: ClusterBumnPageDestination(
        wamen: 'WAMEN I',
      )));

  openWamenII() => dispatch(NavigateToNextAction(
          destination: ClusterBumnPageDestination(
        wamen: 'WAMEN II',
      )));

  openClassBumn() =>
      dispatch(NavigateToNextAction(destination: KelasBumnPageDestination()));
}
