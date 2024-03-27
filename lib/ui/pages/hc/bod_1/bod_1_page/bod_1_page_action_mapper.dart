import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class BOD1PageActionMapper extends ActionMapper {

  BOD1PageActionMapper(Store<AppState> store) : super(store);

  openByCompany() => dispatch(NavigateToNextAction(destination: BOD1CompanyPageDestination()));

  openByClass() => dispatch(NavigateToNextAction(destination: BOD1KelasPageDestination()));

  openByCluster() => dispatch(NavigateToNextAction(destination: BOD1ClusterPageDestination()));
}