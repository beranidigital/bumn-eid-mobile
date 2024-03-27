import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_kelas/bod_1_kelas_detailed/bod_1_kelas_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_kelas/bod_1_kelas_detailed/bod_1_kelas_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BOD1KelasDetailedPageGraph extends Graph<BOD1KelasDetailedPage> {

  BOD1KelasDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BOD1KelasDetailedPage dependencies from injector to the instance
  @override
  void inject(BOD1KelasDetailedPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BOD1KelasDetailedActionMapper>();
    subject.hcController = getDependency<HcController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the BOD1KelasDetailedPage dependencies:
  @override
  void register() {
    registerDependency<BOD1KelasDetailedActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BOD1KelasDetailedActionMapper(store);
    });
  }
}
