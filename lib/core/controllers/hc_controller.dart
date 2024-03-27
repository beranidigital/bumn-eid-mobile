import 'package:bumn_eid/core/api/clients/hc_client.dart';
import 'package:bumn_eid/core/api/response/hc/bod1_talent_response.dart';
import 'package:bumn_eid/core/api/response/hc/bod_potret_talent_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_bod_cluster_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_bod_kelas_detailed_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_bod_kelas_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_bod_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_dewan_cluster_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_dewan_grouped_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_dewan_kelas_detailed_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_dewan_kelas_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_dewan_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_potret_tugas_detailed_response.dart';
import 'package:bumn_eid/core/api/response/hc/search_item_response.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/common/anak_perusahaan_deni.dart';
import 'package:bumn_eid/core/models/common/cucu_perusahaan_deni.dart';
import 'package:bumn_eid/core/models/hc/anggaran.dart';
import 'package:bumn_eid/core/models/hc/bod1_class.dart';
import 'package:bumn_eid/core/models/hc/bod1_cluster.dart';
import 'package:bumn_eid/core/models/hc/bod1_company.dart';
import 'package:bumn_eid/core/models/hc/bod1_profile.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent.dart';
import 'package:bumn_eid/core/models/hc/bod_talent.dart';
import 'package:bumn_eid/core/models/hc/dekom_detailed_item.dart';
import 'package:bumn_eid/core/models/hc/drop_talent_item.dart';
import 'package:bumn_eid/core/models/hc/grafik_employee_age.dart';
import 'package:bumn_eid/core/models/hc/grafik_employee_demografi.dart';
import 'package:bumn_eid/core/models/hc/grafik_employee_education.dart';
import 'package:bumn_eid/core/models/hc/grafik_employee_gender.dart';
import 'package:bumn_eid/core/models/hc/grafik_potret_kerja.dart';
import 'package:bumn_eid/core/models/hc/hc_company.dart';
import 'package:bumn_eid/core/models/hc/hc_summary.dart';
import 'package:bumn_eid/core/models/hc/talent_detail.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_by_class.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_by_cluster.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_by_company.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_item.dart';
import 'package:flutter/material.dart';

class HcController {
  final HcClient hcClient;
  final Logger logger;

  HcController({
    @required this.hcClient,
    @required this.logger,
  });

  Future<GrafikDewanResponse> fetchGrafikKomposisiDewan() {
    return hcClient.fetchGrafikKomposisiDewan();
  }

  Future<GrafikBODResponse> fetchGrafikKomposisiBOD() {
    return hcClient.fetchGrafikKomposisiBOD();
  }

  Future<GrafikDewanGroupedResponse> fetchGrafikKomposisiDewanKementrian() {
    return hcClient.fetchGrafikKomposisiDewanGrouped(group: "Kementerian atau Lembaga");
  }

  Future<GrafikDewanGroupedResponse> fetchGrafikKomposisiDewanOrmas() {
    return hcClient.fetchGrafikKomposisiDewanGrouped(group: "Ormas dan Lainnya");
  }

  Future<GrafikDewanGroupedResponse> fetchGrafikKomposisiDewanProfesional() {
    return hcClient.fetchGrafikKomposisiDewanGrouped(group: "Profesional Korporasi");
  }

  Future<GrafikDewanClusterResponse> fetchGrafikKomposisiDewanCluster() {
    return hcClient.fetchGrafikKomposisiCluster();
  }

  Future<GrafikDewanClusterResponse> fetchGrafikKomposisiDewanWamen({@required String wamen}) {
    return hcClient.fetchGrafikKomposisiWamen(wamen: wamen);
  }

  Future<GrafikDewanKelasResponse> fetchGrafikKomposisiKelas() {
    return hcClient.fetchGrafikKomposisiKelas();
  }

  Future<GrafikDewanKelasDetailedResponse> fetchGrafikKomposisiKelasDetailed({@required String kelas}) {
    return hcClient.fetchGrafikKomposisiKelasDetailed(kelas: kelas);
  }

  Future<GrafikPotretTugas> fetchGrafikPotretTugas({@required bool now}) {
    return hcClient.fetchGrafikPotretTugas(now: now);
  }

  Future<GrafikPotretTugasDetailedResponse> fetchGrafikPotretTugasDetailed({@required int range, @required bool now}) {
    return hcClient.fetchGrafikPotretTugasDetailed(range: range, now: now);
  }

  Future<List<GrafikEmployeeDemografi>> fetchEmployeeDemografi({@required String companyId}) {
    return hcClient.fetchEmployeeDemografi(companyId: companyId);
  }

  Future<List<GrafikEmployeeEducation>> fetchEmployeeEducation({@required String companyId}) {
    return hcClient.fetchEmployeeEducation(companyId: companyId);
  }

  Future<List<GrafikEmployeeGender>> fetchEmployeeGender({@required String companyId}) {
    return hcClient.fetchEmployeeGender(companyId: companyId);
  }

  Future<List<GrafikEmployeeAge>> fetchEmployeeAge({@required String companyId}) {
    return hcClient.fetchEmployeeAge(companyId: companyId);
  }

  Future<GrafikBODKelasResponse> fetchGrafikKomposisiKelasBod() {
    return hcClient.fetchGrafikKomposisiKelasBod();
  }

  Future<GrafikBODKelasDetailedResponse> fetchGrafikKomposisiKelasBodDetailed({@required String kelas}) {
    return hcClient.fetchGrafikKomposisiKelasDetailedBod(kelas: kelas);
  }

  Future<GrafikBODClusterResponse> fetchGrafikBODCluster() {
    return hcClient.fetchGrafikBodCluster();
  }

  Future<GrafikBODClusterResponse> fetchGrafikBODWamen({@required String wamen}) {
    return hcClient.fetchGrafikBodWamen(wamen: wamen);
  }

  Future<GrafikPotretTugas> fetchGrafikPotretTugasDireksi({@required bool now}) {
    return hcClient.fetchGrafikPotretTugasDireksi(now: now);
  }

  Future<GrafikPotretTugasDetailedResponse> fetchGrafikPotretTugasDireksiDetailed({@required int range, @required bool now}) {
    return hcClient.fetchGrafikPotretTugasDireksiDetailed(range: range, now: now);
  }

  Future<Map> fetchTalentFungsi() {
    return hcClient.fetchTalentFungsi();
  }

  Future<List<BODTalent>> fetchTalent({String kelas, String cluster, String jabatan}) {
    return hcClient.fetchTalent(kelas: kelas, cluster: cluster, jabatan: jabatan);
  }

  Future<TalentDetail> fetchTalentDetail({@required int id}) {
    return hcClient.fetchTalentDetail(id: id);
  }

  Future<BODPotretTalentResponse> fetchPotretTalentDetail({@required int id, @required bool now}) {
    return hcClient.fetchPotretTalentDetail(id: id, now: now);
  }

  Future<HcSummary> fetchHcSummary({String filter, String query}) {
    return hcClient.fetchHcSummary(filter: filter, query: query);
  }

  Future<HcSummary> fetchHcSummaryClass({@required String kelas}) {
    return hcClient.fetchHcSummaryClass(kelas: kelas);
  }

  Future<HcSummary> fetchHcSummaryWamen({@required String wamen}) {
    return hcClient.fetchHcSummaryWamen(wamen: wamen);
  }

  Future<HcSummary> fetchHcSummaryCluster({@required String cluster}) {
    return hcClient.fetchHcSummaryCluster(cluster: cluster);
  }

  Future<List<HcCompany>> fetchHcCompanies() {
    return hcClient.fetchHcCompanies();
  }

  Future<List<HcCompany>> fetchHcCompaniesByClass({@required String kelas}) {
    return hcClient.fetchHcCompaniesByClass(kelas: kelas);
  }

  Future<List<HcCompany>> fetchHcCompaniesByCluster({@required String cluster}) {
    return hcClient.fetchHcCompaniesByCluster(cluster: cluster);
  }

  Future<List<DekomDetailedItem>> fetchTalentByKomposisi({@required String komposisi}) {
    return hcClient.fetchTalentByKomposisi(komposisi: komposisi);
  }

  Future<List<BOD1Company>> fetchBOD1Companies() {
    return hcClient.fetchBOD1Companies();
  }

  Future<List<BOD1Class>> fetchBOD1Classes() {
    return hcClient.fetchBOD1Classes();
  }

  Future<List<BOD1Company>> fetchBOD1CompaniesByClass({@required String kelas}) {
    return hcClient.fetchBOD1CompaniesByClass(kelas: kelas);
  }

  Future<List<BOD1Cluster>> fetchBOD1Cluster() {
    return hcClient.fetchBOD1Cluster();
  }

  Future<List<BOD1Company>> fetchBOD1CompaniesByCluster({@required String cluster}) {
    return hcClient.fetchBOD1CompaniesByCluster(cluster: cluster);
  }

  Future<List<BOD1Profile>> fetchBOD1ProfileByCompany({@required String companyId}) {
    return hcClient.fetchBOD1ProfileByCompany(companyId: companyId);
  }

  Future<BOD1TalentResponse> fetchBOD1Talent({@required String nik}) {
    return hcClient.fetchBOD1Talent(nik: nik);
  }

  Future<List<TalentDetail>> fetchDekomByCompany({@required String companyId}) {
    return hcClient.fetchDekomByCompany(companyId: companyId);
  }

  Future<List<TalentDetail>> fetchBODByCompany({@required String companyId}) {
    return hcClient.fetchBODByCompany(companyId: companyId);
  }

  Future<List<Anggaran>> fetchAnggaranInovasiByCompany({@required String companyId}) {
    return hcClient.fetchAnggaranInovasiByCompany(companyId: companyId);
  }

  Future<List<Anggaran>> fetchAnggaranLearningByCompany({@required String companyId}) {
    return hcClient.fetchAnggaranLearningByCompany(companyId: companyId);
  }

  Future<List<TalentDetail>> fetchPejabatByAnakCompany({@required String anakName}) {
    return hcClient.fetchPejabatByAnakCompany(anakName: anakName);
  }

  Future<TalentDetail> fetchPejabatAnak({@required int id}) {
    return hcClient.fetchPejabatAnak(id: id);
  }

  Future<List<TalentDetail>> fetchPejabatByCucuCompany({@required String anakName}) {
    return hcClient.fetchPejabatByCucuCompany(anakName: anakName);
  }

  Future<TalentDetail> fetchPejabatCucu({@required int id}) {
    return hcClient.fetchPejabatCucu(id: id);
  }

  Future<List<AnakPerusahaanDeni>> fetchAnakPerusahaanByCompany({@required String companyId}) {
    return hcClient.fetchAnakPerusahaanByCompany(companyId: companyId);
  }

  Future<List<CucuPerusahaanDeni>> fetchCucuPerusahaanByCompany({@required String companyId}) {
    return hcClient.fetchCucuPerusahaanByCompany(companyId: companyId);
  }

  Future<List<TalentPoolByClass>> fetchTalentPoolByClass() {
    return hcClient.fetchTalentPoolByClass();
  }

  Future<List<TalentPoolByCluster>> fetchTalentPoolByCluster() {
    return hcClient.fetchTalentPoolByCluster();
  }

  Future<List<TalentPoolByCompany>> fetchTalentPoolByCompany() {
    return hcClient.fetchTalentPoolByCompany();
  }

  Future<List<TalentPoolItem>> fetchTalentPoolList({String kelas, String cluster, String companyId}) {
    return hcClient.fetchTalentPoolList(kelas: kelas, cluster: cluster, companyId: companyId);
  }

  Future<List<TalentPoolItem>> fetchDropTalent() {
    return hcClient.fetchDropTalentItem();
  }

  Future<List<TalentPoolItem>> fetchTalentMobility() {
    return hcClient.fetchTalentMobility();
  }

  Future<List<String>> fetchAutocomplete({String name}) {
    return hcClient.fetchAutoComplete(name: name);
  }

  Future<SearchItemResponse> fetchSearchPeople({String name}) {
    return hcClient.fetchSearchPeople(name: name);
  }
}