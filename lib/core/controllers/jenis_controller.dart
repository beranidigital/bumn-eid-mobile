import 'package:bumn_eid/core/api/clients/jenis_client.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/business_portfolio/grafik_jenis_perusahaan.dart';
import 'package:bumn_eid/core/models/business_portfolio/jenis_perusahaan.dart';
import 'package:bumn_eid/core/models/business_portfolio/summary.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:flutter/material.dart';

class JenisController {
  final JenisClient jenisClient;
  final Logger logger;

  JenisController({
    @required this.jenisClient,
    @required this.logger,
  });

  Future<List<GrafikJenisPerusahaan>> fetchGrafikJenis(
      {String tahun}) {
    return jenisClient.fetchGrafikJenis(tahun: tahun);
  }

  Future<List<JenisPerusahaan>> fetchJenis({@required String jenisBumn}) {
    return jenisClient.fetchJenis(tahun: Constants.latestDataYear, tipe: jenisBumnToCode(jenisBumn));
  }

  Future<List<Summary>> fetchJenisSummary({@required String type}) {
    return jenisClient.fetchJenisSummary(type: type);
  }
}