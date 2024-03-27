import 'package:bumn_eid/core/controllers/pmo_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/pmo/pmo_page/pmo_page.dart';
import 'package:bumn_eid/ui/pages/pmo/pmo_page/pmo_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class PMOPageGraph extends Graph<PMOPage> {

  PMOPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the PMOPage dependencies from injector to the instance
  @override
  void inject(PMOPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<PMOPageActionMapper>();
    subject.pmoController = getDependency<PMOController>();
  }

  // Inside this method, we register all the PMOPage dependencies:
  @override
  void register() {
    registerDependency<PMOPageActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return PMOPageActionMapper(store);
    });
  }
}
