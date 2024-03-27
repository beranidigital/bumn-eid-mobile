import 'package:bumn_eid/core/api/api_client.dart';
import 'package:bumn_eid/core/api/response/covid/covid_cluster_response.dart';
import 'package:bumn_eid/core/api/response/covid/covid_company_list_response.dart';
import 'package:bumn_eid/core/api/response/covid/covid_detail_response.dart';
import 'package:bumn_eid/core/api/response/covid/covid_kelas_response.dart';
import 'package:bumn_eid/core/api/response/covid/covid_summary_response.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/covid/covid_cluster.dart';
import 'package:bumn_eid/core/models/covid/covid_company_list.dart';
import 'package:bumn_eid/core/models/covid/covid_kelas.dart';
import 'package:bumn_eid/core/models/covid/covid_summary.dart';
import 'package:flutter/material.dart';

class CovidClient extends ApiClient {
  final SessionController sessionController;

  CovidClient({
    @required String tempUrl,
    @required String baseUrl,
    @required Logger logger,
    @required this.sessionController
  }) : super(tempUrl, baseUrl, logger);

  Future<CovidSummaryResponse> fetchCovidSummary() async {
    final String endpoint = 'covid/show/summary/all/by/all/all';

    CovidSummaryResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: CovidSummaryResponse.serializer);

    return response;
  }

  Future<List<CovidCompanyList>> fetchCompanies() async {
    final String endpoint = 'covid/show/detail/covid/by/company/all';

    CovidCompanyListResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: CovidCompanyListResponse.serializer);

    return response.data;
  }

  Future<List<CovidKelas>> fetchCovidKelas() async {
    final String endpoint = 'covid/show/detail/covid/by/kelas/all';

    CovidKelasResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: CovidKelasResponse.serializer);

    return response.data;
  }

  Future<List<CovidCompanyList>> fetchCompaniesByClass({@required String kelas}) async {
    final String endpoint = 'covid/show/detail/covid/by/kelas/$kelas';

    CovidCompanyListResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: CovidCompanyListResponse.serializer);

    return response.data;
  }

  Future<List<CovidCluster>> fetchCovidCluster() async {
    final String endpoint = 'covid/show/detail/covid/by/cluster/all';

    CovidClusterResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: CovidClusterResponse.serializer);

    return response.data;
  }

  Future<CovidCompanyListResponse> fetchCompaniesByCluster({@required String cluster, String date}) async {
    String endpoint = 'covid/show/detail/covid/by/cluster/$cluster';
    final queryParams = date == null
        ? null
        : {
      "tanggal": date
    };

    CovidCompanyListResponse response = await get(
      queryParams: queryParams,
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: CovidCompanyListResponse.serializer);

    return response;
  }

  Future<CovidDetailResponse> fetchCovidByCompany({@required String companyId}) async {
    final String endpoint = 'covid/show/company/covid/by/company/$companyId';

    CovidDetailResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: CovidDetailResponse.serializer);

    return response;
  }

}
