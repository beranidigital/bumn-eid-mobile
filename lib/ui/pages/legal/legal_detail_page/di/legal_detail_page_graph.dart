import 'package:bumn_eid/core/controllers/legal_controller.dart';
import 'package:bumn_eid/core/controllers/pmo_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/legal/legal_detail_page/legal_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/legal/legal_detail_page/legal_detail_page.dart';
import 'package:bumn_eid/ui/pages/pmo/project_detail_page/project_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/pmo/project_detail_page/project_detail_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class LegalDetailPageGraph extends Graph<LegalDetailPage> {

  LegalDetailPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the LegalDetailPage dependencies from injector to the instance
  @override
  void inject(LegalDetailPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.legalController = getDependency<LegalController>();
    subject.actionMapper = getDependency<LegalDetailActionMapper>();
  }

  // Inside this method, we register all the LegalDetailPage dependencies:
  @override
  void register() {
    registerDependency<LegalDetailActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return LegalDetailActionMapper(store);
    });
  }
}
