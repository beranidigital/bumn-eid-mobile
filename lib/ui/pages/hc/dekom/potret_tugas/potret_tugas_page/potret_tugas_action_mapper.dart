import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class PotretTugasActionMapper extends ActionMapper {

  PotretTugasActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openSearchModal() => _featureNotAvailable();

  openDetailedPage(int range, bool now)
        => dispatch(NavigateToNextAction(destination: PotretTugasDetailedPageDestination(range: range, now: now)));

}