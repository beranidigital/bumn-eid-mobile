import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_page/penyebaran_wilayah_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_page/penyebaran_wilayah_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class PenyebaranWilayahPageGraph extends Graph<PenyebaranWilayahPage> {

  PenyebaranWilayahPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the PenyebaranWilayahPage dependencies from injector to the instance
  @override
  void inject(PenyebaranWilayahPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<PenyebaranWilayahActionMapper>();
    subject.csrController = getDependency<CsrController>();
  }

  // Inside this method, we register all the PenyebaranWilayahPage dependencies:
  @override
  void register() {
    registerDependency<PenyebaranWilayahActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return PenyebaranWilayahActionMapper(store);
    });
  }
}
