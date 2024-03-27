import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_page/cluster_bumn_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_page/kelas_bumn_page.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/total/total_bumn_page/total_bumn_page.dart';
import 'package:redux/redux.dart';

class BODPageActionMapper extends ActionMapper {

  BODPageActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openKomposisiBOD() => dispatch(NavigateToNextAction(destination: KomposisiBODPageDestination()));

  openKebutuhanTalentPool() => dispatch(NavigateToNextAction(destination: BODTalentPoolPageDestination()));

  openKomposisiByClass() => dispatch(NavigateToNextAction(destination: BODClassPageDestination()));

  openTalentMobility() => _featureNotAvailable();

  openPotretMasaTugas() => dispatch(NavigateToNextAction(destination: PotretTugasBODPageDestination()));

  openPotretMasaTugasSaatIni() => dispatch(NavigateToNextAction(destination: PotretTugasBODPageDestination(now: true)));

  openShortlisting() => _featureNotAvailable();

  openPergantianBOD() => _featureNotAvailable();

  openProsesPenempatan() => _featureNotAvailable();

  openBodByCompany() => dispatch(NavigateToNextAction(destination: TotalBumnPageDestination(type: TotalBumnPageType.HC_BOD)));

  openBodByClass() => dispatch(NavigateToNextAction(destination: KelasBumnPageDestination(type: KelasBumnPageType.HC_BOD)));

  openBodByCluster() => dispatch(NavigateToNextAction(destination: ClusterBumnPageDestination(type: ClusterBumnPageType.HC_BOD)));

  openSearchPejabat() => dispatch(
    NavigateToNextAction(
      destination: SearchPeoplePageDestination()
    )
  );

}