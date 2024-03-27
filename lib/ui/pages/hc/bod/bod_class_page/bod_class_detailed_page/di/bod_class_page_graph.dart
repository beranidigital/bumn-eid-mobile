import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_class_page/bod_class_detailed_page/bod_class_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_class_page/bod_class_detailed_page/bod_class_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BODClassDetailedPageGraph extends Graph<BODClassDetailedPage> {

  BODClassDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BODClassDetailedPage dependencies from injector to the instance
  @override
  void inject(BODClassDetailedPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BODClassDetailedActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the BODClassDetailedPage dependencies:
  @override
  void register() {
    registerDependency<BODClassDetailedActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BODClassDetailedActionMapper(store);
    });
  }
}
