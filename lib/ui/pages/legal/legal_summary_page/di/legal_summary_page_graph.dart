import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/controllers/legal_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/legal/legal_summary_page/legal_summary_page.dart';
import 'package:bumn_eid/ui/pages/legal/legal_summary_page/legal_summary_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:redux/redux.dart';

class LegalSummaryPageGraph extends Graph<LegalSummaryPage> {
  LegalSummaryPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the LegalSummaryPage dependencies from injector to the instance
  @override
  void inject(LegalSummaryPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.actionMapper = getDependency<LegalSummaryPageActionMapper>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.legalController = getDependency<LegalController>();
    subject.jenisController = getDependency<JenisController>();
  }

  // Inside this method, we register all the LegalSummaryPage dependencies:
  @override
  void register() {
    registerDependency((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return LegalSummaryPageActionMapper(store);
    });
  }
}
