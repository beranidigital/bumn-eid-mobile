import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/csr/csr_company_list/csr_company_list_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/csr/csr_company_list/csr_company_list_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CsrCompanyListPageGraph extends Graph<CsrCompanyListPage> {

  CsrCompanyListPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CsrCompanyListPage dependencies from injector to the instance
  @override
  void inject(CsrCompanyListPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<CsrCompanyListActionMapper>();
    subject.jenisController = getDependency<JenisController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the CsrCompanyListPage dependencies:
  @override
  void register() {
    registerDependency<CsrCompanyListActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return CsrCompanyListActionMapper(store);
    });
  }
}
