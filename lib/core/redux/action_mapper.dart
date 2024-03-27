import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:redux/redux.dart';

// Class responsible for mapping UI actions to Redux actions
class ActionMapper {
  final Store store;

  ActionMapper(this.store);

  void dispatch(dynamic action) => store.dispatch(action);

  featureNotAvailable() => dispatch(
        ShowDialogAction(
          destination: FeatureNotAvailableDialogDestination(),
        ),
      );
}
