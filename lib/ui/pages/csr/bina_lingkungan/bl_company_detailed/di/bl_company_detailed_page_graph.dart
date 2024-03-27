import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bl_company_detailed/bl_company_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bl_company_detailed/bl_company_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BLCompanyDetailedPageGraph extends Graph<BLCompanyDetailedPage> {

  BLCompanyDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BLCompanyDetailedPage dependencies from injector to the instance
  @override
  void inject(BLCompanyDetailedPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BLCompanyDetailedActionMapper>();
    subject.csrController = getDependency<CsrController>();
  }

  // Inside this method, we register all the BLCompanyDetailedPage dependencies:
  @override
  void register() {
    registerDependency<BLCompanyDetailedActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BLCompanyDetailedActionMapper(store);
    });
  }
}
