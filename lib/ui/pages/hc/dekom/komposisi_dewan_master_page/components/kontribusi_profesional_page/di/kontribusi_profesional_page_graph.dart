import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/kontribusi_profesional_page/kontribusi_profesional_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/kontribusi_profesional_page/kontribusi_profesional_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class KontribusiProfesionalPageGraph extends Graph<KontribusiProfesionalPage> {

  KontribusiProfesionalPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the KontribusiProfesionalPage dependencies from injector to the instance
  @override
  void inject(KontribusiProfesionalPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<KontribusiProfesionalActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the KontribusiProfesionalPage dependencies:
  @override
  void register() {
    registerDependency<KontribusiProfesionalActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return KontribusiProfesionalActionMapper(store);
    });
  }
}
