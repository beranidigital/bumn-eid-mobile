import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/app/di/bumn_eid_app_graph.dart';
import 'package:bumn_eid/core/controllers/kickoff_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/environment_config.dart';
import 'package:bumn_eid/main_production.dart';
import 'package:bumn_eid/ui/pages/home/welcome_page/welcome_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sentry/sentry.dart';

// ignore: must_be_immutable
class BumnEidApp extends StatefulWidget with InjectableWidget {
  final BumnEidAppGraph _graph;

  //injected
  EnvironmentConfig config;

  //injected
  Store<AppState> store;

  //injected
  GlobalKey<NavigatorState> navigatorKey;

  //injected
  ColorPalette colorPalette;

  //injected
  KickOffController kickOffController;

  //injected
  SentryClient sentryClient;

  @override
  BumnEidAppGraph graph() => _graph;

  BumnEidApp([graph]) : this._graph = graph ?? BumnEidAppGraph() {
    setup();
  }

  @override
  _BumnEidAppState createState() => _BumnEidAppState();
}

class _BumnEidAppState extends State<BumnEidApp>
    with AfterLayoutMixin<BumnEidApp> {
  @override
  void initState() {
    super.initState();

    if (isInDebugMode) return;
    FlutterError.onError = (FlutterErrorDetails details) async {
      await widget.sentryClient.captureException(
        exception: details.exception,
        stackTrace: details.stack,
      );
    };
  }

  @override
  void afterFirstLayout(BuildContext context) {
    widget.kickOffController.start();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // locale: DevicePreview.locale(context), // Add the locale here
        // builder: DevicePreview.appBuilder,
        navigatorKey: widget.navigatorKey,
        title: widget.config.appName,
        theme: ThemeData(
          fontFamily: 'poppins',
        ),
        home: Scaffold(
          body: WelcomePage(),
        ),
      ),
    );
  }
}
