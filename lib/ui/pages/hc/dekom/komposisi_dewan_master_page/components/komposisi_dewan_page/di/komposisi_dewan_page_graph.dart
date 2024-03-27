import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/komposisi_dewan_page/komposisi_dewan_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/komposisi_dewan_page/komposisi_dewan_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class KomposisiDewanPageGraph extends Graph<KomposisiDewanPage> {

  KomposisiDewanPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the KomposisiDewanPage dependencies from injector to the instance
  @override
  void inject(KomposisiDewanPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<KomposisiDewanActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the KomposisiDewanPage dependencies:
  @override
  void register() {
    registerDependency<KomposisiDewanActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return KomposisiDewanActionMapper(store);
    });
  }
}
