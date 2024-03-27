import 'package:bumn_eid/core/api/api_client.dart';
import 'package:bumn_eid/core/api/response/last_update/last_update_response.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/common/last_update.dart';
import 'package:flutter/material.dart';

class LastUpdateClient extends ApiClient {
  final SessionController sessionController;

  LastUpdateClient({
    @required String tempUrl,
    @required String baseUrl,
    @required Logger logger,
    @required this.sessionController
  }) : super(tempUrl, baseUrl, logger);

  Future<List<LastUpdate>> fetchLastUpdate() async {
    final String endpoint = 'page/lastupdate';

    final LastUpdateResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: LastUpdateResponse.serializer);

    return response.data;
  }

}
