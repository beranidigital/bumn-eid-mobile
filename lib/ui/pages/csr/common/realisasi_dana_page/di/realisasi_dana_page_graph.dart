import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/common/realisasi_dana_page/realisasi_dana_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/common/realisasi_dana_page/realisasi_dana_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class RealisasiDanaPageGraph extends Graph<RealisasiDanaPage> {

  RealisasiDanaPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the RealisasiDanaPage dependencies from injector to the instance
  @override
  void inject(RealisasiDanaPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<RealisasiDanaActionMapper>();
    subject.csrController = getDependency<CsrController>();
  }

  // Inside this method, we register all the RealisasiDanaPage dependencies:
  @override
  void register() {
    registerDependency<RealisasiDanaActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return RealisasiDanaActionMapper(store);
    });
  }
}
