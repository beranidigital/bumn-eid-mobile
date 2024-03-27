import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class LegalSummaryPageActionMapper extends ActionMapper {

  LegalSummaryPageActionMapper(Store<AppState> store) : super(store);

  featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  goToCategory(String category) => dispatch(
    NavigateToNextAction(
      destination: LegalCategoryPageDestination(
        category: category
      )
    )
  );

}