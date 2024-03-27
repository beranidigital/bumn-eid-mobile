import 'package:bumn_eid/core/models/legal/legal_item.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class LegalCategoryActionMapper extends ActionMapper {
  LegalCategoryActionMapper(Store<AppState> store) : super(store);

  featureNotAvailable() => dispatch(
      ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  goToDetail(LegalItem item) => dispatch(NavigateToNextAction(
      destination: LegalDetailPageDestination(item: item)));
}
