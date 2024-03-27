import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_page/bod_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_page/bod_page_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dewan_komisaris_page/dewan_komisaris_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dewan_komisaris_page/dewan_komisaris_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BODPageGraph extends Graph<BODPage> {

  BODPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the HcPage dependencies from injector to the instance
  @override
  void inject(BODPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.actionMapper = getDependency<BODPageActionMapper>();
    subject.colorPalette = getDependency<ColorPalette>();
  }

  // Inside this method, we register all the HcPage dependencies:
  @override
  void register() {
    registerDependency((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BODPageActionMapper(store);
    });
  }
}
