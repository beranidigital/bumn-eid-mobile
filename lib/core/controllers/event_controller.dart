import 'package:bumn_eid/core/api/clients/event_client.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/event/event_item.dart';
import 'package:flutter/material.dart';

class EventController {
  final EventClient eventClient;
  final Logger logger;

  EventController({
    @required this.eventClient,
    @required this.logger,
  });

  Future<List<EventItem>> fetchAllEvent() {
    return eventClient.fetchAllEvent();
  }

}