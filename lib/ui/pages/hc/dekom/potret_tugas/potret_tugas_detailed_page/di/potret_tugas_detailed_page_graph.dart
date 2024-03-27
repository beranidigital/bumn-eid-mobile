import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/potret_tugas/potret_tugas_detailed_page/potret_tugas_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/potret_tugas/potret_tugas_detailed_page/potret_tugas_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class PotretTugasDetailedPageGraph extends Graph<PotretTugasDetailedPage> {

  PotretTugasDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the PotretTugasDetailedPage dependencies from injector to the instance
  @override
  void inject(PotretTugasDetailedPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<PotretTugasDetailedActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the PotretTugasDetailedPage dependencies:
  @override
  void register() {
    registerDependency<PotretTugasDetailedActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return PotretTugasDetailedActionMapper(store);
    });
  }
}
