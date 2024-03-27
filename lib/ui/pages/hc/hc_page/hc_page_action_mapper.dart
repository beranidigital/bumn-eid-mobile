import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/total/total_bumn_page/total_bumn_page.dart';
import 'package:redux/redux.dart';

class HcPageActionMapper extends ActionMapper {

  HcPageActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openDewanKomisaris() => dispatch(NavigateToNextAction(destination: DewanKomisarisPageDestination()));

  openDewanKomisarisByCompany() => dispatch(NavigateToNextAction(destination: TotalBumnPageDestination(type: TotalBumnPageType.HC_DEKOM)));

  openBod() => dispatch(NavigateToNextAction(destination: BODPageDestination()));

  openBodByCompany() => dispatch(NavigateToNextAction(destination: TotalBumnPageDestination(type: TotalBumnPageType.HC_BOD)));

  openBod1() => dispatch(NavigateToNextAction(destination: BOD1PageDestination()));

  openBod1ByCompany() => dispatch(NavigateToNextAction(destination: BOD1CompanyPageDestination()));

  openKaryawan() => dispatch(NavigateToNextAction(destination: EmployeePageDestination()));

  openTalentPool() => dispatch(NavigateToNextAction(destination: TalentPoolPageDestination()));

  openProfileTalent() => _featureNotAvailable();

}