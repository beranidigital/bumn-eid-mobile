import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class TalentPoolByClusterPageActionMapper extends ActionMapper {

  TalentPoolByClusterPageActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openAdvanceFilter({@required String cluster}) => dispatch(NavigateToNextAction(destination: TalentPoolListPageDestination(cluster: cluster)));

}