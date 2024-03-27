import 'package:bumn_eid/core/api/api_client.dart';
import 'package:bumn_eid/core/api/response/companies/kinerja_perusahaan_response.dart';
import 'package:bumn_eid/core/api/response/finance/grafik_suspi_response.dart';
import 'package:bumn_eid/core/api/response/finance/loan_response.dart';
import 'package:bumn_eid/core/api/response/finance/suspi_response.dart';
import 'package:bumn_eid/core/api/response/finance/third_party_loan_response.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/finance/capex.dart';
import 'package:bumn_eid/core/models/finance/dividen.dart';
import 'package:bumn_eid/core/models/finance/ebitda.dart';
import 'package:bumn_eid/core/models/business_portfolio/grafik_apbn.dart';
import 'package:bumn_eid/core/models/finance/grafik_capex.dart';
import 'package:bumn_eid/core/models/finance/grafik_laba_rugi.dart';
import 'package:bumn_eid/core/models/finance/grafik_posisi_keuangan.dart';
import 'package:bumn_eid/core/models/common/kinerja_perusahaan.dart';
import 'package:bumn_eid/core/models/finance/grafik_suspi.dart';
import 'package:bumn_eid/core/models/finance/laba_rugi.dart';
import 'package:bumn_eid/core/models/finance/loan.dart';
import 'package:bumn_eid/core/models/finance/pajak.dart';
import 'package:bumn_eid/core/models/finance/pinjaman_lain.dart';
import 'package:bumn_eid/core/models/finance/pnbp.dart';
import 'package:bumn_eid/core/models/finance/posisi_keuangan.dart';
import 'package:bumn_eid/core/models/finance/revenue.dart';
import 'package:bumn_eid/core/models/finance/suspi.dart';
import 'package:bumn_eid/core/models/finance/suspi_deni.dart';
import 'package:bumn_eid/core/models/finance/third_party_loan.dart';
import 'package:flutter/material.dart';

class FinanceClient extends ApiClient {
  final SessionController sessionController;

  FinanceClient({
    @required String tempUrl,
    @required String baseUrl,
    @required Logger logger,
    @required this.sessionController
  }) : super(tempUrl, baseUrl, logger);

  Future<List<GrafikPosisiKeuangan>> fetchGrafikPosisiKeuangan() async {
    final String endpoint = 'grafikpk';

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: GrafikPosisiKeuangan.serializer);
  }

  Future<List<PosisiKeuangan>> fetchPosisiKeuangan({@required String akunId, @required String tahun}) async {
    final String endpoint = 'posisikeuangan';
    final queryParams = {
      "tahun" : tahun,
      "jenis_akun_id": akunId
    };

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        queryParams: queryParams,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: PosisiKeuangan.serializer);
  }

  Future<List<GrafikLabaRugi>> fetchGrafikLabaRugi() async {
    final String endpoint = 'grafiklr';

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: GrafikLabaRugi.serializer);
  }

  Future<List<LabaRugi>> fetchLabaRugi({@required String akunId, @required String tahun}) async {
    final String endpoint = 'labarugi';
    final queryParams = {
      "tahun" : tahun,
      "jenis_akun_id": akunId
    };

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        queryParams: queryParams,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: LabaRugi.serializer);
  }

  Future<List<GrafikCapex>> fetchGrafikCapex() async {
    final String endpoint = 'grafikcapex';

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: GrafikCapex.serializer);
  }

  Future<List<Capex>> fetchCapex({@required String tahun}) async {
    final String endpoint = 'capex';
    final queryParams = {
      "tahun" : tahun,
    };

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        queryParams: queryParams,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: Capex.serializer);
  }

  Future<List<Revenue>> fetchRevenue({@required String tahun}) async {
    final String endpoint = 'revenue';
    final queryParams = {
      "tahun" : tahun,
    };

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        queryParams: queryParams,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: Revenue.serializer);
  }

  Future<List<SuspiDeni>> fetchSuspi({@required int kodeKategori}) async {
    final String endpoint = 'detil/finance/detilLiabilitas/formatSilaba/TigaTahun/kategori/$kodeKategori';

    SuspiResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: SuspiResponse.serializer);

    return response.data;
  }

  Future<List<GrafikSuspi>> fetchGrafikSuspi() async {
    final String endpoint = 'grafik/finance/detilLiabilitas/formatSilaba/TigaTahun/all';

    GrafikSuspiResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: GrafikSuspiResponse.serializer);

    return response.data;
  }

  Future<List<Suspi>> fetchSuspiById({@required String tahun, @required String id}) async {
    final String endpoint = 'suspi';

    final queryParams = {
      "tahun": tahun,
      "bumn_id": id
    };

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        queryParams: queryParams,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: Suspi.serializer);
  }

  Future<List<Loan>> fetchLoan() async {
    final String endpoint = 'finance/hutang/all/tigatahun';

    final LoanResponse response =  await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: LoanResponse.serializer);

    return response.companies;
  }

  Future<List<Loan>> fetchLoanById({@required String id}) async {
    final String endpoint = 'finance/hutang/by/bumn/$id/tigaTahun';

    final LoanResponse response =  await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: LoanResponse.serializer);

    return response.companies;
  }

  Future<List<ThirdPartyLoan>> fetchThirdPartyLoan() async {
    final String endpoint = 'finance/danapihaktiga/all/tigatahun';

    final ThirdPartyLoanResponse response =  await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: ThirdPartyLoanResponse.serializer);

    return response.companies;
  }

  Future<List<ThirdPartyLoan>> fetchThirdPartyLoanById({@required String id}) async {
    final String endpoint = 'finance/danapihaktiga/by/bumn/$id/tigaTahun';

    final ThirdPartyLoanResponse response =  await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: ThirdPartyLoanResponse.serializer);

    return response.companies;
  }

  Future<List<Ebitda>> fetchEbitda({@required String tahun}) async {
    final String endpoint = 'ebitda';
    final queryParams = {
      "tahun" : tahun,
    };

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        queryParams: queryParams,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: Ebitda.serializer);
  }

  Future<List<GrafikAPBN>> fetchGrafikDividen() async {
    final String endpoint = 'grafikdividen';

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: GrafikAPBN.serializer);
  }

  Future<List<Dividen>> fetchDividen({@required String tahun}) async {
    final String endpoint = 'dividen';
    final queryParams = {
      "tahun" : tahun,
    };

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        queryParams: queryParams,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: Dividen.serializer);
  }

  Future<List<GrafikAPBN>> fetchGrafikPajak() async {
    final String endpoint = 'grafikpajak';

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: GrafikAPBN.serializer);
  }

  Future<List<Pajak>> fetchPajak({@required String tahun}) async {
    final String endpoint = 'pajak';
    final queryParams = {
      "tahun" : tahun,
    };

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        queryParams: queryParams,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: Pajak.serializer);
  }

  Future<List<GrafikAPBN>> fetchGrafikPnbp() async {
    final String endpoint = 'grafikpnbp';

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: GrafikAPBN.serializer);
  }

  Future<List<Pnbp>> fetchPnbp({@required String tahun}) async {
    final String endpoint = 'pnbp';
    final queryParams = {
      "tahun" : tahun,
    };

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        queryParams: queryParams,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: Pnbp.serializer);
  }

  Future<List<KinerjaPerusahaan>> fetchKinerjaPerusahaan({@required String id}) async {
    final String endpoint = 'finance/kinerja/bumn/$id';

    KinerjaPerusahaanResponse response =  await get(
        endpoint: endpoint,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: KinerjaPerusahaanResponse.serializer);

    return response.data;
  }

  Future<List<PinjamanLain>> fetchPinjamanLain({@required String companyId, @required String tahun}) async {
    final String endpoint = 'pinjaman';
    final queryParams = {
      "tahun" : tahun,
      "bumn_id": companyId
    };

    return await getList(
        endpoint: endpoint,
        preferredUrl: tempUrl,
        queryParams: queryParams,
        token: sessionController.getToken(), email: sessionController.getEmail(),
        serializer: PinjamanLain.serializer);
  }
}
