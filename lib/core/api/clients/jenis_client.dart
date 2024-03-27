import 'package:bumn_eid/core/api/api_client.dart';
import 'package:bumn_eid/core/api/response/companies/summary_response.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/business_portfolio/grafik_jenis_perusahaan.dart';
import 'package:bumn_eid/core/models/business_portfolio/jenis_perusahaan.dart';
import 'package:bumn_eid/core/models/business_portfolio/summary.dart';
import 'package:flutter/material.dart';

class JenisClient extends ApiClient {
  final SessionController sessionController;

  JenisClient(
      {@required String tempUrl,
      @required String baseUrl,
      @required Logger logger,
      @required this.sessionController})
      : super(tempUrl, baseUrl, logger);

  Future<List<GrafikJenisPerusahaan>> fetchGrafikJenis({String tahun}) {
    final String endpoint = 'grafikjenis';
    final queryParams = tahun == null ? null : {"tahun": tahun};

    return getList<GrafikJenisPerusahaan>(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        queryParams: queryParams,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikJenisPerusahaan.serializer);
  }

  //TODO : Jenis Perusahaan
  Future<List<JenisPerusahaan>> fetchJenis({String tahun, String tipe}) {
    final String endpoint = 'jenis';
    final queryParams = tahun == null ? null : {"tahun": tahun, "tipe": tipe};

    return getList<JenisPerusahaan>(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        queryParams: queryParams,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: JenisPerusahaan.serializer);
  }

  Future<List<Summary>> fetchJenisSummary({@required String type}) async {
    final String endpoint =
        'grafik/finance/filter/by/ownership/name/$type/tigaTahun';

    final SummaryResponse result = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: SummaryResponse.serializer);

    return result.data;
  }
}
