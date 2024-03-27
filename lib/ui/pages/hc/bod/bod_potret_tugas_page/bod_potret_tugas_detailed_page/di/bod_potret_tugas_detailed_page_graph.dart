import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_potret_tugas_page/bod_potret_tugas_detailed_page/bod_potret_tugas_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_potret_tugas_page/bod_potret_tugas_detailed_page/bod_potret_tugas_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BODPotretTugasDetailedPageGraph extends Graph<BODPotretTugasDetailedPage> {

  BODPotretTugasDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BODPotretTugasDetailedPage dependencies from injector to the instance
  @override
  void inject(BODPotretTugasDetailedPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BODPotretTugasDetailedActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the BODPotretTugasDetailedPage dependencies:
  @override
  void register() {
    registerDependency<BODPotretTugasDetailedActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BODPotretTugasDetailedActionMapper(store);
    });
  }
}
