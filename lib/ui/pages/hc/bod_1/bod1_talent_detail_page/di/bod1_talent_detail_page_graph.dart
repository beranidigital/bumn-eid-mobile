import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod1_talent_detail_page/bod1_talent_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod1_talent_detail_page/bod1_talent_detail_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BOD1TalentDetailPageGraph extends Graph<BOD1TalentDetailPage> {

  BOD1TalentDetailPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BOD1TalentDetailPage dependencies from injector to the instance
  @override
  void inject(BOD1TalentDetailPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.hcController = getDependency<HcController>();
    subject.actionMapper = getDependency<BOD1TalentDetailActionMapper>();
  }

  // Inside this method, we register all the BOD1TalentDetailPage dependencies:
  @override
  void register() {
    registerDependency<BOD1TalentDetailActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return BOD1TalentDetailActionMapper(store);
    });
  }
}
