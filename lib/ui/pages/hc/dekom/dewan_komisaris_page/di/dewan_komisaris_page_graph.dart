import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dewan_komisaris_page/dewan_komisaris_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dewan_komisaris_page/dewan_komisaris_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class DewanKomisarisPageGraph extends Graph<DewanKomisarisPage> {

  DewanKomisarisPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the HcPage dependencies from injector to the instance
  @override
  void inject(DewanKomisarisPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.actionMapper = getDependency<DewanKomisarisPageActionMapper>();
    subject.colorPalette = getDependency<ColorPalette>();
  }

  // Inside this method, we register all the HcPage dependencies:
  @override
  void register() {
    registerDependency((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return DewanKomisarisPageActionMapper(store);
    });
  }
}
