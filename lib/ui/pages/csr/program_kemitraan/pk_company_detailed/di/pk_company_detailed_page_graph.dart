import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/pk_company_detailed/pk_company_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/pk_company_detailed/pk_company_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class PKCompanyDetailedPageGraph extends Graph<PKCompanyDetailedPage> {

  PKCompanyDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the PKCompanyDetailedPage dependencies from injector to the instance
  @override
  void inject(PKCompanyDetailedPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<PKCompanyDetailedActionMapper>();
    subject.csrController = getDependency<CsrController>();
  }

  // Inside this method, we register all the PKCompanyDetailedPage dependencies:
  @override
  void register() {
    registerDependency<PKCompanyDetailedActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return PKCompanyDetailedActionMapper(store);
    });
  }
}
