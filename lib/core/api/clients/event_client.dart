import 'package:bumn_eid/core/api/api_client.dart';
import 'package:bumn_eid/core/api/response/event/event_all_response.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/event/event_item.dart';
import 'package:flutter/material.dart';

class EventClient extends ApiClient {
  final SessionController sessionController;

  EventClient({
    @required String tempUrl,
    @required String baseUrl,
    @required Logger logger,
    @required this.sessionController
  }) : super(tempUrl, baseUrl, logger);

  Future<List<EventItem>> fetchAllEvent() async {
    final String endpoint = 'event/all';

    final EventAllResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: EventAllResponse.serializer);

    return response.data;
  }

}
