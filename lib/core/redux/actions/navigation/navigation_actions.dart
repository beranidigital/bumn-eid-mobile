import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:flutter/material.dart';

class NavigateToNextAction {

  NavigateToNextAction({@required this.destination});

  final NavigationDestination destination;

}

class NavigateToNextAndReplaceAction {

  NavigateToNextAndReplaceAction({@required this.destination});

  final NavigationDestination destination;

}

class ShowDialogAction {

  ShowDialogAction({
    @required
    this.destination,
    this.barrierDismissible = true
  });

  final NavigationDestination destination;
  final bool barrierDismissible;

}

class ShowBottomSheetAction {

  ShowBottomSheetAction({
    @required
    this.destination,
    this.shape
  });

  final NavigationDestination destination;
  final ShapeBorder shape;

}

class NavigateBackAction {}
