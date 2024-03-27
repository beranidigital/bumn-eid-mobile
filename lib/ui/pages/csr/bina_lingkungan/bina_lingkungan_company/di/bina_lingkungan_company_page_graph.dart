import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bina_lingkungan_company/bina_lingkungan_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bina_lingkungan_company/bina_lingkungan_company_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BLCompanyPageGraph extends Graph<BLCompanyPage> {

  BLCompanyPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BLCompanyPage dependencies from injector to the instance
  @override
  void inject(BLCompanyPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BLCompanyActionMapper>();
    subject.csrController = getDependency<CsrController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the BLCompanyPage dependencies:
  @override
  void register() {
    registerDependency<BLCompanyActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BLCompanyActionMapper(store);
    });
  }
}
