import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/sector/sektor_bumn_page/sektor_bumn_page.dart';
import 'package:redux/redux.dart';

class SektorBumnDetailedActionMapper extends ActionMapper {

  SektorBumnDetailedActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openCompanyDetailPage(ProfilPerusahaan company, SektorBumnPageType type)
  {
    if (type == SektorBumnPageType.BUSINESS_PORTFOLIO) {
      dispatch(NavigateToNextAction(
          destination: CompanyDetailPageDestination(
              id: company.id.toString()
          )
      ));
    } else {
      dispatch(NavigateToNextAction(
          destination: CompanyEmployeePageDestination(
              id: company.id.toString()
          )
      ));
    }
  }

}