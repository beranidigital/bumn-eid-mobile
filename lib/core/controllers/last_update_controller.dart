import 'package:bumn_eid/core/api/clients/last_update_client.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/common/last_update.dart';
import 'package:flutter/material.dart';

class LastUpdateController {
  final LastUpdateClient lastUpdateClient;
  final Logger logger;

  LastUpdateController({
    @required this.lastUpdateClient,
    @required this.logger,
  });

  Future<List<LastUpdate>> fetchLastUpdate() {
    return lastUpdateClient.fetchLastUpdate();
  }

}