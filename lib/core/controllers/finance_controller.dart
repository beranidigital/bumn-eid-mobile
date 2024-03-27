import 'package:bumn_eid/core/api/clients/finance_client.dart';
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

class FinanceController {
  final FinanceClient financeClient;
  final Logger logger;

  FinanceController({
    @required this.financeClient,
    @required this.logger,
  });

  Future<List<GrafikPosisiKeuangan>> fetchGrafikPosisiKeuangan() {
    return financeClient.fetchGrafikPosisiKeuangan();
  }

  Future<List<PosisiKeuangan>> fetchPosisiKeuangan({@required String jenisAkun, @required String tahun}) {
    return financeClient.fetchPosisiKeuangan(akunId: akunToCode(jenisAkun), tahun: tahun);
  }

  Future<List<GrafikLabaRugi>> fetchGrafikLabaRugi() {
    return financeClient.fetchGrafikLabaRugi();
  }

  Future<List<LabaRugi>> fetchLabaRugi({@required String jenisAkun, @required String tahun}) {
    return financeClient.fetchLabaRugi(akunId: akunLabaRugiToCode(jenisAkun), tahun: tahun);
  }

  Future<List<GrafikCapex>> fetchGrafikCapex() {
    return financeClient.fetchGrafikCapex();
  }

  Future<List<Capex>> fetchCapex({@required String tahun}) {
    return financeClient.fetchCapex(tahun: tahun);
  }

  Future<List<Revenue>> fetchRevenue({@required String tahun}) {
    return financeClient.fetchRevenue(tahun: tahun);
  }

  Future<List<SuspiDeni>> fetchSuspi({@required int kodeKategori}) {
    return financeClient.fetchSuspi(kodeKategori: kodeKategori);
  }

  Future<List<GrafikSuspi>> fetchGrafikSuspi() {
    return financeClient.fetchGrafikSuspi();
  }

  Future<List<Suspi>> fetchSuspiById({@required String id, @required String tahun}) {
    return financeClient.fetchSuspiById(id: id, tahun: tahun);
  }

  Future<List<Loan>> fetchLoan() {
    return financeClient.fetchLoan();
  }

  Future<List<Loan>> fetchLoanById({@required String id}) {
    return financeClient.fetchLoanById(id: id);
  }

  Future<List<ThirdPartyLoan>> fetchThirdPartyLoan() {
    return financeClient.fetchThirdPartyLoan();
  }

  Future<List<ThirdPartyLoan>> fetchThirdPartyLoanById({@required String id}) {
    return financeClient.fetchThirdPartyLoanById(id: id);
  }

  Future<List<Ebitda>> fetchEbitda({@required String tahun}) {
    return financeClient.fetchEbitda(tahun: tahun);
  }

  Future<List<GrafikAPBN>> fetchGrafikDividen() async {
    return financeClient.fetchGrafikDividen();
  }

  Future<List<Dividen>> fetchDividen({@required String tahun}) async {
    return financeClient.fetchDividen(tahun: tahun);
  }

  Future<List<GrafikAPBN>> fetchGrafikPajak() async {
    return financeClient.fetchGrafikPajak();
  }

  Future<List<Pajak>> fetchPajak({@required String tahun}) async {
    return financeClient.fetchPajak(tahun: tahun);
  }

  Future<List<GrafikAPBN>> fetchGrafikPnbp() async {
    return financeClient.fetchGrafikPnbp();
  }

  Future<List<Pnbp>> fetchPnbp({@required String tahun}) async {
    return financeClient.fetchPnbp(tahun: tahun);
  }

  Future<List<KinerjaPerusahaan>> fetchKinerjaPerusahaan({@required String id}) async {
    return financeClient.fetchKinerjaPerusahaan(id: id);
  }

  Future<List<PinjamanLain>> fetchPinjamanLain({@required String companyId, @required String tahun}) async {
    return financeClient.fetchPinjamanLain(companyId: companyId, tahun: tahun);
  }
}