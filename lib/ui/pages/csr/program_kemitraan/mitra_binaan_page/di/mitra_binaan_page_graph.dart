import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/mitra_binaan_page/mitra_binaan_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/mitra_binaan_page/mitra_binaan_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class MitraBinaanPageGraph extends Graph<MitraBinaanPage> {

  MitraBinaanPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the MitraBinaanPage dependencies from injector to the instance
  @override
  void inject(MitraBinaanPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<MitraBinaanActionMapper>();
    subject.csrController = getDependency<CsrController>();
  }

  // Inside this method, we register all the MitraBinaanPage dependencies:
  @override
  void register() {
    registerDependency<MitraBinaanActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return MitraBinaanActionMapper(store);
    });
  }
}
