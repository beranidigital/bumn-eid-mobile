import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_kelas/bod_1_kelas_page/bod_1_kelas_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_kelas/bod_1_kelas_page/bod_1_kelas_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BOD1KelasPageGraph extends Graph<BOD1KelasPage> {

  BOD1KelasPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BOD1KelasPage dependencies from injector to the instance
  @override
  void inject(BOD1KelasPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BOD1KelasActionMapper>();
    subject.hcController = getDependency<HcController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the BOD1KelasPage dependencies:
  @override
  void register() {
    registerDependency<BOD1KelasActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BOD1KelasActionMapper(store);
    });
  }
}
