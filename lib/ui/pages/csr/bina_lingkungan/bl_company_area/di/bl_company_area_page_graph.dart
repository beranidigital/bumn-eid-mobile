import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bl_company_area/bl_company_area_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bl_company_area/bl_company_area_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BlCompanyAreaPageGraph extends Graph<BlCompanyAreaPage> {

  BlCompanyAreaPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BlCompanyAreaPage dependencies from injector to the instance
  @override
  void inject(BlCompanyAreaPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.csrController = getDependency<CsrController>();
    subject.actionMapper = getDependency<BlCompanyAreaActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the BlCompanyAreaPage dependencies:
  @override
  void register() {
    registerDependency<BlCompanyAreaActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return BlCompanyAreaActionMapper(store);
    });
  }
}
