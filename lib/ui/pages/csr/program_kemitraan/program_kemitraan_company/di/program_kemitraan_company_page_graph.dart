import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/program_kemitraan_company/program_kemitraan_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/program_kemitraan_company/program_kemitraan_company_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class PKCompanyPageGraph extends Graph<PKCompanyPage> {

  PKCompanyPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the PKCompanyPage dependencies from injector to the instance
  @override
  void inject(PKCompanyPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<PKCompanyActionMapper>();
    subject.csrController = getDependency<CsrController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the PKCompanyPage dependencies:
  @override
  void register() {
    registerDependency<PKCompanyActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return PKCompanyActionMapper(store);
    });
  }
}
