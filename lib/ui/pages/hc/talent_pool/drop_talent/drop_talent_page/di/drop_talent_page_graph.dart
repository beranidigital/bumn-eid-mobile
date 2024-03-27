import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/drop_talent/drop_talent_page/drop_talent_page.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/drop_talent/drop_talent_page/drop_talent_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class DropTalentPageGraph extends Graph<DropTalentPage> {

  DropTalentPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the DropTalentPage dependencies from injector to the instance
  @override
  void inject(DropTalentPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<DropTalentPageActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the DropTalentPage dependencies:
  @override
  void register() {
    registerDependency<DropTalentPageActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return DropTalentPageActionMapper(store);
    });
  }
}
