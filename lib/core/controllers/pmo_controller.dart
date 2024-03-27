import 'package:bumn_eid/core/api/clients/pmo_client.dart';
import 'package:bumn_eid/core/api/response/pmo/project_detail_response.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/pmo/project_item.dart';
import 'package:flutter/material.dart';

class PMOController {
  final PMOClient pmoClient;
  final Logger logger;

  PMOController({
    @required this.pmoClient,
    @required this.logger,
  });

  Future<List<ProjectItem>> fetchAllProjects() {
    return pmoClient.fetchAllProjects();
  }

  Future<ProjectDetailResponse> fetchProjectDetail({@required int id}) {
    return pmoClient.fetchProjectDetail(id: id);
  }

}