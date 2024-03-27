import 'package:bumn_eid/core/models/business_portfolio/jenis_perusahaan.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class DBJenisBumnActionMapper extends ActionMapper {
  DBJenisBumnActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(
      ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openSearchModal() => _featureNotAvailable();

  openDetailedJenisPage(String jenisBumn) => dispatch(NavigateToNextAction(
      destination: JenisBumnDetailedPageDestination(jenisBumn: jenisBumn)));

  openCompanyDetailPage(JenisPerusahaan company) {
    dispatch(NavigateToNextAction(
        destination: CompanyDetailPageDestination(id: company.id.toString())));
  }
}
