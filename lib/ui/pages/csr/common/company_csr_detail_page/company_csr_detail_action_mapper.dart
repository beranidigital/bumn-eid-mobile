import 'package:bumn_eid/core/models/csr/csr_item.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class CompanyCsrDetailActionMapper extends ActionMapper {

  CompanyCsrDetailActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openCsrItemPage(CsrItem item)
        => dispatch(NavigateToNextAction(destination: CsrDetailPageDestination(item: item)));

}