import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran_detailed/component/jenis_penyebaran_area/jenis_penyebaran_area_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran_detailed/component/jenis_penyebaran_area/jenis_penyebaran_area_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class JenisPenyebaranAreaPageGraph extends Graph<JenisPenyebaranAreaPage> {

  JenisPenyebaranAreaPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the JenisPenyebaranAreaPage dependencies from injector to the instance
  @override
  void inject(JenisPenyebaranAreaPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<JenisPenyebaranAreaActionMapper>();
    subject.csrController = getDependency<CsrController>();
  }

  // Inside this method, we register all the JenisPenyebaranAreaPage dependencies:
  @override
  void register() {
    registerDependency<JenisPenyebaranAreaActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return JenisPenyebaranAreaActionMapper(store);
    });
  }
}
