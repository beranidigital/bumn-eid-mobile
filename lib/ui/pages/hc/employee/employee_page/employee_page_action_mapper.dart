import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_page/cluster_bumn_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_page/kelas_bumn_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/sector/sektor_bumn_page/sektor_bumn_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/total/total_bumn_page/total_bumn_page.dart';
import 'package:redux/redux.dart';

class EmployeePageActionMapper extends ActionMapper {

  EmployeePageActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openByCompany() => dispatch(NavigateToNextAction(destination: TotalBumnPageDestination(type: TotalBumnPageType.HC_EMPLOYEE)));

  openByClass() => dispatch(NavigateToNextAction(destination: KelasBumnPageDestination(type: KelasBumnPageType.HC_EMPLOYEE)));

  openByCluster() => dispatch(NavigateToNextAction(destination: ClusterBumnPageDestination(type: ClusterBumnPageType.HC_EMPLOYEE)));
}