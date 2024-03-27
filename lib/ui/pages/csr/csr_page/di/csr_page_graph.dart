import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/csr_page/csr_page.dart';
import 'package:bumn_eid/ui/pages/csr/csr_page/csr_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:redux/redux.dart';

class CsrPageGraph extends Graph<CsrPage> {
  CsrPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CsrPage dependencies from injector to the instance
  @override
  void inject(CsrPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<CsrPageActionMapper>();
    subject.csrController = getDependency<CsrController>();
  }

  // Inside this method, we register all the CsrPage dependencies:
  @override
  void register() {
    registerDependency<CsrPageActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CsrPageActionMapper(store);
    });
  }
}
