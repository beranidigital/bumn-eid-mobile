import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_class/komposisi_dewan_class_detailed_page/komposisi_dewan_class_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_class/komposisi_dewan_class_detailed_page/komposisi_dewan_class_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class KomposisiDewanClassDetailedPageGraph extends Graph<KomposisiDewanClassDetailedPage> {

  KomposisiDewanClassDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the KomposisiDewanClassDetailedPage dependencies from injector to the instance
  @override
  void inject(KomposisiDewanClassDetailedPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<KomposisiDewanClassDetailedActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the KomposisiDewanClassDetailedPage dependencies:
  @override
  void register() {
    registerDependency<KomposisiDewanClassDetailedActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return KomposisiDewanClassDetailedActionMapper(store);
    });
  }
}
