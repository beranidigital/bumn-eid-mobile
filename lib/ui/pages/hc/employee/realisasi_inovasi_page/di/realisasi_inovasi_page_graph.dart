import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/employee/realisasi_inovasi_page/realisasi_inovasi_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/employee/realisasi_inovasi_page/realisasi_inovasi_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class RealisasiInovasiPageGraph extends Graph<RealisasiInovasiPage> {

  RealisasiInovasiPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the RealisasiInovasiPage dependencies from injector to the instance
  @override
  void inject(RealisasiInovasiPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<RealisasiInovasiActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the RealisasiInovasiPage dependencies:
  @override
  void register() {
    registerDependency<RealisasiInovasiActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return RealisasiInovasiActionMapper(store);
    });
  }
}
