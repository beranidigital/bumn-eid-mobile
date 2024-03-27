import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class KontribusiProfesionalActionMapper extends ActionMapper {

  KontribusiProfesionalActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openKomposisiDetailed({@required String komposisi})
  => dispatch(NavigateToNextAction(destination: KomposisiDetailedPageDestination(komposisi: komposisi)));

}