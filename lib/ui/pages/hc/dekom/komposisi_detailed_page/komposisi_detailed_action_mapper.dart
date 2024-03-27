import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class KomposisiDetailedActionMapper extends ActionMapper {

  KomposisiDetailedActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openTalentPage({@required int id})
  => dispatch(NavigateToNextAction(destination: PotretTugasBODTalentPageDestination(id: id, now: true, isBod: false, withCv: true)));

}