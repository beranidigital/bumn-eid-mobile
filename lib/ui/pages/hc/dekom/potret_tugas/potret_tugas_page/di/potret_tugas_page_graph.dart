import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/potret_tugas/potret_tugas_page/potret_tugas_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/potret_tugas/potret_tugas_page/potret_tugas_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class PotretTugasPageGraph extends Graph<PotretTugasPage> {

  PotretTugasPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the PotretTugasPage dependencies from injector to the instance
  @override
  void inject(PotretTugasPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<PotretTugasActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the PotretTugasPage dependencies:
  @override
  void register() {
    registerDependency<PotretTugasActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return PotretTugasActionMapper(store);
    });
  }
}
