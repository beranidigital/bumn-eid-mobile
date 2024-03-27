import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_page/bod_1_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_page/bod_1_page_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/employee/employee_page/employee_page.dart';
import 'package:bumn_eid/ui/pages/hc/employee/employee_page/employee_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BOD1PageGraph extends Graph<BOD1Page> {

  BOD1PageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BOD1Page dependencies from injector to the instance
  @override
  void inject(BOD1Page subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BOD1PageActionMapper>();
  }

  // Inside this method, we register all the BOD1Page dependencies:
  @override
  void register() {
    registerDependency<BOD1PageActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return BOD1PageActionMapper(store);
    });
  }
}
