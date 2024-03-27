import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class FinancePageActionMapper extends ActionMapper {

  FinancePageActionMapper(Store<AppState> store) : super(store);

  openPosisiKeuangan() => dispatch(NavigateToNextAction(destination: PosisiKeuanganPageDestination()));

  openLabaRugi() => dispatch(NavigateToNextAction(destination: LabaRugiPageDestination()));

  openCapex() => dispatch(NavigateToNextAction(destination: CapexPageDestination()));

  openKontribusiApbn() => dispatch(NavigateToNextAction(destination: ApbnPageDestination()));

  openEbitda() => dispatch(NavigateToNextAction(destination: EbitdaPageDestination()));

  openRevenue() => dispatch(NavigateToNextAction(destination: RevenuePageDestination()));

  openLoan() => dispatch(NavigateToNextAction(destination: LoanMainPageDestination()));

}