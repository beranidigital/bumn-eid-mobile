import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class TalentPoolPageActionMapper extends ActionMapper {

  TalentPoolPageActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openByMobility() => dispatch(NavigateToNextAction(destination: TalentMobilityPageDestination()));

  openByProcess() => dispatch(NavigateToNextAction(destination: TalentPoolByProcessPageDestination()));

}