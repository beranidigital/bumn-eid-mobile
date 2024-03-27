import 'package:bumn_eid/app/bumn_eid_app.dart';
import 'package:bumn_eid/core/controllers/kickoff_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/environment_config.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:redux/redux.dart';
import 'package:sentry/sentry.dart';

class BumnEidAppGraph extends Graph<BumnEidApp> {

  BumnEidAppGraph([Injector injector]) : super(injector);

  @override
  void inject(BumnEidApp subject) {
    subject.config = getDependency<EnvironmentConfig>();
    subject.store = getDependency<Store<AppState>>();
    subject.navigatorKey = getDependency<GlobalKey<NavigatorState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.kickOffController = getDependency<KickOffController>();
    subject.sentryClient = getDependency<SentryClient>();
  }

  // Inside this method, we register all the `BumnEidApp` dependencies:
  @override
  void register() {
  }
}
