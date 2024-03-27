import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:redux/redux.dart';

class CovidByClassActionMapper extends ActionMapper {

  CovidByClassActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openSearchModal() => _featureNotAvailable();

  openDetailedJenisPage(String kelasString, )
        => dispatch(NavigateToNextAction(destination: CovidByClassDetailedPageDestination(kelas: convertStringToKelas(kelasString))));

}