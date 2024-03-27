import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/total/total_bumn_page/total_bumn_page.dart';
import 'package:redux/redux.dart';

class TotalBumnActionMapper extends ActionMapper {

  TotalBumnActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openSearchModal() => _featureNotAvailable();

  openCompanyDetailPage(String companyId, TotalBumnPageType type) {
    if (type == TotalBumnPageType.BUSINESS_PORTFOLIO) {
      dispatch(NavigateToNextAction(
          destination: CompanyDetailPageDestination(
              id: companyId
          )
      ));
    } else if (type == TotalBumnPageType.HC_EMPLOYEE) {
      dispatch(NavigateToNextAction(
          destination: CompanyEmployeePageDestination(
              id: companyId
          )
      ));
    } else if (type == TotalBumnPageType.HC_DEKOM) {
      dispatch(NavigateToNextAction(
          destination: CompanyDekomPageDestination(
              companyId: companyId
          )
      ));
    } else if (type == TotalBumnPageType.HC_BOD) {
      dispatch(NavigateToNextAction(
          destination: CompanyBODPageDestination(
              companyId: companyId
          )
      ));
    }
  }

}