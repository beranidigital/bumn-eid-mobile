import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_page/kelas_bumn_page.dart';
import 'package:redux/redux.dart';

class KelasBumnDetailedActionMapper extends ActionMapper {

  KelasBumnDetailedActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openCompanyDetailPage(String companyId, KelasBumnPageType type)
  {
    if (type == KelasBumnPageType.BUSINESS_PORTFOLIO) {
      dispatch(NavigateToNextAction(
          destination: CompanyDetailPageDestination(
            id: companyId,

          )
      ));
    } else if (type == KelasBumnPageType.HC_EMPLOYEE) {
      dispatch(NavigateToNextAction(
          destination: CompanyEmployeePageDestination(
              id: companyId
          )
      ));
    } else if (type == KelasBumnPageType.HC_DEKOM) {
      dispatch(NavigateToNextAction(
          destination: CompanyDekomPageDestination(
              companyId: companyId
          )
      ));
    } else if (type == KelasBumnPageType.HC_BOD) {
      dispatch(NavigateToNextAction(
          destination: CompanyBODPageDestination(
              companyId: companyId
          )
      ));
    }
  }

}