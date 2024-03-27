import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_talent_pool_page/bod_talent_pool_page/bod_talent_pool_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_talent_pool_page/bod_talent_pool_page/bod_talent_pool_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BODTalentPoolPageGraph extends Graph<BODTalentPoolPage> {

  BODTalentPoolPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BODTalentPoolPage dependencies from injector to the instance
  @override
  void inject(BODTalentPoolPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BODTalentPoolActionMapper>();
    subject.hcController = getDependency<HcController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the BODTalentPoolPage dependencies:
  @override
  void register() {
    registerDependency<BODTalentPoolActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BODTalentPoolActionMapper(store);
    });
  }
}
