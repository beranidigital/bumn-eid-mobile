import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_page/cluster_bumn_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_page/kelas_bumn_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/total/total_bumn_page/total_bumn_page.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hc_summary.g.dart';

enum HcSummaryType {
  EMPLOYEE,
  BOC,
  BOD
}

@JsonSerializable()
class HcSummary extends ResponseObject {

  @JsonKey(name: 'total_pegawai')
  final int totalPegawai;

  @JsonKey(name: 'pegawai_tetap')
  final int pegawaiTetap;

  @JsonKey(name: 'pegawai_kontrak')
  final int pegawaiKontrak;

  @JsonKey(name: 'laki_laki')
  final int laki;

  @JsonKey(name: 'perempuan')
  final int perempuan;

  @JsonKey(name: 'jumlah_komisaris')
  final int jumlahKomisaris;

  @JsonKey(name: 'jumlah_direksi')
  final int jumlahDireksi;

  @JsonKey(name: 'total_bumn_induk')
  final int totalBumn;

  @JsonKey(name: 'umur_a')
  final int umurA;

  @JsonKey(name: 'umur_b')
  final int umurB;

  @JsonKey(name: 'umur_c')
  final int umurC;

  @JsonKey(name: 'umur_d')
  final int umurD;

  @JsonKey(name: 'umur_e')
  final int umurE;

  @JsonKey(name: 'jumlah_20_percents_bod1')
  final int bod1TotalHome;

  @JsonKey(name: 'bod1_total')
  final int bod1Total;

  @JsonKey(name: 'bod1_perempuan')
  final int bod1Perempuan;

  @JsonKey(name: 'bod1_laki_laki')
  final int bod1Laki;

  @JsonKey(name: 'bod1_umur_a')
  final int bod1UmurA;

  @JsonKey(name: 'bod1_umur_b')
  final int bod1UmurB;

  @JsonKey(name: 'bod1_umur_c')
  final int bod1UmurC;

  @JsonKey(name: 'bod1_umur_d')
  final int bod1UmurD;

  @JsonKey(name: 'bod1_umur_e')
  final int bod1UmurE;

  @JsonKey(name: 'bod1_avg_indays')
  final int bod1AvgInDays;

  @JsonKey(name: 'bod1_less_one_year')
  final int bod1LessOneYear;

  @JsonKey(name: 'bod1_one_two_years')
  final int bod1OneTwoYear;

  @JsonKey(name: 'bod1_two_three_years')
  final int bod1TwoThreeYear;

  @JsonKey(name: 'bod1_three_four_years')
  final int bod1ThreeFourYear;

  @JsonKey(name: 'bod1_more_than_five_year')
  final int bod1MoreFourYear;

  @JsonKey(name: 'boc_total')
  final int bocTotal;

  @JsonKey(name: 'boc_perempuan')
  final int bocPerempuan;

  @JsonKey(name: 'boc_laki_laki')
  final int bocLaki;

  @JsonKey(name: 'boc_umur_a')
  final int bocUmurA;

  @JsonKey(name: 'boc_umur_b')
  final int bocUmurB;

  @JsonKey(name: 'boc_umur_c')
  final int bocUmurC;

  @JsonKey(name: 'boc_umur_d')
  final int bocUmurD;

  @JsonKey(name: 'boc_umur_e')
  final int bocUmurE;

  @JsonKey(name: 'boc_avg_indays')
  final int bocAvgInDays;

  @JsonKey(name: 'boc_less_one_year')
  final int bocLessOneYear;

  @JsonKey(name: 'boc_one_two_years')
  final int bocOneTwoYear;

  @JsonKey(name: 'boc_two_three_years')
  final int bocTwoThreeYear;

  @JsonKey(name: 'boc_three_four_years')
  final int bocThreeFourYear;

  @JsonKey(name: 'boc_more_than_five_year')
  final int bocMoreFourYear;

  @JsonKey(name: 'bod_total')
  final int bodTotal;

  @JsonKey(name: 'bod_perempuan')
  final int bodPerempuan;

  @JsonKey(name: 'bod_laki_laki')
  final int bodLaki;

  @JsonKey(name: 'bod_umur_a')
  final int bodUmurA;

  @JsonKey(name: 'bod_umur_b')
  final int bodUmurB;

  @JsonKey(name: 'bod_umur_c')
  final int bodUmurC;

  @JsonKey(name: 'bod_umur_d')
  final int bodUmurD;

  @JsonKey(name: 'bod_umur_e')
  final int bodUmurE;

  @JsonKey(name: 'bod_avg_indays')
  final int bodAvgInDays;

  @JsonKey(name: 'bod_less_one_year')
  final int bodLessOneYear;

  @JsonKey(name: 'bod_one_two_years')
  final int bodOneTwoYear;

  @JsonKey(name: 'bod_two_three_years')
  final int bodTwoThreeYear;

  @JsonKey(name: 'bod_three_four_years')
  final int bodThreeFourYear;

  @JsonKey(name: 'bod_more_than_five_year')
  final int bodMoreFourYear;

  @JsonKey(name: 'jumlah_komisaris_ap')
  final int jumlahKomisarisAp;

  @JsonKey(name: 'jumlah_direksi_ap')
  final int jumlahDireksiAp;

  @JsonKey(name: 'jumlah_komisaris_cucu')
  final int jumlahKomisarisCucu;

  @JsonKey(name: 'jumlah_direksi_cucu')
  final int jumlahDireksiCucu;

  @JsonKey(name: 'boc_cucu_perempuan')
  final int dekomCucuPerempuan;

  @JsonKey(name: 'boc_cucu_laki_laki')
  final int dekomCucuLaki;

  @JsonKey(name: 'bod_cucu_perempuan')
  final int bodCucuPerempuan;

  @JsonKey(name: 'bod_cucu_laki_laki')
  final int bodCucuLaki;

  @JsonKey(name: 'boc_anak_perempuan')
  final int dekomAnakPerempuan;

  @JsonKey(name: 'boc_anak_laki_laki')
  final int dekomAnakLaki;

  @JsonKey(name: 'bod_anak_perempuan')
  final int bodAnakPerempuan;

  @JsonKey(name: 'bod_anak_laki_laki')
  final int bodAnakLaki;

  @JsonKey(name: 'talent_sources_selected')
  final int selectedTalentSource;

  @JsonKey(name: 'talent_sources_nominated')
  final int nominatedTalentSource;

  @JsonKey(name: 'talent_sources_eligible')
  final int eligibleTalentSource;

  @JsonKey(name: 'talent_sources_ready')
  final int readyTalentSource;

  @JsonKey(name: 'total_bumn_cucu')
  final int totalBumnCucu;

  @JsonKey(name: 'total_bumn_ap')
  final int totalBumnAp;

  @JsonKey(name: 'total_talent_sources')
  final int totalTalentResources;

  HcSummary({
    this.totalBumnCucu,
    this.totalBumnAp,
    this.selectedTalentSource,
    this.nominatedTalentSource,
    this.eligibleTalentSource,
    this.readyTalentSource,
    this.dekomAnakPerempuan,
    this.dekomAnakLaki,
    this.bodAnakPerempuan,
    this.bodAnakLaki,
    this.dekomCucuPerempuan,
    this.dekomCucuLaki,
    this.bodCucuPerempuan,
    this.bodCucuLaki,
    this.jumlahKomisarisAp,
    this.jumlahDireksiAp,
    this.jumlahKomisarisCucu,
    this.jumlahDireksiCucu,
    this.totalPegawai,
    this.pegawaiTetap,
    this.pegawaiKontrak,
    this.laki,
    this.perempuan,
    this.jumlahKomisaris,
    this.jumlahDireksi,
    this.totalBumn,
    this.umurA,
    this.umurB,
    this.umurC,
    this.umurD,
    this.umurE,
    this.bocAvgInDays,
    this.bocLaki,
    this.bocLessOneYear,
    this.bocMoreFourYear,
    this.bocOneTwoYear,
    this.bocPerempuan,
    this.bocThreeFourYear,
    this.bocTotal,
    this.bocTwoThreeYear,
    this.bocUmurA,
    this.bocUmurB,
    this.bocUmurC,
    this.bocUmurD,
    this.bocUmurE,
    this.bod1TotalHome,
    this.bod1AvgInDays,
    this.bod1Laki,
    this.bod1LessOneYear,
    this.bod1MoreFourYear,
    this.bod1OneTwoYear,
    this.bod1Perempuan,
    this.bod1ThreeFourYear,
    this.bod1Total,
    this.bod1TwoThreeYear,
    this.bod1UmurA,
    this.bod1UmurB,
    this.bod1UmurC,
    this.bod1UmurD,
    this.bod1UmurE,
    this.bodAvgInDays,
    this.bodLaki,
    this.bodLessOneYear,
    this.bodMoreFourYear,
    this.bodOneTwoYear,
    this.bodPerempuan,
    this.bodThreeFourYear,
    this.bodTotal,
    this.bodTwoThreeYear,
    this.bodUmurA,
    this.bodUmurB,
    this.bodUmurC,
    this.bodUmurD,
    this.bodUmurE,
    this.totalTalentResources
  });

  factory HcSummary.fromJson(Map<String, dynamic> json) =>
      _$HcSummaryFromJson(json);

  static get serializer => _$HcSummaryFromJson;

  int getLaki2(HcSummaryType type) {
    switch (type) {
      case HcSummaryType.EMPLOYEE:
        return laki;
      case HcSummaryType.BOC:
        return bocLaki;
      case HcSummaryType.BOD:
        return bodLaki;
      default:
        return laki;
    }
  }

  int getPerempuan(HcSummaryType type) {
    switch (type) {
      case HcSummaryType.EMPLOYEE:
        return perempuan;
      case HcSummaryType.BOC:
        return bocPerempuan;
      case HcSummaryType.BOD:
        return bodPerempuan;
      default:
        return perempuan;
    }
  }

  int getTotalAge(HcSummaryType type) {
    try {
      switch (type) {
        case HcSummaryType.EMPLOYEE:
          return umurA + umurB + umurC + umurD + umurE;
        case HcSummaryType.BOC:
          return bocUmurA + bocUmurB + bocUmurC + bocUmurD + bocUmurE;
        case HcSummaryType.BOD:
          return bodUmurA + bodUmurB + bodUmurC + bodUmurD + bodUmurE;
        default:
          return umurA + umurB + umurC + umurD + umurE;
      }
    } catch (ex) {
      return 0;
    }
  }

  int getUmurA(HcSummaryType type) {
    try {
      switch (type) {
        case HcSummaryType.EMPLOYEE:
          return umurA;
        case HcSummaryType.BOC:
          return bocUmurA;
        case HcSummaryType.BOD:
          return bodUmurA;
        default:
          return umurA;
      }
    } catch (ex) {
      return 0;
    }
  }

  double getUmurAPercent(HcSummaryType type) {
    try {
      switch (type) {
        case HcSummaryType.EMPLOYEE:
          return umurA / getTotalAge(type) * 100;
        case HcSummaryType.BOC:
          return bocUmurA / getTotalAge(type) * 100;
        case HcSummaryType.BOD:
          return bodUmurA / getTotalAge(type) * 100;
        default:
          return umurA / getTotalAge(type) * 100;
      }
    } catch (ex) {
      return 0;
    }
  }

  int getUmurB(HcSummaryType type) {
    try {
      switch (type) {
        case HcSummaryType.EMPLOYEE:
          return umurB;
        case HcSummaryType.BOC:
          return bocUmurB;
        case HcSummaryType.BOD:
          return bodUmurB;
        default:
          return umurB;
      }
    } catch (ex) {
      return 0;
    }
  }

  double getUmurBPercent(HcSummaryType type) {
    try {
      switch (type) {
        case HcSummaryType.EMPLOYEE:
          return umurB / getTotalAge(type) * 100;
        case HcSummaryType.BOC:
          return bocUmurB / getTotalAge(type) * 100;
        case HcSummaryType.BOD:
          return bodUmurB / getTotalAge(type) * 100;
        default:
          return umurB / getTotalAge(type) * 100;
      }
    } catch (ex) {
      return 0;
    }
  }

  int getUmurC(HcSummaryType type) {
    try {
      switch (type) {
        case HcSummaryType.EMPLOYEE:
          return umurC;
        case HcSummaryType.BOC:
          return bocUmurC;
        case HcSummaryType.BOD:
          return bodUmurC;
        default:
          return umurC;
      }
    } catch (ex) {
      return 0;
    }
  }

  double getUmurCPercent(HcSummaryType type) {
    try {
      switch (type) {
        case HcSummaryType.EMPLOYEE:
          return umurC / getTotalAge(type) * 100;
        case HcSummaryType.BOC:
          return bocUmurC / getTotalAge(type) * 100;
        case HcSummaryType.BOD:
          return bodUmurC / getTotalAge(type) * 100;
        default:
          return umurC / getTotalAge(type) * 100;
      }
    } catch (ex) {
      return 0;
    }
  }

  int getUmurD(HcSummaryType type) {
    try {
      switch (type) {
        case HcSummaryType.EMPLOYEE:
          return umurD;
        case HcSummaryType.BOC:
          return bocUmurD;
        case HcSummaryType.BOD:
          return bodUmurD;
        default:
          return umurD;
      }
    } catch (ex) {
      return 0;
    }
  }

  double getUmurDPercent(HcSummaryType type) {
    try {
      switch (type) {
        case HcSummaryType.EMPLOYEE:
          return umurD / getTotalAge(type) * 100;
        case HcSummaryType.BOC:
          return bocUmurD / getTotalAge(type) * 100;
        case HcSummaryType.BOD:
          return bodUmurD / getTotalAge(type) * 100;
        default:
          return umurD / getTotalAge(type) * 100;
      }
    } catch (ex) {
      return 0;
    }
  }

  int getUmurE(HcSummaryType type) {
    try {
      switch (type) {
        case HcSummaryType.EMPLOYEE:
          return umurE;
        case HcSummaryType.BOC:
          return bocUmurE;
        case HcSummaryType.BOD:
          return bodUmurE;
        default:
          return umurE;
      }
    } catch (ex) {
      return 0;
    }
  }

  double getUmurEPercent(HcSummaryType type) {
    try {
      switch (type) {
        case HcSummaryType.EMPLOYEE:
          return umurE / getTotalAge(type) * 100;
        case HcSummaryType.BOC:
          return bocUmurE / getTotalAge(type) * 100;
        case HcSummaryType.BOD:
          return bodUmurE / getTotalAge(type) * 100;
        default:
          return umurE / getTotalAge(type) * 100;
      }
    } catch (ex) {
      return 0;
    }
  }
}

HcSummaryType convertToSummaryType(TotalBumnPageType type) {
  switch (type) {
    case TotalBumnPageType.HC_EMPLOYEE:
      return HcSummaryType.EMPLOYEE;
    case TotalBumnPageType.HC_DEKOM:
      return HcSummaryType.BOC;
    case TotalBumnPageType.HC_BOD:
      return HcSummaryType.BOD;
    default:
      return HcSummaryType.EMPLOYEE;
  }
}

HcSummaryType convertClusterToSummaryType(ClusterBumnPageType type) {
  switch (type) {
    case ClusterBumnPageType.HC_EMPLOYEE:
      return HcSummaryType.EMPLOYEE;
    case ClusterBumnPageType.HC_DEKOM:
      return HcSummaryType.BOC;
    case ClusterBumnPageType.HC_BOD:
      return HcSummaryType.BOD;
    default:
      return HcSummaryType.EMPLOYEE;
  }
}

HcSummaryType convertClassToSummaryType(KelasBumnPageType type) {
  switch (type) {
    case KelasBumnPageType.HC_EMPLOYEE:
      return HcSummaryType.EMPLOYEE;
    case KelasBumnPageType.HC_DEKOM:
      return HcSummaryType.BOC;
    case KelasBumnPageType.HC_BOD:
      return HcSummaryType.BOD;
    default:
      return HcSummaryType.EMPLOYEE;
  }
}