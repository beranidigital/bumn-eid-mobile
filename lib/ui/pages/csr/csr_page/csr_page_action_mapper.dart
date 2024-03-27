import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class CsrPageActionMapper extends ActionMapper {

  CsrPageActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openProgramKemitraan() => dispatch(NavigateToNextAction(destination: ProgramKemitraanPageDestination()));

  openBinaLingkungan() => dispatch(NavigateToNextAction(destination: BinaLingkunganPageDestination()));

  openCsr() => dispatch(NavigateToNextAction(destination: CsrCompanyListPageDestination()));

}