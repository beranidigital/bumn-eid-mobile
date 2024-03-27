import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran/jenis_penyebaran_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran/jenis_penyebaran_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class JenisPenyebaranPageGraph extends Graph<JenisPenyebaranPage> {

  JenisPenyebaranPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the JenisPenyebaranPage dependencies from injector to the instance
  @override
  void inject(JenisPenyebaranPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.csrController = getDependency<CsrController>();
    subject.actionMapper = getDependency<JenisPenyebaranActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the JenisPenyebaranPage dependencies:
  @override
  void register() {
    registerDependency<JenisPenyebaranActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return JenisPenyebaranActionMapper(store);
    });
  }
}
