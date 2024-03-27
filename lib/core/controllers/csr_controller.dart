import 'package:bumn_eid/core/api/clients/csr_client.dart';
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

class CsrController {
  final CsrClient csrClient;
  final Logger logger;

  CsrController({
    @required this.csrClient,
    @required this.logger,
  });

  Future<List<Pkbl>> fetchPkblSummary() {
    return csrClient.fetchPkblSummary();
  }

  Future<List<PkItem>> fetchPkList() {
    return csrClient.fetchPkList();
  }

  Future<List<SektorPk>> fetchSektorPkList() {
    return csrClient.fetchSektorPkList();
  }

  Future<List<PkItem>> fetchPenyebaranPkList() {
    return csrClient.fetchPenyebaranPkList();
  }

  Future<List<PkItem>> fetchPenyebaranWilayahPkList(
      {@required String provinsi, @required String tahun}) {
    return csrClient.fetchPenyebaranWilayahPkList(
        provinsi: provinsi, tahun: tahun);
  }

  Future<List<BlItem>> fetchPenyebaranBlList() {
    return csrClient.fetchPenyebaranBlList();
  }

  Future<List<BlItem>> fetchPenyebaranWilayahBlList(
      {@required String provinsi, @required String tahun}) {
    return csrClient.fetchPenyebaranWilayahBlList(
        provinsi: provinsi, tahun: tahun);
  }

  Future<List<JumlahMitra>> fetchJumlahMitra() {
    return csrClient.fetchJumlahMitra();
  }

  Future<List<BlItem>> fetchJenisBantuan() {
    return csrClient.fetchJenisBantuan();
  }

  Future<List<CsrItem>> fetchCsrDetail(
      {@required String tahun, @required String companyId}) {
    return csrClient.fetchCsrDetail(tahun: tahun, companyId: companyId);
  }

  Future<List<CsrItem>> fetchCsrDetailAll({@required String tahun}) {
    return csrClient.fetchCsrAll(
      tahun: tahun,
    );
  }

  Future<List<CsrCompany>> fetchPkCompanies() {
    return csrClient.fetchPkCompanies();
  }

  Future<List<PkItemCompany>> fetchPkItemByCompany(
      {@required String companyId}) {
    return csrClient.fetchPkItemByCompany(companyId: companyId);
  }

  Future<List<PkItemArea>> fetchPkItemByArea(
      {@required String companyId, @required String provinsi}) {
    return csrClient.fetchPkItemByArea(
        companyId: companyId, provinsi: provinsi);
  }

  Future<List<CsrCompany>> fetchBlCompanies() {
    return csrClient.fetchBlCompanies();
  }

  Future<List<PkItem>> fetchPkByCompany({@required String sektor}) {
    return csrClient.fetchPkByCompany(sektor: sektor);
  }

  Future<List<PkItem>> fetchPkByArea({@required String sektor}) {
    return csrClient.fetchPkByArea(sektor: sektor);
  }

  Future<List<BlItem>> fetchBlByCompany({@required String jenis}) {
    return csrClient.fetchBLByCompany(jenis: jenis);
  }

  Future<List<BlItem>> fetchBlByArea({@required String jenis}) {
    return csrClient.fetchBLByArea(jenis: jenis);
  }

  Future<List<PkItemCompany>> fetchBlItemByCompany(
      {@required String companyId}) {
    return csrClient.fetchBlItemByCompany(companyId: companyId);
  }

  Future<List<BlItemArea>> fetchBlItemByArea(
      {@required String companyId, @required String provinsi}) {
    return csrClient.fetchBlItemByArea(
        companyId: companyId, provinsi: provinsi);
  }
}
