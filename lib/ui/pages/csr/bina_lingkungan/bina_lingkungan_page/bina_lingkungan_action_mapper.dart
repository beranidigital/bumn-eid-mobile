import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_page/penyebaran_wilayah_page.dart';
import 'package:bumn_eid/ui/pages/csr/common/realisasi_dana_page/realisasi_dana_page.dart';
import 'package:redux/redux.dart';

class BinaLingkunganActionMapper extends ActionMapper {

  BinaLingkunganActionMapper(Store<AppState> store) : super(store);

  openRealisasiDana() => dispatch(NavigateToNextAction(destination: RealisasiDanaPageDestination(type: RealisasiDanaType.BINA_LINGKUNGAN)));

  openJenisPenyebaran() => dispatch(NavigateToNextAction(destination: JenisPenyebaranPageDestination()));

  openPenyebaranWilayah() => dispatch(NavigateToNextAction(destination: PenyebaranWilayahPageDestination(type: PenyebaranWilayahType.BINA_LINGKUNGAN)));

  openBlCompanies() => dispatch(NavigateToNextAction(destination: BLCompanyListPageDestination()));

}