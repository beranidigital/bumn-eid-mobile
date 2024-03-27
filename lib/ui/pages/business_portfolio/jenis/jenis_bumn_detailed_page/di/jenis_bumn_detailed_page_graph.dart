import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/jenis/jenis_bumn_detailed_page/jenis_bumn_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/jenis/jenis_bumn_detailed_page/jenis_bumn_detailed_page.dart';
import 'package:redux/redux.dart';

class JenisBumnDetailedPageGraph extends Graph<JenisBumnDetailedPage> {

  JenisBumnDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the JenisBumnDetailedPage dependencies from injector to the instance
  @override
  void inject(JenisBumnDetailedPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.jenisController = getDependency<JenisController>();
    subject.actionMapper = getDependency<JenisBumnDetailedActionMapper>();
  }

  // Inside this method, we register all the JenisBumnDetailedPage dependencies:
  @override
  void register() {
    registerDependency<JenisBumnDetailedActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return JenisBumnDetailedActionMapper(store);
    });
  }
}
