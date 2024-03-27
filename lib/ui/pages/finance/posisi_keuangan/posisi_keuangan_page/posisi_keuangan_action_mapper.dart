import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class PosisiKeuanganActionMapper extends ActionMapper {
  PosisiKeuanganActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(
      ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openSearchModal() => _featureNotAvailable();

  openCompanyDetailPage(String companyId) {
    dispatch(NavigateToNextAction(
        destination: CompanyDetailPageDestination(id: companyId)));
  }

  openDetailedPKPage(String jenisAkun) => dispatch(NavigateToNextAction(
      destination:
          PosisiKeuanganDetailedPageDestination(jenisAkun: jenisAkun)));
}
