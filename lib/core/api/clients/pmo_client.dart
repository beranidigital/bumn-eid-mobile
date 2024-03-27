import 'package:bumn_eid/core/api/api_client.dart';
import 'package:bumn_eid/core/api/response/pmo/project_all_response.dart';
import 'package:bumn_eid/core/api/response/pmo/project_detail_response.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/pmo/project_item.dart';
import 'package:flutter/material.dart';

class PMOClient extends ApiClient {
  final SessionController sessionController;

  PMOClient({
    @required String tempUrl,
    @required String baseUrl,
    @required Logger logger,
    @required this.sessionController
  }) : super(tempUrl, baseUrl, logger);

  Future<List<ProjectItem>> fetchAllProjects() async {
    final String endpoint = 'pmo/all/projects';

    final ProjectAllResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: ProjectAllResponse.serializer);

    return response.data;
  }

  Future<ProjectDetailResponse> fetchProjectDetail({@required int id}) async {
    final String endpoint = 'pmo/detail/projects/id/$id';

    final ProjectDetailResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: ProjectDetailResponse.serializer);

    return response;
  }

}
