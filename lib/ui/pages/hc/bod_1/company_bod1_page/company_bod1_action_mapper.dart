import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class CompanyBOD1ActionMapper extends ActionMapper {

  CompanyBOD1ActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openProfileBOD1(ProfilPerusahaan company)
        => dispatch(NavigateToNextAction(destination: ProfileBOD1PageDestination(company: company)));

  openTalentPool(ProfilPerusahaan company)
  => _featureNotAvailable();

}