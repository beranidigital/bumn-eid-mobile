import 'package:bumn_eid/core/api/api_client.dart';
import 'package:bumn_eid/core/api/response/hc/anak_perusahaan_deni_response.dart';
import 'package:bumn_eid/core/api/response/hc/anggaran_response.dart';
import 'package:bumn_eid/core/api/response/hc/bod1_class_response.dart';
import 'package:bumn_eid/core/api/response/hc/bod1_cluster_response.dart';
import 'package:bumn_eid/core/api/response/hc/bod1_company_response.dart';
import 'package:bumn_eid/core/api/response/hc/bod1_profile_response.dart';
import 'package:bumn_eid/core/api/response/hc/bod1_talent_response.dart';
import 'package:bumn_eid/core/api/response/hc/bod_potret_talent_response.dart';
import 'package:bumn_eid/core/api/response/hc/bod_talent_fungsi_response.dart';
import 'package:bumn_eid/core/api/response/hc/bod_talent_response.dart';
import 'package:bumn_eid/core/api/response/hc/cucu_perusahaan_deni_response.dart';
import 'package:bumn_eid/core/api/response/hc/dekom_detailed_response.dart';
import 'package:bumn_eid/core/api/response/hc/drop_talent_item_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_bod_cluster_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_bod_kelas_detailed_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_bod_kelas_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_bod_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_dewan_cluster_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_dewan_grouped_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_dewan_kelas_detailed_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_dewan_kelas_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_dewan_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_employee_age_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_employee_demografi_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_employee_education_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_employee_gender_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_potret_tugas_detailed_response.dart';
import 'package:bumn_eid/core/api/response/hc/grafik_potret_tugas_response.dart';
import 'package:bumn_eid/core/api/response/hc/hc_companies_response.dart';
import 'package:bumn_eid/core/api/response/hc/hc_summary_response.dart';
import 'package:bumn_eid/core/api/response/hc/search_autocomplete_response.dart';
import 'package:bumn_eid/core/api/response/hc/search_item_response.dart';
import 'package:bumn_eid/core/api/response/hc/talent_detail_response.dart';
import 'package:bumn_eid/core/api/response/hc/talent_pool_by_class_response.dart';
import 'package:bumn_eid/core/api/response/hc/talent_pool_by_cluster_response.dart';
import 'package:bumn_eid/core/api/response/hc/talent_pool_by_company_response.dart';
import 'package:bumn_eid/core/api/response/hc/talent_pool_item_response.dart';
import 'package:bumn_eid/core/controllers/session_controller.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/common/anak_perusahaan_deni.dart';
import 'package:bumn_eid/core/models/common/cucu_perusahaan_deni.dart';
import 'package:bumn_eid/core/models/hc/anggaran.dart';
import 'package:bumn_eid/core/models/hc/bod1_class.dart';
import 'package:bumn_eid/core/models/hc/bod1_cluster.dart';
import 'package:bumn_eid/core/models/hc/bod1_company.dart';
import 'package:bumn_eid/core/models/hc/bod1_profile.dart';
import 'package:bumn_eid/core/models/hc/bod_talent.dart';
import 'package:bumn_eid/core/models/hc/dekom_detailed_item.dart';
import 'package:bumn_eid/core/models/hc/grafik_employee_age.dart';
import 'package:bumn_eid/core/models/hc/grafik_employee_demografi.dart';
import 'package:bumn_eid/core/models/hc/grafik_employee_education.dart';
import 'package:bumn_eid/core/models/hc/grafik_employee_gender.dart';
import 'package:bumn_eid/core/models/hc/grafik_potret_kerja.dart';
import 'package:bumn_eid/core/models/hc/hc_company.dart';
import 'package:bumn_eid/core/models/hc/hc_summary.dart';
import 'package:bumn_eid/core/models/hc/search_result.dart';
import 'package:bumn_eid/core/models/hc/talent_detail.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_by_class.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_by_cluster.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_by_company.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_item.dart';
import 'package:flutter/material.dart';

class HcClient extends ApiClient {
  final SessionController sessionController;

  HcClient(
      {@required String tempUrl,
      @required String baseUrl,
      @required Logger logger,
      @required this.sessionController})
      : super(tempUrl, baseUrl, logger);

  Future<GrafikDewanResponse> fetchGrafikKomposisiDewan() async {
    final String endpoint = 'hc/grafik/komposisi/dewan/komisaris';

    GrafikDewanResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikDewanResponse.serializer);

    return response;
  }

  Future<GrafikBODResponse> fetchGrafikKomposisiBOD() async {
    final String endpoint = 'hc/grafik/komposisi/direksi';

    GrafikBODResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikBODResponse.serializer);

    return response;
  }

  Future<GrafikDewanGroupedResponse> fetchGrafikKomposisiDewanGrouped(
      {@required String group}) async {
    final String endpoint =
        'hc/grafik/komposisi/detail/dewan/komisaris/group/$group';

    GrafikDewanGroupedResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikDewanGroupedResponse.serializer);

    return response;
  }

  Future<GrafikDewanClusterResponse> fetchGrafikKomposisiCluster() async {
    final String endpoint = 'hc/grafik/komposisi/dewan/komisaris/by/cluster';

    GrafikDewanClusterResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikDewanClusterResponse.serializer);

    return response;
  }

  Future<GrafikDewanClusterResponse> fetchGrafikKomposisiWamen(
      {@required String wamen}) async {
    final String endpoint =
        'hc/grafik/komposisi/dewan/komisaris/by/wamen/wamen/$wamen';

    GrafikDewanClusterResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikDewanClusterResponse.serializer);

    return response;
  }

  Future<GrafikDewanKelasResponse> fetchGrafikKomposisiKelas() async {
    final String endpoint =
        'hc/grafik/komposisi/dewan/komisaris/by/kelas/alternative';

    GrafikDewanKelasResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikDewanKelasResponse.serializer);

    return response;
  }

  Future<GrafikDewanKelasDetailedResponse> fetchGrafikKomposisiKelasDetailed(
      {@required String kelas}) async {
    final String endpoint =
        'hc/detail/komposisi/dewan/komisaris/by/kelas/$kelas';

    GrafikDewanKelasDetailedResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikDewanKelasDetailedResponse.serializer);

    return response;
  }

  Future<GrafikPotretTugas> fetchGrafikPotretTugas({@required bool now}) async {
    String endpoint = 'hc/grafik/komposisi/dewan/komisaris/potret/masakerja';
    if (now) endpoint = endpoint + "/now";

    GrafikPotretTugasResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikPotretTugasResponse.serializer);

    return response.data.first;
  }

  Future<GrafikPotretTugasDetailedResponse> fetchGrafikPotretTugasDetailed(
      {@required int range, @required bool now}) async {
    String endpoint =
        'hc/detail/komposisi/dewan/komisaris/potret/masakerja/by/rangewaktu/$range';
    if (now) endpoint = endpoint + "/now";

    GrafikPotretTugasDetailedResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikPotretTugasDetailedResponse.serializer);

    return response;
  }

  Future<List<GrafikEmployeeDemografi>> fetchEmployeeDemografi(
      {@required String companyId}) async {
    final String endpoint = 'hc/grafik/karyawan/demografi/by/bumn/$companyId';

    GrafikEmployeeDemografiResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikEmployeeDemografiResponse.serializer);

    return response.data;
  }

  Future<List<GrafikEmployeeEducation>> fetchEmployeeEducation(
      {@required String companyId}) async {
    final String endpoint = 'hc/grafik/karyawan/education/by/bumn/$companyId';

    GrafikEmployeeEducationResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikEmployeeEducationResponse.serializer);

    return response.data;
  }

  Future<List<GrafikEmployeeGender>> fetchEmployeeGender(
      {@required String companyId}) async {
    final String endpoint = 'hc/grafik/karyawan/gender/by/bumn/$companyId';

    GrafikEmployeeGenderResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikEmployeeGenderResponse.serializer);

    return response.data;
  }

  Future<List<GrafikEmployeeAge>> fetchEmployeeAge(
      {@required String companyId}) async {
    final String endpoint = 'hc/grafik/karyawan/age/by/bumn/$companyId';

    GrafikEmployeeAgeResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikEmployeeAgeResponse.serializer);

    return response.data;
  }

  Future<GrafikBODKelasResponse> fetchGrafikKomposisiKelasBod() async {
    final String endpoint = 'hc/grafik/komposisi/direksi/by/class';

    GrafikBODKelasResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikBODKelasResponse.serializer);

    return response;
  }

  Future<GrafikBODKelasDetailedResponse> fetchGrafikKomposisiKelasDetailedBod(
      {@required String kelas}) async {
    final String endpoint = 'hc/detail/komposisi/direksi/by/kelas/$kelas';

    GrafikBODKelasDetailedResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikBODKelasDetailedResponse.serializer);

    return response;
  }

  Future<GrafikBODClusterResponse> fetchGrafikBodCluster() async {
    final String endpoint = 'hc/grafik/komposisi/direksi/by/cluster';

    GrafikBODClusterResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikBODClusterResponse.serializer);

    return response;
  }

  Future<GrafikBODClusterResponse> fetchGrafikBodWamen(
      {@required String wamen}) async {
    final String endpoint = 'hc/grafik/komposisi/direksi/by/wamen/wamen/$wamen';

    GrafikBODClusterResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikBODClusterResponse.serializer);

    return response;
  }

  Future<GrafikPotretTugas> fetchGrafikPotretTugasDireksi(
      {@required bool now}) async {
    String endpoint = 'hc/grafik/komposisi/direksi/potret/masakerja';
    if (now) endpoint = endpoint + "/now";

    GrafikPotretTugasResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikPotretTugasResponse.serializer);

    return response.data.first;
  }

  Future<GrafikPotretTugasDetailedResponse>
      fetchGrafikPotretTugasDireksiDetailed(
          {@required int range, @required bool now}) async {
    String endpoint =
        'hc/detail/komposisi/direksi/potret/masakerja/by/rangewaktu/$range';
    if (now) endpoint = endpoint + "/now";

    GrafikPotretTugasDetailedResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: GrafikPotretTugasDetailedResponse.serializer);

    return response;
  }

  Future<Map> fetchTalentFungsi() async {
    final String endpoint = 'hc/direksi/show/fungsi';

    BODTalentFungsiResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: BODTalentFungsiResponse.serializer);

    return response.data;
  }

  Future<List<BODTalent>> fetchTalent(
      {String kelas, String cluster, String jabatan}) async {
    final String endpoint =
        'hc/direksi/talent/search/by/kelas/$kelas/cluster/$cluster/fungsi/$jabatan';

    BODTalentResponse response = await get(
      endpoint: endpoint,
      token: sessionController.getToken(),
      email: sessionController.getEmail(),
      serializer: BODTalentResponse.serializer,
    );

    return response.data;
  }

  Future<TalentDetail> fetchTalentDetail({@required int id}) async {
    final String endpoint = 'hc/detail/direksi/talent/search/by/id/$id';

    TalentDetailResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: TalentDetailResponse.serializer);

    return response.data.first;
  }

  Future<BODPotretTalentResponse> fetchPotretTalentDetail(
      {@required int id, @required bool now}) async {
    String endpoint = 'hc/detail/pejabat/by/id/pejabat/$id';
    if (!now) endpoint = endpoint + "/history";

    BODPotretTalentResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: BODPotretTalentResponse.serializer);

    return response;
  }

  Future<HcSummary> fetchHcSummary({String filter, String query}) async {
    String endpoint = 'hc/summary/semua/bumn/by/all/all';
    if (filter != null) endpoint = endpoint + "/by/$filter/";
    if (query != null) endpoint = endpoint + query;

    HcSummaryResponse response = await get(
      endpoint: endpoint,
      token: sessionController.getToken(),
      email: sessionController.getEmail(),
      serializer: HcSummaryResponse.serializer,
    );

    return response.data;
  }

  Future<HcSummary> fetchHcSummaryClass({@required String kelas}) async {
    final String endpoint = 'hc/summary/semua/bumn/by/kelas/$kelas';

    HcSummaryResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: HcSummaryResponse.serializer);

    return response.data;
  }

  Future<HcSummary> fetchHcSummaryWamen({@required String wamen}) async {
    final String endpoint = 'hc/summary/semua/bumn/by/wamen/$wamen';

    HcSummaryResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: HcSummaryResponse.serializer);

    return response.data;
  }

  Future<HcSummary> fetchHcSummaryCluster({@required String cluster}) async {
    final String endpoint = 'hc/summary/semua/bumn/by/cluster/$cluster';

    HcSummaryResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: HcSummaryResponse.serializer);

    return response.data;
  }

  Future<List<HcCompany>> fetchHcCompanies() async {
    final String endpoint = 'hc/company/list';

    HcCompaniesResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: HcCompaniesResponse.serializer);

    return response.data;
  }

  Future<List<HcCompany>> fetchHcCompaniesByClass(
      {@required String kelas}) async {
    final String endpoint = 'hc/company/list/by/kelas/$kelas/show';

    HcCompaniesResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: HcCompaniesResponse.serializer);

    return response.data;
  }

  Future<List<HcCompany>> fetchHcCompaniesByCluster(
      {@required String cluster}) async {
    final String endpoint = 'hc/company/list/by/cluster/$cluster/show';

    HcCompaniesResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: HcCompaniesResponse.serializer);

    return response.data;
  }

  Future<List<DekomDetailedItem>> fetchTalentByKomposisi(
      {@required String komposisi}) async {
    final String endpoint =
        'hc/detail/komposisi/dewan/komisaris/by/detail/komposisi/$komposisi';

    DekomDetailedResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: DekomDetailedResponse.serializer);

    return response.data;
  }

  Future<List<BOD1Company>> fetchBOD1Companies() async {
    final String endpoint = 'hc/grafik/bod1/by/filter/by/company/parameter/all';

    BOD1CompanyResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: BOD1CompanyResponse.serializer);

    return response.companies;
  }

  Future<List<BOD1Class>> fetchBOD1Classes() async {
    final String endpoint = 'hc/grafik/bod1/by/filter/by/kelas/parameter/all';

    BOD1ClassResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: BOD1ClassResponse.serializer);

    return response.companies;
  }

  Future<List<BOD1Company>> fetchBOD1CompaniesByClass(
      {@required String kelas}) async {
    final String endpoint =
        'hc/grafik/bod1/by/filter/by/kelas/parameter/$kelas';

    BOD1CompanyResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: BOD1CompanyResponse.serializer);

    return response.companies;
  }

  Future<List<BOD1Cluster>> fetchBOD1Cluster() async {
    final String endpoint = 'hc/grafik/bod1/by/filter/by/cluster/parameter/all';

    BOD1ClusterResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: BOD1ClusterResponse.serializer);

    return response.companies;
  }

  Future<List<BOD1Company>> fetchBOD1CompaniesByCluster(
      {@required String cluster}) async {
    final String endpoint =
        'hc/grafik/bod1/by/filter/by/cluster/parameter/$cluster';

    BOD1CompanyResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: BOD1CompanyResponse.serializer);

    return response.companies;
  }

  Future<List<BOD1Profile>> fetchBOD1ProfileByCompany(
      {@required String companyId}) async {
    final String endpoint = 'hc/detail/bod1/by/company/by/idAngka/$companyId';

    BOD1ProfileResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: BOD1ProfileResponse.serializer);

    return response.data;
  }

  Future<BOD1TalentResponse> fetchBOD1Talent({@required String nik}) async {
    final String endpoint = 'hc/detail/cv/by/nik/$nik';

    BOD1TalentResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: BOD1TalentResponse.serializer);

    return response;
  }

  Future<List<TalentDetail>> fetchDekomByCompany(
      {@required String companyId}) async {
    final String endpoint =
        'hc/detail/komposisi/dewan/komisaris/by/id/$companyId';

    TalentDetailResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: TalentDetailResponse.serializer);

    return response.data;
  }

  Future<List<TalentDetail>> fetchBODByCompany(
      {@required String companyId}) async {
    final String endpoint = 'hc/detail/direksi/by/id/bumn/$companyId';

    TalentDetailResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: TalentDetailResponse.serializer);

    return response.data;
  }

  Future<List<TalentDetail>> fetchPejabatByAnakCompany(
      {@required String anakName}) async {
    final String endpoint = 'hc/anak/bumn/list/$anakName';

    TalentDetailResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: TalentDetailResponse.serializer);

    return response.data;
  }

  Future<List<TalentDetail>> fetchPejabatByCucuCompany(
      {@required String anakName}) async {
    final String endpoint = 'hc/cucu/bumn/list/$anakName';

    TalentDetailResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: TalentDetailResponse.serializer);

    return response.data;
  }

  Future<TalentDetail> fetchPejabatAnak({@required int id}) async {
    final String endpoint = 'hc/anak/bumn/local_id/$id';

    TalentDetailResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: TalentDetailResponse.serializer);

    return response.data.first;
  }

  Future<TalentDetail> fetchPejabatCucu({@required int id}) async {
    final String endpoint = 'hc/cucu/bumn/local_id/$id';

    TalentDetailResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: TalentDetailResponse.serializer);

    return response.data.first;
  }

  Future<List<AnakPerusahaanDeni>> fetchAnakPerusahaanByCompany(
      {@required String companyId}) async {
    final String endpoint = 'hc/list/anak/by/idAngka/$companyId';

    AnakPerusahaanDeniResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: AnakPerusahaanDeniResponse.serializer);

    return response.companies;
  }

  Future<List<CucuPerusahaanDeni>> fetchCucuPerusahaanByCompany(
      {@required String companyId}) async {
    final String endpoint = 'hc/list/cucu/by/idAngka/$companyId';

    CucuPerusahaanDeniResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: CucuPerusahaanDeniResponse.serializer);

    return response.companies;
  }

  Future<List<Anggaran>> fetchAnggaranInovasiByCompany(
      {@required String companyId}) async {
    final String endpoint = 'hc/anggaran/inovasi/detil/by/bumn/$companyId';

    AnggaranResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: AnggaranResponse.serializer);

    return response.companies;
  }

  Future<List<Anggaran>> fetchAnggaranLearningByCompany(
      {@required String companyId}) async {
    final String endpoint = 'hc/anggaran/learning/detil/by/bumn/$companyId';

    AnggaranResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: AnggaranResponse.serializer);

    return response.companies;
  }

  Future<List<TalentPoolByClass>> fetchTalentPoolByClass() async {
    final String endpoint = 'hc/talent/show/detail/talentPool/by/kelas/all';

    TalentPoolByClassResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: TalentPoolByClassResponse.serializer);

    return response.data;
  }

  Future<List<TalentPoolByCluster>> fetchTalentPoolByCluster() async {
    final String endpoint = 'hc/talent/show/detail/talentPool/by/cluster/all';

    TalentPoolByClusterResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: TalentPoolByClusterResponse.serializer);

    return response.data;
  }

  Future<List<TalentPoolByCompany>> fetchTalentPoolByCompany() async {
    final String endpoint = 'hc/talent/show/detail/talentPool/by/company/all';

    TalentPoolByCompanyResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: TalentPoolByCompanyResponse.serializer);

    return response.data;
  }

  Future<List<TalentPoolItem>> fetchTalentPoolList(
      {String kelas, String cluster, String companyId}) async {
    String endpoint = 'hc/advanceFilter/filter';

    Map<String, String> query = {};
    if (kelas != null && kelas != "-") query["kelas"] = kelas;
    if (cluster != null && cluster != "-") query["cluster"] = cluster;
    if (companyId != null && companyId != "-") query["id_angka"] = companyId;

    TalentPoolItemResponse response = await get(
        endpoint: endpoint,
        queryParams: query,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: TalentPoolItemResponse.serializer);

    return response.data;
  }

  Future<List<TalentPoolItem>> fetchDropTalentItem() async {
    String endpoint = 'hc/talent/show/detail/talentDropped/by/all/all';

    DropTalentItemResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: DropTalentItemResponse.serializer);

    return response.pejabat;
  }

  Future<List<TalentPoolItem>> fetchTalentMobility() async {
    String endpoint = 'hc/talent/show/detail/talentMobility/by/all/all';

    DropTalentItemResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: DropTalentItemResponse.serializer);

    return response.pejabat;
  }

  Future<List<String>> fetchAutoComplete({String name}) async {
    String endpoint = 'hc/talent/autoComplete/search/name/';
    endpoint += name;

    SearchAutocompleteResponse response;
    try {
      response = await get(
          endpoint: endpoint,
          token: sessionController.getToken(),
          email: sessionController.getEmail(),
          serializer: SearchAutocompleteResponse.serializer);
    } catch (ex) {
      return [];
    }

    return response.autocomplete.map((SearchResult result) {
      return result.name;
    }).toList();
  }

  Future<SearchItemResponse> fetchSearchPeople({String name}) async {
    String endpoint = 'hc/talent/search/name/';
    endpoint += name;

    SearchItemResponse response = await get(
        endpoint: endpoint,
        token: sessionController.getToken(),
        email: sessionController.getEmail(),
        serializer: SearchItemResponse.serializer);

    return response;
  }
}
