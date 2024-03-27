import 'package:bumn_eid/core/api/api.dart';
import 'package:bumn_eid/core/api/clients/auth_client.dart';
import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/controllers/event_controller.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/controllers/kickoff_controller.dart';
import 'package:bumn_eid/core/controllers/last_update_controller.dart';
import 'package:bumn_eid/core/controllers/legal_controller.dart';
import 'package:bumn_eid/core/controllers/one_signal_controller.dart';
import 'package:bumn_eid/core/controllers/pmo_controller.dart';
import 'package:bumn_eid/core/controllers/secure_storage_controller.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/redux/store.dart';
import 'package:bumn_eid/core/utils/utils.dart';
import 'package:bumn_eid/environment_config.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:redux/redux.dart';
import 'package:sentry/sentry.dart';

inject(EnvironmentConfig config, SentryClient sentryClient) {
  final Injector injector = Injector.appInstance;
  final logger = Logger.create();

  injector.registerSingleton<SentryClient>((_) => sentryClient);
  injector.registerSingleton<EnvironmentConfig>((_) => config);
  injector.registerSingleton<ColorPalette>((_) => ColorPalette());
  injector.registerSingleton<GlobalKey<NavigatorState>>(
      (_) => GlobalKey<NavigatorState>());
  injector.registerSingleton<Logger>((_) => logger);
  injector.registerSingleton<Utils>((_) => Utils());

  /// we don't want to inject auth client to the `api`, so it won't have cyclic dependency.
  final authClient = AuthClient(
      apiKey: config.tempUrl, baseUrl: config.apiUrl, logger: logger);

  injector.registerSingleton<SessionController>((injector) {
    return SessionController(
      authClient: authClient,
      logger: logger,
    );
  });

  injector.registerSingleton<SecureStorageController>(
      (_) => SecureStorageController());

  injector.registerSingleton<Api>((injector) {
    final logger = injector.getDependency<Logger>();
    final sessionController = injector.getDependency<SessionController>();
    return Api.create(
        tempUrl: config.tempUrl,
        baseUrl: config.apiUrl,
        logger: logger,
        sessionController: sessionController);
  });

  injector.registerSingleton<JenisController>((injector) {
    final api = injector.getDependency<Api>();
    return JenisController(
      jenisClient: api.jenisClient,
      logger: logger,
    );
  });

  injector.registerSingleton<FinanceController>((injector) {
    final api = injector.getDependency<Api>();
    return FinanceController(
      financeClient: api.financeClient,
      logger: logger,
    );
  });

  injector.registerSingleton<LegalController>((injector) {
    final api = injector.getDependency<Api>();
    return LegalController(
      legalClient: api.legalClient,
      logger: logger,
    );
  });

  injector.registerSingleton<CsrController>((injector) {
    final api = injector.getDependency<Api>();
    return CsrController(
      csrClient: api.csrClient,
      logger: logger,
    );
  });

  injector.registerSingleton<HcController>((injector) {
    final api = injector.getDependency<Api>();
    return HcController(
      hcClient: api.hcClient,
      logger: logger,
    );
  });

  injector.registerSingleton<EventController>((injector) {
    final api = injector.getDependency<Api>();
    return EventController(
      eventClient: api.eventClient,
      logger: logger,
    );
  });

  injector.registerSingleton<PMOController>((injector) {
    final api = injector.getDependency<Api>();
    return PMOController(
      pmoClient: api.pmoClient,
      logger: logger,
    );
  });

  injector.registerSingleton<LastUpdateController>((injector) {
    final api = injector.getDependency<Api>();
    return LastUpdateController(
      lastUpdateClient: api.lastUpdateClient,
      logger: logger,
    );
  });

  injector.registerSingleton<CovidController>((injector) {
    final api = injector.getDependency<Api>();
    return CovidController(
      covidClient: api.covidClient,
      logger: logger,
    );
  });

  // Make sure to create the Store in the end, as the Store creation relies on some dependencies registered above
  injector.registerSingleton<Store<AppState>>((_) => createStore());

  injector.registerSingleton<OneSignalController>(
      (_) => OneSignalController(oneSignalAppId: config.oneSignalAppId));

  injector.registerSingleton<KickOffController>((injector) {
    final store = injector.getDependency<Store<AppState>>();
    final secureStorageController =
        injector.getDependency<SecureStorageController>();
    final sessionController = injector.getDependency<SessionController>();
    final lastUpdateController = injector.getDependency<LastUpdateController>();
    final oneSignalController = injector.getDependency<OneSignalController>();
    return KickOffController(
      store: store,
      secureStorageController: secureStorageController,
      sessionController: sessionController,
      lastUpdateController: lastUpdateController,
      oneSignalController: oneSignalController,
    );
  });

  injector.registerSingleton<CompaniesController>((injector) {
    final store = injector.getDependency<Store<AppState>>();
    final logger = injector.getDependency<Logger>();
    final api = injector.getDependency<Api>();
    final secureStorageController =
        injector.getDependency<SecureStorageController>();
    return CompaniesController(
        store: store,
        logger: logger,
        companyClient: api.companyClient,
        lastUpdateClient: api.lastUpdateClient,
        secureStorageController: secureStorageController);
  });
}
