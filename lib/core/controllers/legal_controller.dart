import 'package:bumn_eid/core/api/clients/legal_client.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/legal/legal_item.dart';
import 'package:bumn_eid/core/models/legal/legal_summary_data.dart';
import 'package:flutter/material.dart';

class LegalController {
  final LegalClient legalClient;
  final Logger logger;

  LegalController({
    @required this.legalClient,
    @required this.logger,
  });

  Future<List<LegalItem>> fetchLegalList() {
    return legalClient.fetchLegalList();
  }

  Future<List<LegalItem>> fetchLegalByCategory(String category) {
    return legalClient.fetchLegalByCategory(category);
  }

  Future<LegalItem> fetchLegalDetail(String id) {
    return legalClient.fetchLegalDetail(id);
  }

  Future<LegalSummaryData> fetchLegalSummary() {
    return legalClient.fetchLegalSummary();
  }
}
