import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_page/cluster_bumn_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_page/kelas_bumn_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/total/total_bumn_page/total_bumn_page.dart';
import 'package:redux/redux.dart';

class DewanKomisarisPageActionMapper extends ActionMapper {

  DewanKomisarisPageActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openKomposisiDekom() => dispatch(NavigateToNextAction(destination: KomposisiDewanPageDestination()));

  openPenataanKomposisi() => dispatch(NavigateToNextAction(destination: KomposisiDewanClassPageDestination()));

  openPergantianKomisaris() => _featureNotAvailable();

  openProsesPenempatan() => _featureNotAvailable();

  openPotretMasaTugas() => dispatch(NavigateToNextAction(destination: PotretTugasPageDestination()));

  openPotretMasaTugasSaatIni() => dispatch(NavigateToNextAction(destination: PotretTugasPageDestination(now: true)));

  openBocByCompany() => dispatch(NavigateToNextAction(destination: TotalBumnPageDestination(type: TotalBumnPageType.HC_DEKOM)));

  openBocByClass() => dispatch(NavigateToNextAction(destination: KelasBumnPageDestination(type: KelasBumnPageType.HC_DEKOM)));

  openBocByCluster() => dispatch(NavigateToNextAction(destination: ClusterBumnPageDestination(type: ClusterBumnPageType.HC_DEKOM)));

  openSearchPejabat() => dispatch(
      NavigateToNextAction(
          destination: SearchPeoplePageDestination()
      )
  );

}