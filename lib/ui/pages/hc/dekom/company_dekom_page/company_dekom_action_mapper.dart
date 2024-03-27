import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class CompanyDekomActionMapper extends ActionMapper {

  CompanyDekomActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openPusat(ProfilPerusahaan company)
        => dispatch(NavigateToNextAction(destination: DekomByCompanyPageDestination(company: company)));

  openAnak(ProfilPerusahaan company)
  => dispatch(NavigateToNextAction(destination: DekomAnakCompanyPageDestination(company: company)));

  openCucu(ProfilPerusahaan company)
  => dispatch(NavigateToNextAction(destination: DekomCucuCompanyPageDestination(company: company)));

}