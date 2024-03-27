import 'package:bumn_eid/core/api/api_client.dart';
import 'package:bumn_eid/core/api/response/csr/bl_area_response.dart';
import 'package:bumn_eid/core/api/response/csr/bl_response.dart';
import 'package:bumn_eid/core/api/response/csr/csr_company_response.dart';
import 'package:bumn_eid/core/api/response/csr/csr_response.dart';
import 'package:bumn_eid/core/api/response/csr/jumlah_mitra_response.dart';
import 'package:bumn_eid/core/api/response/csr/penyebaran_bl_response.dart';
import 'package:bumn_eid/core/api/response/csr/penyebaran_pk_response.dart';
import 'package:bumn_eid/core/api/response/csr/pk_area_response.dart';
import 'package:bumn_eid/core/api/response/csr/pk_company_response.dart';
import 'package:bumn_eid/core/api/response/csr/pk_response.dart';
import 'package:bumn_eid/core/api/response/csr/pkbl_response.dart';
import 'package:bumn_eid/core/api/response/csr/sektor_pk_response.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/csr/bl_item.dart';
import 'package:bumn_eid/core/models/csr/bl_item_area.dart';
import 'package:bumn_eid/core/models/csr/csr_company.dart';
import 'package:bumn_eid/core/models/csr/csr_item.dart';
import 'package:bumn_eid/core/models/csr/jumlah_mitra.dart';
import 'package:bumn_eid/core/models/csr/pk_item.dart';
import 'package:bumn_eid/core/models/csr/pk_item_area.dart';
import 'package:bumn_eid/core/models/csr/pk_item_company.dart';
import 'package:bumn_eid/core/models/csr/pkbl.dart';
import 'package:bumn_eid/core/models/csr/sektor_pk.dart';
import 'package:flutter/material.dart';

class CsrClient extends ApiClient {
  final SessionController sessionController;

  CsrClient(
      {@required String tempUrl,
      @required String baseUrl,
      @required Logger logger,
      @required this.sessionController})
      : super(tempUrl, baseUrl, logger);

  Future<List<Pkbl>> fetchPkblSummary() async {
    final String endpoint = 'pkbl/grafik/summaries/tigaTahun';

    PkblResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: PkblResponse.serializer);

    return response.data;
  }

  Future<List<PkItem>> fetchPkList() async {
    final String endpoint = 'pkbl/pk/tigaTahun';

    PkResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: PkResponse.serializer);

    return response.data;
  }

  Future<List<SektorPk>> fetchSektorPkList() async {
    final String endpoint = 'pkbl/pk/by/sektor/total/sektor/tigaTahun';

    SektorPkResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: SektorPkResponse.serializer);

    return response.data;
  }

  Future<List<PkItem>> fetchPenyebaranPkList() async {
    final String endpoint = 'pkbl/pk/penyebaran/by/propinsi/tigaTahun';

    PkResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: PkResponse.serializer);

    return response.data;
  }

  Future<List<PkItem>> fetchPenyebaranWilayahPkList(
      {@required String provinsi, @required String tahun}) async {
    final String endpoint =
        'pkbl/pk/penyebaran/by/propinsi/tahun/$tahun/propinsi/$provinsi';

    PkResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: PkResponse.serializer);

    return response.data;
  }

  Future<List<BlItem>> fetchPenyebaranBlList() async {
    final String endpoint = 'pkbl/bl/penyebaran/by/propinsi/tigaTahun';

    BlResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: BlResponse.serializer);

    return response.data;
  }

  Future<List<BlItem>> fetchPenyebaranWilayahBlList(
      {@required String provinsi, @required String tahun}) async {
    final String endpoint =
        'pkbl/bl/penyebaran/by/propinsi/tahun/$tahun/propinsi/$provinsi';

    BlResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: BlResponse.serializer);

    return response.data;
  }

  Future<List<JumlahMitra>> fetchJumlahMitra() async {
    final String endpoint = 'pkbl/pk/mitra/mitra/by/sektor/tigaTahun';

    JumlahMitraResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: JumlahMitraResponse.serializer);

    return response.data;
  }

  Future<List<BlItem>> fetchJenisBantuan() async {
    final String endpoint = 'pkbl/bl/by/jenisBantuan/bantuan/tigaTahun/';

    BlResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: BlResponse.serializer);

    return response.data;
  }

  Future<List<CsrItem>> fetchCsrDetail(
      {@required String tahun, @required String companyId}) async {
    final String endpoint = 'pkbl/csr/tahun/$tahun/bumn/$companyId';

    CsrResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: CsrResponse.serializer);

    return response.data;
  }

  Future<List<CsrItem>> fetchCsrAll({@required String tahun}) async {
    final String endpoint = 'pkbl/csr/tahun/$tahun/';

    CsrResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: CsrResponse.serializer);

    return response.data;
  }

  Future<List<CsrCompany>> fetchPkCompanies() async {
    final String endpoint = 'pkbl/company/list';

    CsrCompanyResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: CsrCompanyResponse.serializer);

    return response.data;
  }

  Future<List<PkItemCompany>> fetchPkItemByCompany(
      {@required String companyId}) async {
    final String endpoint =
        'pkbl/pk/penyebaran/all/province/tigaTahun/by/company/$companyId';

    PkCompanyResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: PkCompanyResponse.serializer);

    return response.data;
  }

  Future<List<PkItemArea>> fetchPkItemByArea(
      {@required String companyId, @required String provinsi}) async {
    final String endpoint =
        'pkbl/pk/penyebaran/tigaTahun/by/company/$companyId/by/province/$provinsi';

    PkAreaResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: PkAreaResponse.serializer);

    return response.data;
  }

  Future<List<CsrCompany>> fetchBlCompanies() async {
    final String endpoint = 'pkbl/csr/company/list/';

    CsrCompanyResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: CsrCompanyResponse.serializer);

    return response.data;
  }

  Future<List<BlItem>> fetchBLByCompany({@required String jenis}) async {
    final String endpoint = 'pkbl/jenisBantuan/by/company/tigaTahun/$jenis';

    PenyebaranBlResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: PenyebaranBlResponse.serializer);

    return response.data;
  }

  Future<List<BlItem>> fetchBLByArea({@required String jenis}) async {
    final String endpoint = 'pkbl/jenisBantuan/by/area/tigaTahun/$jenis';

    PenyebaranBlResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: PenyebaranBlResponse.serializer);

    return response.data;
  }

  Future<List<PkItem>> fetchPkByCompany({@required String sektor}) async {
    final String endpoint = 'pkbl/mitraBinaan/by/company/tigaTahun/$sektor';

    PenyebaranPkResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: PenyebaranPkResponse.serializer);

    return response.data;
  }

  Future<List<PkItem>> fetchPkByArea({@required String sektor}) async {
    final String endpoint = 'pkbl/mitraBinaan/by/area/tigaTahun/$sektor';

    PenyebaranPkResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: PenyebaranPkResponse.serializer);

    return response.data;
  }

  Future<List<PkItemCompany>> fetchBlItemByCompany(
      {@required String companyId}) async {
    final String endpoint =
        'pkbl/bl/penyebaran/all/province/tigaTahun/by/company/$companyId';

    PkCompanyResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: PkCompanyResponse.serializer);

    return response.data;
  }

  Future<List<BlItemArea>> fetchBlItemByArea(
      {@required String companyId, @required String provinsi}) async {
    final String endpoint =
        'pkbl/bl/penyebaran/tigaTahun/by/company/$companyId/by/province/$provinsi';

    BlAreaResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: BlAreaResponse.serializer);

    return response.data;
  }
}
