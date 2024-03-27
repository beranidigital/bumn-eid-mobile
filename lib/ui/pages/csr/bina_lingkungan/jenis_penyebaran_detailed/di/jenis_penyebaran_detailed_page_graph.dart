import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran_detailed/jenis_penyebaran_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran_detailed/jenis_penyebaran_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class JenisPenyebaranDetailedPageGraph extends Graph<JenisPenyebaranDetailedPage> {

  JenisPenyebaranDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the JenisPenyebaranDetailedPage dependencies from injector to the instance
  @override
  void inject(JenisPenyebaranDetailedPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<JenisPenyebaranDetailedActionMapper>();
    subject.csrController = getDependency<CsrController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the JenisPenyebaranDetailedPage dependencies:
  @override
  void register() {
    registerDependency<JenisPenyebaranDetailedActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return JenisPenyebaranDetailedActionMapper(store);
    });
  }
}
