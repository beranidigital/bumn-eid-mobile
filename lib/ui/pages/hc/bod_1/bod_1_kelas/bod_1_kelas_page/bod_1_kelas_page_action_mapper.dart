import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class BOD1KelasActionMapper extends ActionMapper {

  BOD1KelasActionMapper(Store<AppState> store) : super(store);

  featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openKelasDetailedPage({@required String kelas})
  => featureNotAvailable();

}