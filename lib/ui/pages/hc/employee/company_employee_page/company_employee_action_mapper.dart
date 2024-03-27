import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class CompanyEmployeeActionMapper extends ActionMapper {

  CompanyEmployeeActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openProfilKaryawan(ProfilPerusahaan company) =>
      dispatch(NavigateToNextAction(destination: ProfileEmployeePageDestination(company: company)));

  openTalentPool(ProfilPerusahaan company) => _featureNotAvailable();

  openAnggaranKaryawan(ProfilPerusahaan company) => _featureNotAvailable();

  openPerformanceDistribution(ProfilPerusahaan company) => _featureNotAvailable();

  openBiayaKaryawan(ProfilPerusahaan company) => _featureNotAvailable();

  openAnggaranLearning(ProfilPerusahaan company) => dispatch(NavigateToNextAction(destination: RealisasiLearningPageDestination(company: company)));

  openAnggaranInovasi(ProfilPerusahaan company) => dispatch(NavigateToNextAction(destination: RealisasiInovasiPageDestination(company: company)));

  openPotretMasaTugas(ProfilPerusahaan company) => _featureNotAvailable();


}