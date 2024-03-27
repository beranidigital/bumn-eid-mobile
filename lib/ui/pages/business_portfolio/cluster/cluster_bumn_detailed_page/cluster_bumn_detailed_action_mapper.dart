import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_page/cluster_bumn_page.dart';
import 'package:redux/redux.dart';

class ClusterBumnDetailedActionMapper extends ActionMapper {

  ClusterBumnDetailedActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openCompanyDetailPage(String companyId, ClusterBumnPageType type)
  {
    if (type == ClusterBumnPageType.BUSINESS_PORTFOLIO) {
      dispatch(NavigateToNextAction(
          destination: CompanyDetailPageDestination(
              id: companyId
          )
      ));
    } else if (type == ClusterBumnPageType.HC_EMPLOYEE) {
      dispatch(NavigateToNextAction(
          destination: CompanyEmployeePageDestination(
              id: companyId
          )
      ));
    } else if (type == ClusterBumnPageType.HC_DEKOM) {
      dispatch(NavigateToNextAction(
          destination: CompanyDekomPageDestination(
              companyId: companyId
          )
      ));
    } else if (type == ClusterBumnPageType.HC_BOD) {
      dispatch(NavigateToNextAction(
          destination: CompanyBODPageDestination(
              companyId: companyId
          )
      ));
    }
  }

}