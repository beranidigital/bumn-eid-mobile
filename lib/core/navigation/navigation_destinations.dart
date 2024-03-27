import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/models/common/anak_perusahaan_deni.dart';
import 'package:bumn_eid/core/models/common/cucu_perusahaan_deni.dart';
import 'package:bumn_eid/core/models/csr/csr_item.dart';
import 'package:bumn_eid/core/models/finance/grafik_suspi.dart';
import 'package:bumn_eid/core/models/hc/bod1_profile.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_item.dart';
import 'package:bumn_eid/core/models/legal/legal_item.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/modals/event_list_dialog/event_list_dialog.dart';
import 'package:bumn_eid/ui/modals/feature_not_available_dialog/feature_not_available_dialog.dart';
import 'package:bumn_eid/ui/modals/general_failed_dialog/general_failed_dialog.dart';
import 'package:bumn_eid/ui/modals/logout_dialog/logout_dialog.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/business_portfolio_page/business_portfolio_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_detailed_page/cluster_bumn_detailed_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_page/cluster_bumn_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_page/di/cluster_bumn_page_graph.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/jenis/dbjenis_bumn_page/dbjenis_bumn_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/jenis/jenis_bumn_detailed_page/jenis_bumn_detailed_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_detailed_page/kelas_bumn_detailed_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_page/kelas_bumn_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/sector/sektor_bumn_detailed_page/sektor_bumn_detailed_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/sector/sektor_bumn_page/sektor_bumn_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/total/total_bumn_page/total_bumn_page.dart';
import 'package:bumn_eid/ui/pages/common/company_detail_page/company_detail_page.dart';
import 'package:bumn_eid/ui/pages/common/image_dialog/image_dialog.dart';
import 'package:bumn_eid/ui/pages/common/kinerja_perusahaan_page/kinerja_perusahaan_page.dart';
import 'package:bumn_eid/ui/pages/common/kontribusi_negara_page/kontribusi_negara_page.dart';
import 'package:bumn_eid/ui/pages/common/loading_dialog/loading_dialog.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_class/covid_by_class_detailed_page/covid_by_class_detailed_page.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_class/covid_by_class_page/covid_by_class_page.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_detailed_page/covid_cluster_detailed_page.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_page/covid_cluster_page.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_timeline_page/covid_cluster_timeline_page.dart';
import 'package:bumn_eid/ui/pages/covid/covid_company_detail/covid_company_detail_page.dart';
import 'package:bumn_eid/ui/pages/covid/covid_company_list/covid_company_list_page.dart';
import 'package:bumn_eid/ui/pages/covid/covid_page/covid_page.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bina_lingkungan_company/bina_lingkungan_company_page.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bina_lingkungan_page/bina_lingkungan_page.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bl_company_area/bl_company_area_page.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bl_company_detailed/bl_company_detailed_page.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran/jenis_penyebaran_page.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran_detailed/jenis_penyebaran_detailed_page.dart';
import 'package:bumn_eid/ui/pages/csr/common/company_csr_detail_page/company_csr_detail_page.dart';
import 'package:bumn_eid/ui/pages/csr/common/csr_detail_page/csr_detail_page.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_detailed_page/penyebaran_wilayah_detailed_page.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_page/penyebaran_wilayah_page.dart';
import 'package:bumn_eid/ui/pages/csr/common/realisasi_dana_page/realisasi_dana_page.dart';
import 'package:bumn_eid/ui/pages/csr/csr/csr_company_list/csr_company_list_page.dart';
import 'package:bumn_eid/ui/pages/csr/csr_page/csr_page.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/mitra_binaan_page/mitra_binaan_page.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/pk_company_area/pk_company_area_page.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/pk_company_detailed/pk_company_detailed_page.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/program_kemitraan_company/program_kemitraan_company_page.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/program_kemitraan_page/program_kemitraan_page.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_detailed/sektor_penyaluran_detailed_page.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/sektor_penyaluran_page/sektor_penyaluran_page.dart';
import 'package:bumn_eid/ui/pages/event/event_page/event_page.dart';
import 'package:bumn_eid/ui/pages/finance/apbn/apbn_page/apbn_page.dart';
import 'package:bumn_eid/ui/pages/finance/apbn/dividen_page/dividen_page.dart';
import 'package:bumn_eid/ui/pages/finance/apbn/pajak_page/pajak_page.dart';
import 'package:bumn_eid/ui/pages/finance/apbn/pnbp_page/pnbp_page.dart';
import 'package:bumn_eid/ui/pages/finance/capex/capex_detailed_page/capex_detailed_page.dart';
import 'package:bumn_eid/ui/pages/finance/capex/capex_page/capex_page.dart';
import 'package:bumn_eid/ui/pages/finance/ebitda/ebitda_page/ebitda_page.dart';
import 'package:bumn_eid/ui/pages/finance/finance_page/finance_page.dart';
import 'package:bumn_eid/ui/pages/finance/labarugi/laba_rugi_detailed_page/laba_rugi_detailed_page.dart';
import 'package:bumn_eid/ui/pages/finance/labarugi/laba_rugi_page/laba_rugi_page.dart';
import 'package:bumn_eid/ui/pages/finance/loan/loan/loan_detail_page/loan_detail_page.dart';
import 'package:bumn_eid/ui/pages/finance/loan/loan/loan_page/loan_page.dart';
import 'package:bumn_eid/ui/pages/finance/loan/loan_main_page/loan_main_page.dart';
import 'package:bumn_eid/ui/pages/finance/loan/suspi/suspi_detail_page/suspi_detail_page.dart';
import 'package:bumn_eid/ui/pages/finance/loan/suspi/suspi_graph_page/suspi_graph_page.dart';
import 'package:bumn_eid/ui/pages/finance/loan/suspi/suspi_page/suspi_page.dart';
import 'package:bumn_eid/ui/pages/finance/loan/third_party_loan/third_party_loan_page/third_party_loan_page.dart';
import 'package:bumn_eid/ui/pages/finance/posisi_keuangan/posisi_keuangan_detailed_page/posisi_keuangan_detailed_page.dart';
import 'package:bumn_eid/ui/pages/finance/posisi_keuangan/posisi_keuangan_page/posisi_keuangan_page.dart';
import 'package:bumn_eid/ui/pages/finance/revenue/revenue_page/revenue_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_anak_company_page/bod_anak_company_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_anak_talent_detail_page/bod_anak_talent_detail_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_by_anak_company_page/bod_by_anak_company_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_by_company_page/bod_by_company_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_by_cucu_company_page/bod_by_cucu_company_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_class_page/bod_class_detailed_page/bod_class_detailed_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_class_page/bod_class_page/bod_class_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_cucu_company_page/bod_cucu_company_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_cucu_talent_detail_page/bod_cucu_talent_detail_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/komposisi_dewan_master_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_page/bod_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_potret_tugas_page/bod_potret_tugas_detailed_page/bod_potret_tugas_detailed_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_potret_tugas_page/bod_potret_tugas_page/bod_potret_tugas_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_potret_tugas_page/potret_talent_detail_page/potret_talent_detail_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_talent_pool_page/bod_talent_pool_page/bod_talent_pool_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_talent_pool_page/talent_detail_page/talent_detail_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/company_bod_page/company_bod_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod1_talent_detail_page/bod1_talent_detail_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_cluster/bod_1_cluster_detailed/bod_1_cluster_detailed_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_cluster/bod_1_cluster_page/bod_1_cluster_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_company/bod_1_company_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_kelas/bod_1_kelas_detailed/bod_1_kelas_detailed_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_kelas/bod_1_kelas_page/bod_1_kelas_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_page/bod_1_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/company_bod1_page/company_bod1_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/profile_bod_1_page/profile_bod1_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/company_dekom_page/company_dekom_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_anak_company_page/dekom_anak_company_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_anak_talent_detail_page/dekom_anak_talent_detail_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_by_anak_company_page/dekom_by_anak_company_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_by_company_page/dekom_by_company_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_by_cucu_company_page/dekom_by_cucu_company_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_cucu_company_page/dekom_cucu_company_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_cucu_talent_detail_page/dekom_cucu_talent_detail_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dewan_komisaris_page/dewan_komisaris_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_detailed_page/komposisi_detailed_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_class/komposisi_dewan_class_detailed_page/komposisi_dewan_class_detailed_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_class/komposisi_dewan_class_page/komposisi_dewan_class_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/komposisi_dewan_master_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/potret_tugas/potret_tugas_detailed_page/potret_tugas_detailed_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/potret_tugas/potret_tugas_page/potret_tugas_page.dart';
import 'package:bumn_eid/ui/pages/hc/employee/company_employee_page/company_employee_page.dart';
import 'package:bumn_eid/ui/pages/hc/employee/employee_page/employee_page.dart';
import 'package:bumn_eid/ui/pages/hc/employee/profile_employee_page/profile_employee_page.dart';
import 'package:bumn_eid/ui/pages/hc/employee/realisasi_inovasi_page/realisasi_inovasi_page.dart';
import 'package:bumn_eid/ui/pages/hc/employee/realisasi_learning_page/realisasi_learning_page.dart';
import 'package:bumn_eid/ui/pages/hc/hc_page/hc_page.dart';
import 'package:bumn_eid/ui/pages/hc/search_people_page/search_people_page.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/drop_talent/drop_talent_page/drop_talent_page.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/mobility/talent_mobility_page/talent_mobility_page.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_class_page/talent_pool_by_class_page.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_cluster_page/talent_pool_by_cluster_page.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_company_page/talent_pool_by_company_page.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_process_page/talent_pool_by_process_page.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_detail_page/talent_pool_detail_page.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_list_page/talent_pool_list_page.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_page/talent_pool_page.dart';
import 'package:bumn_eid/ui/pages/home/home_page/home_page.dart';
import 'package:bumn_eid/ui/pages/home/notification_page/notification_page.dart';
import 'package:bumn_eid/ui/pages/home/profile_page/profile_page.dart';
import 'package:bumn_eid/ui/pages/home/welcome_page/dialogs/failed/login_failed_dialog.dart';
import 'package:bumn_eid/ui/pages/home/welcome_page/dialogs/success/login_success_dialog.dart';
import 'package:bumn_eid/ui/pages/home/welcome_page/welcome_page.dart';
import 'package:bumn_eid/ui/pages/legal/legal_category_page/cluster_bumn_detailed_page/legal_category_page.dart';
import 'package:bumn_eid/ui/pages/legal/legal_detail_page/legal_detail_page.dart';
import 'package:bumn_eid/ui/pages/legal/legal_summary_page/legal_summary_page.dart';
import 'package:bumn_eid/ui/pages/pmo/pmo_page/pmo_page.dart';
import 'package:bumn_eid/ui/pages/pmo/project_detail_page/project_detail_page.dart';
import 'package:bumn_eid/irwan_dev/hc/views/pages/dashboard/dashboard.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/main_page_cosmic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:bumn_eid/irwan_dev/pen/import_all_screens_pen.dart';
import 'package:bumn_eid/irwan_dev/cosmics/views/pages/detail_list_main_page.dart';
import 'package:redux/redux.dart';

abstract class NavigationDestination {
  Widget buildWidget(BuildContext context);
}

// BUSINESS PORTFOLIO

class BusinessPortfolioPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => BusinessPortfolioPage();
}

class DBJenisBumnPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => DBJenisBumnPage();
}

class KelasBumnPageDestination extends NavigationDestination {
  final KelasBumnPageType type;

  KelasBumnPageDestination({this.type = KelasBumnPageType.BUSINESS_PORTFOLIO});
  @override
  Widget buildWidget(BuildContext context) => KelasBumnPage(
        type: type,
      );
}

class SektorBumnPageDestination extends NavigationDestination {
  final SektorBumnPageType type;

  SektorBumnPageDestination({this.type});

  @override
  Widget buildWidget(BuildContext context) => SektorBumnPage(type);
}

class ClusterBumnPageDestination extends NavigationDestination {
  final ClusterBumnPageType type;
  final String wamen;

  ClusterBumnPageDestination({
    this.type,
    this.wamen,
  });

  @override
  Widget buildWidget(BuildContext context) => ClusterBumnPage(
        type,
        ClusterBumnPageGraph(),
        wamen,
      );
}

class TotalBumnPageDestination extends NavigationDestination {
  final TotalBumnPageType type;

  TotalBumnPageDestination({this.type});

  @override
  Widget buildWidget(BuildContext context) => TotalBumnPage(type);
}

class JenisBumnDetailedPageDestination extends NavigationDestination {
  final String jenisBumn;
  JenisBumnDetailedPageDestination({@required this.jenisBumn});

  @override
  Widget buildWidget(BuildContext context) => JenisBumnDetailedPage(
        jenisBumn: jenisBumn,
      );
}

class SektorBumnDetailedPageDestination extends NavigationDestination {
  final String sektor;
  final SektorBumnPageType type;
  SektorBumnDetailedPageDestination(
      {@required this.sektor, @required this.type});

  @override
  Widget buildWidget(BuildContext context) => SektorBumnDetailedPage(
        sektor: sektor,
        type: type,
      );
}

class KelasBumnDetailedPageDestination extends NavigationDestination {
  final int kelas;
  final KelasBumnPageType type;
  KelasBumnDetailedPageDestination(
      {@required this.kelas, this.type = KelasBumnPageType.BUSINESS_PORTFOLIO});

  @override
  Widget buildWidget(BuildContext context) =>
      KelasBumnDetailedPage(kelas: kelas, type: type);
}

class ClusterBumnDetailedPageDestination extends NavigationDestination {
  final String cluster;
  final ClusterBumnPageType type;
  ClusterBumnDetailedPageDestination(
      {@required this.cluster, @required this.type});

  @override
  Widget buildWidget(BuildContext context) =>
      ClusterBumnDetailedPage(cluster: cluster, type: type);
}

// END OF BUSINESS PORTFOLIO

// FINANCE

class FinancePageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => FinancePage();
}

class PosisiKeuanganPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => PosisiKeuanganPage();
}

class LabaRugiPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => LabaRugiPage();
}

class CapexPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => CapexPage();
}

class RevenuePageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => RevenuePage();
}

class LoanMainPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => LoanMainPage();
}

class SuspiGraphPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => SuspiGraphPage();
}

class SuspiPageDestination extends NavigationDestination {
  final GrafikSuspi jenis;

  SuspiPageDestination({@required this.jenis});

  @override
  Widget buildWidget(BuildContext context) => SuspiPage(
        jenis: jenis,
      );
}

class LoanPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => LoanPage();
}

class EbitdaPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => EbitdaPage();
}

class ApbnPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => APBNPage();
}

class DividenPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => DividenPage();
}

class PajakPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => PajakPage();
}

class PnbpPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => PnbpPage();
}

class PosisiKeuanganDetailedPageDestination extends NavigationDestination {
  final String jenisAkun;
  PosisiKeuanganDetailedPageDestination({@required this.jenisAkun});

  @override
  Widget buildWidget(BuildContext context) => PosisiKeuanganDetailedPage(
        jenisAkun: jenisAkun,
      );
}

class LabaRugiDetailedPageDestination extends NavigationDestination {
  final String jenisLabaRugi;
  LabaRugiDetailedPageDestination({@required this.jenisLabaRugi});

  @override
  Widget buildWidget(BuildContext context) => LabaRugiDetailedPage(
        jenisLabaRugi: jenisLabaRugi,
      );
}

class CapexDetailedPageDestination extends NavigationDestination {
  final String tahun;
  CapexDetailedPageDestination({@required this.tahun});

  @override
  Widget buildWidget(BuildContext context) => CapexDetailedPage(
        tahun: tahun,
      );
}

class SuspiDetailPageDestination extends NavigationDestination {
  final String bumnId;
  SuspiDetailPageDestination({@required this.bumnId});

  @override
  Widget buildWidget(BuildContext context) => SuspiDetailPage(
        bumnId: bumnId,
      );
}

class LoanDetailPageDestination extends NavigationDestination {
  final String bumnId;
  LoanDetailPageDestination({@required this.bumnId});

  @override
  Widget buildWidget(BuildContext context) => LoanDetailPage(
        bumnId: bumnId,
      );
}

class ThirdPartyLoanPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => ThirdPartyLoanPage();
}

// END OF FINANCE

// LEGAL

class LegalSummaryPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => LegalSummaryPage();
}

class LegalCategoryPageDestination extends NavigationDestination {
  final String category;

  LegalCategoryPageDestination({this.category});

  @override
  Widget buildWidget(BuildContext context) => LegalCategoryPage(
        category: category,
      );
}

class LegalDetailPageDestination extends NavigationDestination {
  final LegalItem item;

  LegalDetailPageDestination({this.item});

  @override
  Widget buildWidget(BuildContext context) => LegalDetailPage(
        item: item,
      );
}

// END OF LEGAL

// CSR

class CsrPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => CsrPage();
}

class ProgramKemitraanPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => ProgramKemitraanPage();
}

class BinaLingkunganPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => BinaLingkunganPage();
}

class RealisasiDanaPageDestination extends NavigationDestination {
  final RealisasiDanaType type;

  RealisasiDanaPageDestination({@required this.type});

  @override
  Widget buildWidget(BuildContext context) => RealisasiDanaPage(type: type);
}

class MitraBinaanPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => MitraBinaanPage();
}

class SektorPenyaluranPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => SektorPenyaluranPage();
}

class PenyebaranWilayahPageDestination extends NavigationDestination {
  final PenyebaranWilayahType type;

  PenyebaranWilayahPageDestination({@required this.type});
  @override
  Widget buildWidget(BuildContext context) => PenyebaranWilayahPage(type: type);
}

class PenyebaranWilayahDetailedPageDestination extends NavigationDestination {
  final PenyebaranWilayahType type;
  final String provinsi;
  final int tahun;

  PenyebaranWilayahDetailedPageDestination(
      {@required this.type, @required this.provinsi, @required this.tahun});
  @override
  Widget buildWidget(BuildContext context) => PenyebaranWilayahDetailedPage(
      type: type, provinsi: provinsi, tahun: tahun);
}

class JenisPenyebaranPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => JenisPenyebaranPage();
}

class CsrCompanyListPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => CsrCompanyListPage();
}

class CompanyCsrDetailPageDestination extends NavigationDestination {
  final String id;
  CompanyCsrDetailPageDestination({@required this.id});

  @override
  Widget buildWidget(BuildContext context) => CompanyCsrDetailPage(
        id: id,
      );
}

class CsrDetailPageDestination extends NavigationDestination {
  final CsrItem item;
  CsrDetailPageDestination({@required this.item});

  @override
  Widget buildWidget(BuildContext context) => CsrDetailPage(
        item: item,
      );
}

class PKCompanyListPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => PKCompanyPage();
}

class PKCompanyDetailedPageDestination extends NavigationDestination {
  final String companyId;

  PKCompanyDetailedPageDestination({@required this.companyId});

  @override
  Widget buildWidget(BuildContext context) => PKCompanyDetailedPage(
        companyId: companyId,
      );
}

class PKCompanyAreaPageDestination extends NavigationDestination {
  final String companyId;
  final String provinsi;

  PKCompanyAreaPageDestination({
    @required this.companyId,
    @required this.provinsi,
  });

  @override
  Widget buildWidget(BuildContext context) => PkCompanyAreaPage(
        companyId: companyId,
        provinsi: provinsi,
      );
}

class BLCompanyListPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => BLCompanyPage();
}

class BLCompanyDetailedPageDestination extends NavigationDestination {
  final String companyId;

  BLCompanyDetailedPageDestination({@required this.companyId});

  @override
  Widget buildWidget(BuildContext context) => BLCompanyDetailedPage(
        companyId: companyId,
      );
}

class BLCompanyAreaPageDestination extends NavigationDestination {
  final String companyId;
  final String provinsi;

  BLCompanyAreaPageDestination({
    @required this.companyId,
    @required this.provinsi,
  });

  @override
  Widget buildWidget(BuildContext context) => BlCompanyAreaPage(
        companyId: companyId,
        provinsi: provinsi,
      );
}

class JenisPenyebaranDetailedPageDestination extends NavigationDestination {
  final String jenis;

  JenisPenyebaranDetailedPageDestination({@required this.jenis});

  @override
  Widget buildWidget(BuildContext context) =>
      JenisPenyebaranDetailedPage(jenis: jenis);
}

class SektorPenyaluranDetailedPageDestination extends NavigationDestination {
  final String sektor;

  SektorPenyaluranDetailedPageDestination({@required this.sektor});

  @override
  Widget buildWidget(BuildContext context) =>
      SektorPenyaluranDetailedPage(sektor: sektor);
}

// END OF CSR

// HC

class HcPageDestination extends NavigationDestination {
  @override
  // Widget buildWidget(BuildContext context) => HcPage();
  Widget buildWidget(BuildContext context) => Dashboard();
}

class DewanKomisarisPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => DewanKomisarisPage();
}

class KomposisiDewanPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => KomposisiDewanMasterPage();
}

class KomposisiDewanClassPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => KomposisiDewanClassPage();
}

class KomposisiDewanClassDetailedPageDestination extends NavigationDestination {
  final String kelas;

  KomposisiDewanClassDetailedPageDestination({@required this.kelas});

  @override
  Widget buildWidget(BuildContext context) => KomposisiDewanClassDetailedPage(
        kelas: kelas,
      );
}

class PotretTugasPageDestination extends NavigationDestination {
  final bool now;

  PotretTugasPageDestination({this.now = false});

  @override
  Widget buildWidget(BuildContext context) => PotretTugasPage(now: now);
}

class PotretTugasDetailedPageDestination extends NavigationDestination {
  final int range;
  final bool now;

  PotretTugasDetailedPageDestination({
    @required this.range,
    @required this.now,
  });

  @override
  Widget buildWidget(BuildContext context) =>
      PotretTugasDetailedPage(range: range, now: now);
}

class EmployeePageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => EmployeePage();
}

class CompanyEmployeePageDestination extends NavigationDestination {
  final String id;
  CompanyEmployeePageDestination({@required this.id});

  @override
  Widget buildWidget(BuildContext context) => CompanyEmployeePage(
        id: id,
      );
}

class ProfileEmployeePageDestination extends NavigationDestination {
  final ProfilPerusahaan company;
  ProfileEmployeePageDestination({@required this.company});

  @override
  Widget buildWidget(BuildContext context) => ProfileEmployeePage(
        company: company,
      );
}

class BODPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => BODPage();
}

class BODClassPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => BODClassPage();
}

class BODClassDetailedPageDestination extends NavigationDestination {
  final String kelas;

  BODClassDetailedPageDestination({@required this.kelas});

  @override
  Widget buildWidget(BuildContext context) => BODClassDetailedPage(
        kelas: kelas,
      );
}

class KomposisiBODPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => BODKomposisiMasterPage();
}

class PotretTugasBODPageDestination extends NavigationDestination {
  final bool now;

  PotretTugasBODPageDestination({this.now = false});

  @override
  Widget buildWidget(BuildContext context) => BODPotretTugasPage(now: now);
}

class PotretTugasBODDetailedPageDestination extends NavigationDestination {
  final int range;
  final bool now;

  PotretTugasBODDetailedPageDestination({
    @required this.range,
    @required this.now,
  });

  @override
  Widget buildWidget(BuildContext context) =>
      BODPotretTugasDetailedPage(range: range, now: now);
}

class PotretTugasBODTalentPageDestination extends NavigationDestination {
  final int id;
  final bool now;
  final bool isBod;
  final bool withCv;
  final bool fromItms;

  PotretTugasBODTalentPageDestination(
      {@required this.id,
      this.now = false,
      this.isBod = true,
      this.withCv = false,
      this.fromItms = false});

  @override
  Widget buildWidget(BuildContext context) => PotretTalentDetailPage(
        id: id,
        now: now,
        isBod: isBod,
        withCv: withCv,
        fromItms: fromItms,
      );
}

class BODTalentPoolPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => BODTalentPoolPage();
}

class DropTalentPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => DropTalentPage();
}

class TalentMobilityPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => TalentMobilityPage();
}

class SearchPeoplePageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => SearchPeoplePage();
}

class KomposisiDetailedPageDestination extends NavigationDestination {
  final String komposisi;

  KomposisiDetailedPageDestination({@required this.komposisi});

  @override
  Widget buildWidget(BuildContext context) => KomposisiDetailedPage(
        komposisi: komposisi,
      );
}

class TalentDetailPageDestination extends NavigationDestination {
  final int id;

  TalentDetailPageDestination({@required this.id});

  @override
  Widget buildWidget(BuildContext context) => TalentDetailPage(
        id: id,
      );
}

class BOD1PageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => BOD1Page();
}

class BOD1CompanyPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => BOD1CompanyPage();
}

class BOD1KelasPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => BOD1KelasPage();
}

class BOD1KelasDetailedPageDestination extends NavigationDestination {
  final String kelas;

  BOD1KelasDetailedPageDestination({@required this.kelas});

  @override
  Widget buildWidget(BuildContext context) => BOD1KelasDetailedPage(kelas);
}

class BOD1ClusterPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => BOD1ClusterPage();
}

class BOD1ClusterDetailedPageDestination extends NavigationDestination {
  final String cluster;

  BOD1ClusterDetailedPageDestination({@required this.cluster});

  @override
  Widget buildWidget(BuildContext context) => BOD1ClusterDetailedPage(cluster);
}

class CompanyDekomPageDestination extends NavigationDestination {
  final String companyId;

  CompanyDekomPageDestination({@required this.companyId});

  @override
  Widget buildWidget(BuildContext context) => CompanyDekomPage(
        id: companyId,
      );
}

class CompanyBODPageDestination extends NavigationDestination {
  final String companyId;

  CompanyBODPageDestination({@required this.companyId});

  @override
  Widget buildWidget(BuildContext context) => CompanyBODPage(
        id: companyId,
      );
}

class DekomByCompanyPageDestination extends NavigationDestination {
  final ProfilPerusahaan company;

  DekomByCompanyPageDestination({@required this.company});

  @override
  Widget buildWidget(BuildContext context) => DekomByCompanyPage(
        company: company,
      );
}

class BODByCompanyPageDestination extends NavigationDestination {
  final ProfilPerusahaan company;

  BODByCompanyPageDestination({@required this.company});

  @override
  Widget buildWidget(BuildContext context) => BODByCompanyPage(
        company: company,
      );
}

class DekomByAnakCompanyPageDestination extends NavigationDestination {
  final AnakPerusahaanDeni company;

  DekomByAnakCompanyPageDestination({@required this.company});

  @override
  Widget buildWidget(BuildContext context) => DekomByAnakCompanyPage(
        company: company,
      );
}

class DekomByCucuCompanyPageDestination extends NavigationDestination {
  final CucuPerusahaanDeni company;

  DekomByCucuCompanyPageDestination({@required this.company});

  @override
  Widget buildWidget(BuildContext context) => DekomByCucuCompanyPage(
        company: company,
      );
}

class BODByAnakCompanyPageDestination extends NavigationDestination {
  final AnakPerusahaanDeni company;

  BODByAnakCompanyPageDestination({@required this.company});

  @override
  Widget buildWidget(BuildContext context) => BODByAnakCompanyPage(
        company: company,
      );
}

class BODByCucuCompanyPageDestination extends NavigationDestination {
  final CucuPerusahaanDeni company;

  BODByCucuCompanyPageDestination({@required this.company});

  @override
  Widget buildWidget(BuildContext context) => BODByCucuCompanyPage(
        company: company,
      );
}

class DekomAnakTalentDetailPageDestination extends NavigationDestination {
  final int id;

  DekomAnakTalentDetailPageDestination({@required this.id});

  @override
  Widget buildWidget(BuildContext context) => DekomAnakTalentDetailPage(
        id: id,
      );
}

class DekomCucuTalentDetailPageDestination extends NavigationDestination {
  final int id;

  DekomCucuTalentDetailPageDestination({@required this.id});

  @override
  Widget buildWidget(BuildContext context) => DekomCucuTalentDetailPage(
        id: id,
      );
}

class BODAnakTalentDetailPageDestination extends NavigationDestination {
  final int id;

  BODAnakTalentDetailPageDestination({@required this.id});

  @override
  Widget buildWidget(BuildContext context) => BODAnakTalentDetailPage(
        id: id,
      );
}

class BODCucuTalentDetailPageDestination extends NavigationDestination {
  final int id;

  BODCucuTalentDetailPageDestination({@required this.id});

  @override
  Widget buildWidget(BuildContext context) => BODCucuTalentDetailPage(
        id: id,
      );
}

class DekomAnakCompanyPageDestination extends NavigationDestination {
  final ProfilPerusahaan company;

  DekomAnakCompanyPageDestination({@required this.company});

  @override
  Widget buildWidget(BuildContext context) => DekomAnakCompanyPage(
        company: company,
      );
}

class DekomCucuCompanyPageDestination extends NavigationDestination {
  final ProfilPerusahaan company;

  DekomCucuCompanyPageDestination({@required this.company});

  @override
  Widget buildWidget(BuildContext context) => DekomCucuCompanyPage(
        company: company,
      );
}

class BODAnakCompanyPageDestination extends NavigationDestination {
  final ProfilPerusahaan company;

  BODAnakCompanyPageDestination({@required this.company});

  @override
  Widget buildWidget(BuildContext context) => BODAnakCompanyPage(
        company: company,
      );
}

class BODCucuCompanyPageDestination extends NavigationDestination {
  final ProfilPerusahaan company;

  BODCucuCompanyPageDestination({@required this.company});

  @override
  Widget buildWidget(BuildContext context) => BODCucuCompanyPage(
        company: company,
      );
}

class RealisasiInovasiPageDestination extends NavigationDestination {
  final ProfilPerusahaan company;

  RealisasiInovasiPageDestination({@required this.company});

  @override
  Widget buildWidget(BuildContext context) => RealisasiInovasiPage(
        company: company,
      );
}

class RealisasiLearningPageDestination extends NavigationDestination {
  final ProfilPerusahaan company;

  RealisasiLearningPageDestination({@required this.company});

  @override
  Widget buildWidget(BuildContext context) => RealisasiLearningPage(
        company: company,
      );
}

class CompanyBOD1PageDestination extends NavigationDestination {
  final String companyId;

  CompanyBOD1PageDestination({@required this.companyId});

  @override
  Widget buildWidget(BuildContext context) => CompanyBOD1Page(
        id: companyId,
      );
}

class ProfileBOD1PageDestination extends NavigationDestination {
  final ProfilPerusahaan company;

  ProfileBOD1PageDestination({@required this.company});

  @override
  Widget buildWidget(BuildContext context) => ProfileBOD1Page(
        company: company,
      );
}

class BOD1TalentDetailPageDestination extends NavigationDestination {
  final BOD1Profile profile;
  final ProfilPerusahaan company;

  BOD1TalentDetailPageDestination({
    @required this.profile,
    @required this.company,
  });

  @override
  Widget buildWidget(BuildContext context) => BOD1TalentDetailPage(
        profile: profile,
        company: company,
      );
}

class TalentPoolPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => TalentPoolPage();
}

class TalentPoolByProcessPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => TalentPoolByProcessPage();
}

class TalentPoolByClassPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => TalentPoolByClassPage();
}

class ProfilePageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => ProfilePage();
}

class TalentPoolByClusterPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => TalentPoolByClusterPage();
}

class TalentPoolByCompanyPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => TalentPoolByCompanyPage();
}

class TalentPoolListPageDestination extends NavigationDestination {
  final String kelas;
  final String cluster;
  final String companyId;

  TalentPoolListPageDestination({this.kelas, this.cluster, this.companyId});

  @override
  Widget buildWidget(BuildContext context) =>
      TalentPoolListPage(kelas: kelas, cluster: cluster, companyId: companyId);
}

class TalentPoolDetailPageDestination extends NavigationDestination {
  final TalentPoolItem profile;

  TalentPoolDetailPageDestination({@required this.profile});

  @override
  Widget buildWidget(BuildContext context) => TalentPoolDetailPage(
        profile: profile,
      );
}

// END OF HC

// EVENT

class EventPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => EventPage();
}

class EventListDialogDestination extends NavigationDestination {
  final DateTime dateTime;
  final List<Event> events;

  EventListDialogDestination({@required this.dateTime, @required this.events});

  @override
  Widget buildWidget(BuildContext context) => EventListDialog(
        dateTime: dateTime,
        events: events,
      );
}

// END OF EVENT

class NotificationPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => NotificationPage();
}

// PMO

class PMOPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => PMOPage();
}

class ProjectDetailPageDestination extends NavigationDestination {
  final int id;

  ProjectDetailPageDestination({@required this.id});

  @override
  Widget buildWidget(BuildContext context) => ProjectDetailPage(id: id);
}

// END OF PMO

// COVID

class CovidPageDestination extends NavigationDestination {
  @override
  // Widget buildWidget(BuildContext context) => CovidPage();
  Widget buildWidget(BuildContext context) => MainPageCosmic();
}

class CovidCompanyListPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => CovidCompanyListPage();
}

class CovidByClusterPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => CovidClusterPage();
}

class CovidByClusterDetailedPageDestination extends NavigationDestination {
  final String cluster;

  CovidByClusterDetailedPageDestination({@required this.cluster});

  @override
  Widget buildWidget(BuildContext context) =>
      CovidClusterDetailedPage(cluster: cluster);
}

class CovidClusterTimelinePageDestination extends NavigationDestination {
  final String cluster;

  CovidClusterTimelinePageDestination({@required this.cluster});

  @override
  Widget buildWidget(BuildContext context) =>
      CovidClusterTimelinePage(cluster: cluster);
}

class CovidByClassPageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => CovidByClassPage();
}

class CovidByClassDetailedPageDestination extends NavigationDestination {
  final int kelas;

  CovidByClassDetailedPageDestination({@required this.kelas});

  @override
  Widget buildWidget(BuildContext context) =>
      CovidByClassDetailedPage(kelas: kelas);
}

class CovidCompanyDetailPageDestination extends NavigationDestination {
  final String companyId;

  CovidCompanyDetailPageDestination({@required this.companyId});

  // @override
  // Widget buildWidget(BuildContext context) =>
  //     CovidCompanyDetailPage(id: companyId);

  @override
  Widget buildWidget(BuildContext context) =>
      DetailListMainPage(bumn_id: companyId);
}

// END OF COVID

// COMMON

class LogoutDestination extends NavigationDestination {
  Store<AppState> store;

  LogoutDestination({@required this.store});

  @override
  Widget buildWidget(BuildContext context) => LogoutDialog(
        store: store,
      );
}

class ImageDialogDestination extends NavigationDestination {
  final String image;
  ImageDialogDestination({@required this.image});

  @override
  Widget buildWidget(BuildContext context) => ImageDialog(
        image: image,
      );
}

class FailedDialogDestination extends NavigationDestination {
  final String title;
  final String errorMessage;
  FailedDialogDestination({@required this.title, @required this.errorMessage});

  @override
  Widget buildWidget(BuildContext context) => GeneralFailedDialog(
        title: title,
        errorMessage: errorMessage,
      );
}

class LoadingDialogDestination extends NavigationDestination {
  final String dialogTitle;

  LoadingDialogDestination({this.dialogTitle});
  @override
  Widget buildWidget(BuildContext context) => LoadingDialog(
        dialogTitle: dialogTitle,
      );
}

class LoginSuccessDialogDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => LoginSuccessDialog();
}

class LoginFailedDialogDestination extends NavigationDestination {
  final dynamic exception;

  LoginFailedDialogDestination({@required this.exception});

  @override
  Widget buildWidget(BuildContext context) => LoginFailedDialog(
        errorMessage: exception?.toString(),
      );
}

class FeatureNotAvailableDialogDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => FeatureNotAvailableDialog();
}

class HomePageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => HomePage();
}

class WelcomePageDestination extends NavigationDestination {
  @override
  Widget buildWidget(BuildContext context) => WelcomePage();
}

class CompanyDetailPageDestination extends NavigationDestination {
  final String id;
  CompanyDetailPageDestination({@required this.id});

  @override
  Widget buildWidget(BuildContext context) => CompanyDetailPage(
        id: id,
      );
}

class KinerjaPerusahaanPageDestination extends NavigationDestination {
  final String id;
  KinerjaPerusahaanPageDestination({@required this.id});

  @override
  Widget buildWidget(BuildContext context) => KinerjaPerusahaanPage(
        id: id,
      );
}

class KontribusiNegaraPageDestination extends NavigationDestination {
  final String id;
  KontribusiNegaraPageDestination({@required this.id});

  @override
  Widget buildWidget(BuildContext context) => KontribusiNegaraPage(
        id: id,
      );
}

class OperasionalPerusahaanPageDestination extends NavigationDestination {
  final String id;
  OperasionalPerusahaanPageDestination({@required this.id});

  @override
  Widget buildWidget(BuildContext context) {
    switch (id) {
      // case '3001':
      //   return PLN(id: id);
      //   break;
      // case '3301':
      //   return TelkomIndonesia(id: id);
      //   break;
      // case '2904':
      //   return Pertamina(id: id);
      //   break;
      // case '1802':
      //   return ITDC(id: id);
      //   break;
      // case '3303':
      //   return Antara(id: id);
      //   break;
      // case '2501':
      //   return PupukIndonesia(id: id);
      //   break;
      // case '3501':
      //   return SemenIndonesia(id: id);
      //   break;
      // case '2203':
      //   return PTPN(id: id);
      //   break;
      // case '1703':
      //   return BioFarma(id: id);
      //   break;
      // case '2215':
      //   return RajawaliNusantaraIndonesia(id: id);
      //   break;
      // case '2001':
      //   return GarudaIndonesia(id: id);
      //   break;
      // case '1201':
      //   return AngkasaPura1(id: id);
      //   break;
      // case '1202':
      //   return AngkasaPura2(id: id);
      //   break;
      // case '1104':
      //   return AsdpFerry(id: id);
      //   break;
      // case '0602':
      //   return JasaMarga(id: id);
      //   break;
      // case '1301':
      //   return KeretaApi(id: id);
      //   break;
      // case '1001':
      //   return Pelindo1(id: id);
      //   break;
      // case '1002':
      //   return Pelindo2(id: id);
      //   break;
      // case '1003':
      //   return Pelindo3(id: id);
      //   break;
      // case '1004':
      //   return Pelindo4(id: id);
      //   break;
      // case '1101':
      //   return Pelni(id: id);
      //   break;
      // case '1404':
      //   return Bulog(id: id);
      //   break;
      // case '1402':
      //   return BhandaGhara(id: id);
      //   break;
      // case '1401':
      //   return PosIndonesia(id: id);
      //   break;
      // case '0102':
      //   return BankBNI(id: id);
      //   break;
      // case '0101':
      //   return BankMandiri(id: id);
      //   break;
      // case '0103':
      //   return BankBRI(id: id);
      //   break;
      // case '0104':
      //   return BankBTN(id: id);
      //   break;
      // case '0302':
      //   return PNM(id: id);
      //   break;
      default:
        return FeatureNotAvailableDialog();
        break;
    }
  }
}

// END OF COMMON
