import 'dart:async';

import 'package:bumn_eid/app/bumn_eid_app.dart';
import 'package:bumn_eid/core/di/injector.dart' as Injector;
import 'package:bumn_eid/environment_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry/sentry.dart';

bool get isInDebugMode {
  return true;
  // Assume you're in production mode.
  bool inDebugMode = false;

  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code only sets `inDebugMode` to true
  // in a development environment.
  assert(inDebugMode = true);

  return inDebugMode;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var config = EnvironmentConfig(
      environment: Environment.staging,
      appName: "BUMN EID Staging",
      tempUrl: "https://silaba.bumn.go.id/service",
      apiUrl: "https://eid.bumn.go.id",
      oneSignalAppId: "c7c811a8-5250-4301-b4f0-15d52b5c8798");

  final SentryClient _sentry = SentryClient(
      dsn:
          "https://5e3c818b222b4a4ba92a65a0415d674c@o409589.ingest.sentry.io/5282444");

  Injector.inject(config, _sentry);

  // The `runZoned` captures errors and allows us to report them into our BE infrastructure
  // Taken from here: https://github.com/flutter/crashy/blob/master/lib/main.dart#L107
  runZoned<Future<Null>>(() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(
      BumnEidApp(),
    );
  }, onError: (error, stackTrace) {
    // Whenever an error occurs, call the `_reportError` function. This sends
    // Dart errors to the dev console or Sentry depending on the environment.
    _reportError(_sentry, error, stackTrace);
  });
}

Future<void> _reportError(
    SentryClient sentryClient, dynamic error, dynamic stackTrace) async {
  // Print the exception to the console.
  print('Caught error: $error');
  if (isInDebugMode) {
    // Print the full stacktrace in debug mode.
    print(stackTrace);
  } else {
    // Send the Exception and Stacktrace to Sentry in Production mode.
    sentryClient.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}
