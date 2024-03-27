import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class APBNActionMapper extends ActionMapper {

  APBNActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openSearchModal() => _featureNotAvailable();

  openDetailedPage({@required String jenisAkun}) {
    switch (jenisAkun) {
      case "dividen":
        openDividenPage();
        return;
      case "pnbp":
        openPnbpPage();
        return;
      case "pajak":
        openPajakPage();
        return;
      default:
        openDividenPage();
        return;
    }
  }

  openDividenPage() => dispatch(NavigateToNextAction(destination: DividenPageDestination()));
  
  openPajakPage() => dispatch(NavigateToNextAction(destination: PajakPageDestination()));
  
  openPnbpPage() => dispatch(NavigateToNextAction(destination: PnbpPageDestination()));

}