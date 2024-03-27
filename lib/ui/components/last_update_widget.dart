import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class LastUpdateWidget extends StatelessWidget {

  final Store<AppState> store;
  final String pageName;

  LastUpdateWidget({
     @required
     this.store,
      @required
      this.pageName,
  });

  @override
  Widget build(BuildContext context) {
    try {
      final lastUpdate = store.state.lastUpdateState.lastUpdated.firstWhere((
          it) => it.pageName == pageName);
      return Center(
        child: Text(
          "Last Updated: ${lastUpdate.lastUpdated}",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),
        ),
      );
    } catch (ex) {
      return Center(
        child: Text(
          "Last Updated: -",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),
        ),
      );
    }
  }
}
