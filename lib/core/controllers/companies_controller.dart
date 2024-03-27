import 'package:bumn_eid/core/api/clients/company_client.dart';
import 'package:bumn_eid/core/api/clients/last_update_client.dart';
import 'package:bumn_eid/core/controllers/secure_storage_controller.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/models/business_portfolio/sektor.dart';
import 'package:bumn_eid/core/models/business_portfolio/summary.dart';
import 'package:bumn_eid/core/models/common/anak_perusahaan.dart';
import 'package:bumn_eid/core/models/hc/dirkom.dart';
import 'package:bumn_eid/core/models/internal/employee.dart';
import 'package:bumn_eid/core/models/internal/summary_internal.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/actions/companies/companies_actions.dart';
import 'package:bumn_eid/core/redux/actions/last_update/last_update_actions.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class CompaniesController {
  final CompanyClient companyClient;
  final LastUpdateClient lastUpdateClient;
  final Logger logger;
  final Store<AppState> store;
  final SecureStorageController secureStorageController;

  CompaniesController({
    @required this.companyClient,
    @required this.lastUpdateClient,
    @required this.logger,
    @required this.store,
    @required this.secureStorageController,
  });

  fetchCompanies() async {
    try {
      store.dispatch(
        ShowDialogAction(
          destination: LoadingDialogDestination(
            dialogTitle: "Mohon tunggu, sedang sinkronisasi data...",
          ),
          barrierDismissible: false,
        ),
      );
      bool companiesExist = await secureStorageController.companiesExist();
      if (!companiesExist) {
        final companies = await companyClient.fetchProfilPerusahaan();
        secureStorageController.saveCompanies(companies);
        store.dispatch(GotCompaniesAction(companies: companies));

        final lastUpdates = await lastUpdateClient.fetchLastUpdate();
        if (lastUpdates != null) {
          store.dispatch(GotLastUpdateData(lastUpdate: lastUpdates));
        }
      }
    } catch (ex) {
      print(ex.toString());
    } finally {
      store.dispatch(NavigateBackAction());
    }
  }

  Future<ProfilPerusahaan> fetchCompany({@required String id}) {
    return companyClient.fetchCompany(id: id);
  }

  Future<List<Sektor>> fetchBpsSectorList() {
    return companyClient.fetchBpsSectorList();
  }

  Future<List<ProfilPerusahaan>> fetchBpsSectorCompanies(
      {@required String sector}) {
    return companyClient.fetchBpsSectorCompanies(sector: sector);
  }

  Future<List<ProfilPerusahaan>> fetchClusterCompanies(
      {@required String cluster}) {
    return companyClient.fetchClusterCompanies(cluster: cluster);
  }

  Future<Map<DirkomType, List<Dirkom>>> fetchDirkom(
      {@required String companyId}) async {
    Map<DirkomType, List<Dirkom>> result = {};
    List<Dirkom> direkturs = await companyClient.fetchDirkom(
        dirkomType: Constants.direkturType, companyId: companyId);
    List<Dirkom> komisaris = await companyClient.fetchDirkom(
        dirkomType: Constants.komisarisType, companyId: companyId);

    result[DirkomType.DIREKTUR] = direkturs;
    result[DirkomType.KOMISARIS] = komisaris;

    return result;
  }

  Future<List<AnakPerusahaan>> fetchAnakPerusahaan(
      {@required String companyId}) {
    return companyClient.fetchAnakPerusahaan(companyId: companyId);
  }

  Future<List<Summary>> fetchSectorSummary({@required String sectorName}) {
    return companyClient.fetchSectorSummary(sectorName: sectorName);
  }

  Future<List<Summary>> fetchClusterSummary({@required String clusterName}) {
    return companyClient.fetchClusterSummary(clusterName: clusterName);
  }

  Future<List<Summary>> fetchWamenSummary({@required String wamen}) {
    return companyClient.fetchWamenSummary(wamen: wamen);
  }

  Future<List<Summary>> fetchKelasSummary({@required String kelasName}) {
    return companyClient.fetchKelasSummary(kelasName: kelasName);
  }

  Future<SummaryInternal> fetchInternalSummary({
    String usia,
    String pendidikan,
    String agama,
    String statusNikah,
    String statusPegawai,
    String jenisKelamin,
  }) {
    String usiaText;
    switch (usia) {
      case 'Dibawah 30 Tahun':
        usiaText = 'under_30';
        break;
      case '30-39 Tahun':
        usiaText = 'between_30_39';
        break;
      case '40-49 Tahun':
        usiaText = 'between_40_49';
        break;
      case 'Diatas 50 Tahun':
        usiaText = 'above_50';
        break;
      default:
        break;
    }
    return companyClient.fetchInternalSummary(
      usia: usiaText,
      pendidikan: pendidikan,
      agama: agama,
      statusNikah: statusNikah,
      statusPegawai: statusPegawai,
      jenisKelamin: jenisKelamin,
    );
  }

  Future<List<Employee>> fetchInternalEmployees({
    String usia,
    String pendidikan,
    String agama,
    String statusNikah,
    String statusPegawai,
    String jenisKelamin,
    int page = 1,
  }) {
    return companyClient.fetchInternalEmployees(
      usia: usia,
      pendidikan: pendidikan,
      agama: agama,
      statusNikah: statusNikah,
      statusPegawai: statusPegawai,
      jenisKelamin: jenisKelamin,
      page: page,
    );
  }
}
