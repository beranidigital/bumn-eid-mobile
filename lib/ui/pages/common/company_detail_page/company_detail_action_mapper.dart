import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class CompanyDetailActionMapper extends ActionMapper {
  CompanyDetailActionMapper(Store<AppState> store) : super(store);

  featureNotAvailable() => dispatch(
      ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openImageDialog(String image) {
    if (image == null) {
      dispatch(ShowDialogAction(
          destination: FailedDialogDestination(
              title: "Error",
              errorMessage: "Mohon maaf, Gambar tidak tersedia"),
          barrierDismissible: true));
    } else {
      dispatch(ShowDialogAction(
          destination: ImageDialogDestination(image: image),
          barrierDismissible: true));
    }
  }

  openCompanyHCPage(String companyId) {
    dispatch(NavigateToNextAction(
        destination: CompanyBODPageDestination(companyId: companyId)));
  }

  openCompanyCosmicDetailPage(String companyId) {
    dispatch(NavigateToNextAction(
        destination: CovidCompanyDetailPageDestination(companyId: companyId)));
  }

  openCompanyCSRDetailPage(String id) => dispatch(NavigateToNextAction(
      destination: CompanyCsrDetailPageDestination(id: id)));

  openKinerjaPerusahaan(String companyId) => dispatch(NavigateToNextAction(
          destination: KinerjaPerusahaanPageDestination(
        id: companyId,
      )));

  openKontribusiNegara(String companyId) => dispatch(NavigateToNextAction(
          destination: KontribusiNegaraPageDestination(
        id: companyId,
      )));

  openOperasionalPerusahaan(String companyId) => dispatch(NavigateToNextAction(
          destination: OperasionalPerusahaanPageDestination(
        id: companyId,
      )));
}
