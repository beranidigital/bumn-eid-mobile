import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class TalentPoolByProcessPageActionMapper extends ActionMapper {

  TalentPoolByProcessPageActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openByClass() => dispatch(NavigateToNextAction(destination: TalentPoolByClassPageDestination()));

  openByCompany() => dispatch(NavigateToNextAction(destination: TalentPoolByCompanyPageDestination()));

  openByCluster() => dispatch(NavigateToNextAction(destination: TalentPoolByClusterPageDestination()));

  openDroppedTalent() => dispatch(NavigateToNextAction(destination: DropTalentPageDestination()));

  openAdvanceFilter() => dispatch(NavigateToNextAction(destination: TalentPoolListPageDestination()));

}