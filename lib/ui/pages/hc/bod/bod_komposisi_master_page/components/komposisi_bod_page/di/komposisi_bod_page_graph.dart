import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/components/komposisi_bod_page/komposisi_bod_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/components/komposisi_bod_page/komposisi_bod_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class KomposisiBODPageGraph extends Graph<KomposisiBODPage> {

  KomposisiBODPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the KomposisiBODPage dependencies from injector to the instance
  @override
  void inject(KomposisiBODPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<KomposisiBODActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the KomposisiBODPage dependencies:
  @override
  void register() {
    registerDependency<KomposisiBODActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return KomposisiBODActionMapper(store);
    });
  }
}
