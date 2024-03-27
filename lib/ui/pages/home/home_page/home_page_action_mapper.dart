import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:redux/redux.dart';

class HomePageActionMapper extends ActionMapper {
  HomePageActionMapper(Store store) : super(store);

  featureNotAvailable() => dispatch(
      ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openPosisiKeuangan() => dispatch(
      NavigateToNextAction(destination: PosisiKeuanganPageDestination()));

  goToBusinessPortfolio() => dispatch(
      NavigateToNextAction(destination: BusinessPortfolioPageDestination()));

  goToFinance() =>
      dispatch(NavigateToNextAction(destination: FinancePageDestination()));

  goToCSR() =>
      dispatch(NavigateToNextAction(destination: CsrPageDestination()));

  goToLegal() => dispatch(
      NavigateToNextAction(destination: LegalSummaryPageDestination()));

  goToEvent() =>
      dispatch(NavigateToNextAction(destination: EventPageDestination()));

  goToHumanCapital() =>
      dispatch(NavigateToNextAction(destination: HcPageDestination()));

  goToPMO() =>
      dispatch(NavigateToNextAction(destination: PMOPageDestination()));

  goToCovid() =>
      dispatch(NavigateToNextAction(destination: CovidPageDestination()));

  logOutUser() =>
      dispatch(ShowDialogAction(destination: LogoutDestination(store: store)));
}
