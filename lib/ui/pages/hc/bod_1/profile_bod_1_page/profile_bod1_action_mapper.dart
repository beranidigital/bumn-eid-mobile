import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/models/hc/bod1_profile.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class ProfileBOD1ActionMapper extends ActionMapper {

  ProfileBOD1ActionMapper(Store<AppState> store) : super(store);

  toCvPage({@required BOD1Profile profile,@required ProfilPerusahaan company,})
        => dispatch(NavigateToNextAction(destination: BOD1TalentDetailPageDestination(profile: profile, company: company)));
}