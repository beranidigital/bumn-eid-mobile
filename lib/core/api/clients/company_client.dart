import 'dart:convert';

import 'package:bumn_eid/core/api/api_client.dart';
import 'package:bumn_eid/core/api/response/companies/company_detail_response.dart';
import 'package:bumn_eid/core/api/response/companies/dirkom_response.dart';
import 'package:bumn_eid/core/api/response/companies/summary_response.dart';
import 'package:bumn_eid/core/api/response/internal/employee_response.dart';
import 'package:bumn_eid/core/api/response/internal/summary_internal_response.dart';
import 'package:bumn_eid/core/api/response/sektor/sektor_response.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/models/business_portfolio/sektor.dart';
import 'package:bumn_eid/core/models/business_portfolio/summary.dart';
import 'package:bumn_eid/core/models/common/anak_perusahaan.dart';
import 'package:bumn_eid/core/models/hc/dirkom.dart';
import 'package:bumn_eid/core/models/internal/employee.dart';
import 'package:bumn_eid/core/models/internal/summary_internal.dart';
import 'package:bumn_eid/irwan_dev/hc/resources/const.dart';
import 'package:bumn_eid/irwan_dev/pen/models/dirkom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CompanyClient extends ApiClient {
  final SessionController sessionController;

  CompanyClient(
      {@required String tempUrl,
      @required String baseUrl,
      @required Logger logger,
      @required this.sessionController})
      : super(tempUrl, baseUrl, logger);

  Future<List<ProfilPerusahaan>> fetchProfilPerusahaan() async {
    final String endpoint = 'profile';

    return await getList(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: ProfilPerusahaan.serializer);
  }

  Future<ProfilPerusahaan> fetchCompany({@required String id}) async {
    final String endpoint = 'profile/$id';

    final CompanyDetailResponse result = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: CompanyDetailResponse.serializer);

    return result.data.first;
  }

  Future<List<Sektor>> fetchBpsSectorList() async {
    final String endpoint = 'filter/bps_sector';

    final SektorResponse result = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: SektorResponse.serializer);

    return result.data;
  }

  Future<List<ProfilPerusahaan>> fetchBpsSectorCompanies(
      {@required String sector}) async {
    final String endpoint = 'profile/bps_sector/$sector';

    final CompanyDetailResponse result = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: CompanyDetailResponse.serializer);

    return result.data;
  }

  Future<List<ProfilPerusahaan>> fetchClusterCompanies(
      {@required String cluster}) async {
    final String endpoint = 'profile/cluster/$cluster';

    final CompanyDetailResponse result = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: CompanyDetailResponse.serializer);

    return result.data;
  }

  Future<List<Dirkom>> fetchDirkom(
      {@required String companyId, @required String dirkomType}) async {
    final String endpoint = 'profile/dirkom/$dirkomType/$companyId';

    final DirkomResponse result = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: DirkomResponse.serializer);

    return result.data;
  }

  Future<List<DirkomPEN>> fetchDirkomData(
      {@required String companyId, @required String dirkomType}) async {
    final String endpoint =
        'https://eid.bumn.go.id/profile/dirkom/$dirkomType/$companyId';

    // final DirkomResponse result = await get(
    // endpoint: endpoint,
    // token: sessionController.getToken(),
    // email: sessionController.getEmail(),
    // serializer: DirkomResponse.serializer);

    final response = await http.get(endpoint, headers: Const.headers);

    var jsonObject = json.decode(response.body);
    var dataValue = (jsonObject as Map<String, dynamic>)['data'];

    List<DirkomPEN> data = [];

    if (response.statusCode == 200 || response.statusCode == 201) {
      for (int i = 0; i < dataValue.length; i++) {
        data.add(new DirkomPEN.fromMap(dataValue[i]));
      }
      return data;
    } else {
      return data;
    }
  }

  Future<List<AnakPerusahaan>> fetchAnakPerusahaan(
      {@required String companyId}) async {
    final String endpoint = 'anak';
    final queryParams = {"bumn_id": companyId};

    return await getList<AnakPerusahaan>(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        queryParams: queryParams,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: AnakPerusahaan.serializer);
  }

  Future<List<Summary>> fetchSectorSummary(
      {@required String sectorName}) async {
    final String endpoint =
        'grafik/finance/filter/by/sector/name/$sectorName/tigaTahun';

    final SummaryResponse result = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: SummaryResponse.serializer);

    return result.data;
  }

  Future<List<Summary>> fetchClusterSummary(
      {@required String clusterName}) async {
    final String endpoint =
        'grafik/finance/filter/by/cluster/name/$clusterName/tigaTahun';

    final SummaryResponse result = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: SummaryResponse.serializer);

    return result.data;
  }

  Future<List<Summary>> fetchWamenSummary({@required String wamen}) async {
    final String endpoint =
        'grafik/finance/filter/by/wamen/name/$wamen/tigaTahun';

    final SummaryResponse result = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: SummaryResponse.serializer);

    return result.data;
  }

  Future<List<Summary>> fetchKelasSummary({@required String kelasName}) async {
    final String endpoint =
        'grafik/finance/filter/by/kelas/name/$kelasName/tigaTahun';

    final SummaryResponse result = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: SummaryResponse.serializer);

    return result.data;
  }

  Future<SummaryInternal> fetchInternalSummary({
    String usia,
    String pendidikan,
    String agama,
    String statusNikah,
    String statusPegawai,
    String jenisKelamin,
  }) async {
    final String endpoint = 'api/internals/summary';

    final Map<String, String> params = {};
    if (usia != null) params['usia'] = usia;
    if (pendidikan != null) params['pendidikan'] = pendidikan;
    if (agama != null) params['agama'] = agama;
    if (statusNikah != null) params['status_nikah'] = statusNikah;
    if (statusPegawai != null) params['status_pegawai'] = statusPegawai;
    if (jenisKelamin != null) params['jenis_kelamin'] = jenisKelamin;

    final SummaryInternalResponse result = await get(
      endpoint: endpoint,
      queryParams: params,
      token: sessionController.getToken(),
      serializer: SummaryInternalResponse.serializer,
    );

    return result.data;
  }

  Future<List<Employee>> fetchInternalEmployees({
    String usia,
    String pendidikan,
    String agama,
    String statusNikah,
    String statusPegawai,
    String namaPegawai,
    String jenisKelamin,
    int page = 1,
  }) async {
    final String endpoint = 'api/internals/summary';

    final Map<String, String> params = {};
    if (usia != null) params['usia'] = usia;
    if (pendidikan != null) params['pendidikan'] = pendidikan;
    if (agama != null) params['agama'] = agama;
    if (statusNikah != null) params['status_nikah'] = statusNikah;
    if (statusPegawai != null) params['status_pegawai'] = statusPegawai;
    if (namaPegawai != null) params['pegawai_nama'] = namaPegawai;
    if (jenisKelamin != null) params['jenis_kelamin'] = jenisKelamin;
    if (page != null) params['page'] = page.toString();

    final EmployeeResponse result = await get(
      endpoint: endpoint,
      queryParams: params,
      token: sessionController.getToken(),
      serializer: EmployeeResponse.serializer,
    );

    return result.data;
  }
}
