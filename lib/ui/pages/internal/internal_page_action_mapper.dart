import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:redux/redux.dart';

class InternalPageActionMapper extends ActionMapper {
  InternalPageActionMapper(Store store) : super(store);

  featureNotAvailable() => dispatch(
      ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));
}
