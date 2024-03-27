import 'package:bumn_eid/core/api/clients/company_client.dart';
import 'package:bumn_eid/core/api/clients/covid_client.dart';
import 'package:bumn_eid/core/api/clients/csr_client.dart';
import 'package:bumn_eid/core/api/clients/event_client.dart';
import 'package:bumn_eid/core/api/clients/finance_client.dart';
import 'package:bumn_eid/core/api/clients/hc_client.dart';
import 'package:bumn_eid/core/api/clients/jenis_client.dart';
import 'package:bumn_eid/core/api/clients/last_update_client.dart';
import 'package:bumn_eid/core/api/clients/legal_client.dart';
import 'package:bumn_eid/core/api/clients/pmo_client.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:flutter/material.dart';

class Api {
  final CompanyClient companyClient;
  final JenisClient jenisClient;
  final FinanceClient financeClient;
  final LegalClient legalClient;
  final CsrClient csrClient;
  final HcClient hcClient;
  final EventClient eventClient;
  final PMOClient pmoClient;
  final LastUpdateClient lastUpdateClient;
  final CovidClient covidClient;

  Api({
    @required this.companyClient,
    @required this.jenisClient,
    @required this.financeClient,
    @required this.legalClient,
    @required this.csrClient,
    @required this.hcClient,
    @required this.eventClient,
    @required this.pmoClient,
    @required this.lastUpdateClient,
    @required this.covidClient,
  });

  factory Api.create({
    @required String tempUrl,
    @required String baseUrl,
    @required Logger logger,
    @required SessionController sessionController,
  }) {
    return Api(
        companyClient: CompanyClient(
            tempUrl: tempUrl,
            baseUrl: baseUrl,
            logger: logger,
            sessionController: sessionController
        ),
        jenisClient: JenisClient(
            tempUrl: tempUrl,
            baseUrl: baseUrl,
            logger: logger,
            sessionController: sessionController
        ),
        financeClient: FinanceClient(
            tempUrl: tempUrl,
            baseUrl: baseUrl,
            logger: logger,
            sessionController: sessionController
        ),
        legalClient: LegalClient(
          tempUrl: tempUrl,
          baseUrl: baseUrl,
          logger: logger,
          sessionController: sessionController
        ),
        csrClient: CsrClient(
          tempUrl: tempUrl,
          baseUrl: baseUrl,
          logger: logger,
          sessionController: sessionController
        ),
        hcClient: HcClient(
            tempUrl: tempUrl,
            baseUrl: baseUrl,
            logger: logger,
            sessionController: sessionController
        ),
        eventClient: EventClient(
            tempUrl: tempUrl,
            baseUrl: baseUrl,
            logger: logger,
            sessionController: sessionController
        ),
        pmoClient: PMOClient(
            tempUrl: tempUrl,
            baseUrl: baseUrl,
            logger: logger,
            sessionController: sessionController
        ),
        lastUpdateClient: LastUpdateClient(
            tempUrl: tempUrl,
            baseUrl: baseUrl,
            logger: logger,
            sessionController: sessionController
        ),
        covidClient: CovidClient(
            tempUrl: tempUrl,
            baseUrl: baseUrl,
            logger: logger,
            sessionController: sessionController
        ),
    );
  }
}
