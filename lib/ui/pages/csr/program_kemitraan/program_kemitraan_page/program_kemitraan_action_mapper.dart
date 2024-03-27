import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_page/penyebaran_wilayah_page.dart';
import 'package:bumn_eid/ui/pages/csr/common/realisasi_dana_page/realisasi_dana_page.dart';
import 'package:redux/redux.dart';

class ProgramKemitraanActionMapper extends ActionMapper {

  ProgramKemitraanActionMapper(Store<AppState> store) : super(store);

  openRealisasiDana() => dispatch(NavigateToNextAction(destination: RealisasiDanaPageDestination(type: RealisasiDanaType.PROGRAM_KEMITRAAN)));

  openSektorPenyaluran() => dispatch(NavigateToNextAction(destination: SektorPenyaluranPageDestination()));

  openPenyebaranWilayah() => dispatch(NavigateToNextAction(destination: PenyebaranWilayahPageDestination(type: PenyebaranWilayahType.PROGRAM_KEMITRAAN)));

  openMitraBinaan() => dispatch(NavigateToNextAction(destination: MitraBinaanPageDestination()));

  openPkByCompany() => dispatch(NavigateToNextAction(destination: PKCompanyListPageDestination()));

}