import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_page/cluster_bumn_page.dart';
import 'package:redux/redux.dart';

class ClusterBumnActionMapper extends ActionMapper {

  ClusterBumnActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openSearchModal() => _featureNotAvailable();

  openDetailedJenisPage(String cluster, ClusterBumnPageType type)
  {
    if(type == ClusterBumnPageType.BUSINESS_PORTFOLIO) {
      dispatch(NavigateToNextAction(destination: ClusterBumnDetailedPageDestination(cluster: cluster, type: type)));
    }
  }

}