import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/komposisi_dewan_master_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/komposisi_dewan_master_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class KomposisiDewanMasterPageGraph extends Graph<KomposisiDewanMasterPage> {

  KomposisiDewanMasterPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the KomposisiDewanMasterPage dependencies from injector to the instance
  @override
  void inject(KomposisiDewanMasterPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<KomposisiDewanMasterActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the KomposisiDewanMasterPage dependencies:
  @override
  void register() {
    registerDependency<KomposisiDewanMasterActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return KomposisiDewanMasterActionMapper(store);
    });
  }
}
