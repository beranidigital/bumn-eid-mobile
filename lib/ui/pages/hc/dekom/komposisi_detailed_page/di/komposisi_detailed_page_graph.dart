import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_detailed_page/komposisi_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_detailed_page/komposisi_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class KomposisiDetailedPageGraph extends Graph<KomposisiDetailedPage> {

  KomposisiDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the KomposisiDetailedPage dependencies from injector to the instance
  @override
  void inject(KomposisiDetailedPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<KomposisiDetailedActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the KomposisiDetailedPage dependencies:
  @override
  void register() {
    registerDependency<KomposisiDetailedActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return KomposisiDetailedActionMapper(store);
    });
  }
}
