import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/employee/realisasi_learning_page/realisasi_learning_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/employee/realisasi_learning_page/realisasi_learning_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class RealisasiLearningPageGraph extends Graph<RealisasiLearningPage> {

  RealisasiLearningPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the RealisasiLearningPage dependencies from injector to the instance
  @override
  void inject(RealisasiLearningPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<RealisasiLearningActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the RealisasiLearningPage dependencies:
  @override
  void register() {
    registerDependency<RealisasiLearningActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return RealisasiLearningActionMapper(store);
    });
  }
}
