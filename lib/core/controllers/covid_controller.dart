import 'package:bumn_eid/core/api/clients/covid_client.dart';
import 'package:bumn_eid/core/api/response/covid/covid_company_list_response.dart';
import 'package:bumn_eid/core/api/response/covid/covid_detail_response.dart';
import 'package:bumn_eid/core/api/response/covid/covid_summary_response.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/covid/covid_cluster.dart';
import 'package:bumn_eid/core/models/covid/covid_company_list.dart';
import 'package:bumn_eid/core/models/covid/covid_kelas.dart';
import 'package:bumn_eid/core/models/covid/covid_summary.dart';
import 'package:flutter/material.dart';

class CovidController {
  final CovidClient covidClient;
  final Logger logger;

  CovidController({
    @required this.covidClient,
    @required this.logger,
  });

  Future<CovidSummaryResponse> fetchCovidSummary() {
    return covidClient.fetchCovidSummary();
  }

  Future<List<CovidCompanyList>> fetchCompanies() {
    return covidClient.fetchCompanies();
  }

  Future<List<CovidKelas>> fetchCovidKelas() {
    return covidClient.fetchCovidKelas();
  }

  Future<List<CovidCompanyList>> fetchCompaniesByClass({@required String kelas}) {
    return covidClient.fetchCompaniesByClass(kelas: kelas);
  }

  Future<List<CovidCluster>> fetchCovidCluster() {
    return covidClient.fetchCovidCluster();
  }

  Future<CovidCompanyListResponse> fetchCompaniesByCluster({@required String cluster, String date}) {
    return covidClient.fetchCompaniesByCluster(cluster: cluster, date: date);
  }

  Future<CovidDetailResponse> fetchCompanyById({@required String companyId}) {
    return covidClient.fetchCovidByCompany(companyId: companyId);
  }
  
}