import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/common/csr_detail_page/csr_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/common/csr_detail_page/csr_detail_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CsrDetailPageGraph extends Graph<CsrDetailPage> {

  CsrDetailPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CsrDetailPage dependencies from injector to the instance
  @override
  void inject(CsrDetailPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.csrController = getDependency<CsrController>();
    subject.actionMapper = getDependency<CsrDetailActionMapper>();
  }

  // Inside this method, we register all the CsrDetailPage dependencies:
  @override
  void register() {
    registerDependency<CsrDetailActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CsrDetailActionMapper(store);
    });
  }
}
