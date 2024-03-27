import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class LabaRugiActionMapper extends ActionMapper {
  LabaRugiActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(
      ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openCompanyDetailPage(String companyId) {
    dispatch(NavigateToNextAction(
        destination: CompanyDetailPageDestination(id: companyId)));
  }

  openSearchModal() => _featureNotAvailable();

  openDetailedLRPage(String jenisLabaRugi) => dispatch(NavigateToNextAction(
      destination:
          LabaRugiDetailedPageDestination(jenisLabaRugi: jenisLabaRugi)));
}
