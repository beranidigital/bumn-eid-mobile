import 'package:bumn_eid/core/api/api_client.dart';
import 'package:bumn_eid/core/api/response/legal/legal_response.dart';
import 'package:bumn_eid/core/api/response/legal/legal_summary_response.dart';
import 'package:bumn_eid/core/api/response/legal/single/legal_response_single.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/legal/legal_item.dart';
import 'package:bumn_eid/core/models/legal/legal_summary_data.dart';
import 'package:flutter/material.dart';

class LegalClient extends ApiClient {
  final SessionController sessionController;

  LegalClient(
      {@required String tempUrl,
      @required String baseUrl,
      @required Logger logger,
      @required this.sessionController})
      : super(tempUrl, baseUrl, logger);

  Future<List<LegalItem>> fetchLegalList() async {
    final String endpoint = 'api/legals';

    LegalResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: LegalResponse.serializer);

    return response.data;
  }

  Future<List<LegalItem>> fetchLegalByCategory(String category) async {
    final String endpoint = 'legal/new/detail/by/kategori';
    final params = {'arg': category};

    LegalResponse response = await get(
        endpoint: endpoint,
        queryParams: params,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: LegalResponse.serializer);

    return response.data;
  }

  Future<LegalSummaryData> fetchLegalSummary() async {
    final String endpoint = 'api/legals/summary';

    LegalSummaryResponse response = await get(
      endpoint: endpoint,
      token: sessionController.getToken(),
      // email: sessionController.getEmail(),
      serializer: LegalSummaryResponse.serializer,
    );

    return response.data;
  }

  Future<LegalItem> fetchLegalDetail(String id) async {
    final String endpoint = 'api/legals/$id';
    // final params = {'id_angka': id};

    LegalResponseSingle response = await get(
        endpoint: endpoint,
        // queryParams: params,
        token: sessionController.getToken(),
        // email: sessionController.getEmail(),
        serializer: LegalResponseSingle.serializer);

    return response.data;
  }
}
