import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/pk_company_area/pk_company_area_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/pk_company_area/pk_company_area_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class PkCompanyAreaPageGraph extends Graph<PkCompanyAreaPage> {

  PkCompanyAreaPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the PkCompanyAreaPage dependencies from injector to the instance
  @override
  void inject(PkCompanyAreaPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.csrController = getDependency<CsrController>();
    subject.actionMapper = getDependency<PkCompanyAreaActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the PkCompanyAreaPage dependencies:
  @override
  void register() {
    registerDependency<PkCompanyAreaActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return PkCompanyAreaActionMapper(store);
    });
  }
}
