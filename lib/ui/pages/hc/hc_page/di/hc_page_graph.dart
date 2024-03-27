import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/hc_page/hc_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/pages/hc/hc_page/hc_page.dart';
import 'package:redux/redux.dart';

class HcPageGraph extends Graph<HcPage> {

  HcPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the HcPage dependencies from injector to the instance
  @override
  void inject(HcPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.actionMapper = getDependency<HcPageActionMapper>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the HcPage dependencies:
  @override
  void register() {
    registerDependency((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return HcPageActionMapper(store);
    });
  }
}
