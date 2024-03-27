import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/sector/sektor_bumn_page/sektor_bumn_page.dart';
import 'package:redux/redux.dart';

class SektorBumnActionMapper extends ActionMapper {

  SektorBumnActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openSearchModal() => _featureNotAvailable();

  openDetailedJenisPage(String sektor, SektorBumnPageType type) {
      dispatch(NavigateToNextAction(
          destination: SektorBumnDetailedPageDestination(sektor: sektor, type: type)));
  }

}