import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran_detailed/component/jenis_penyebaran_company/jenis_penyebaran_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/jenis_penyebaran_detailed/component/jenis_penyebaran_company/jenis_penyebaran_company_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class JenisPenyebaranCompanyPageGraph extends Graph<JenisPenyebaranCompanyPage> {

  JenisPenyebaranCompanyPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the JenisPenyebaranCompanyPage dependencies from injector to the instance
  @override
  void inject(JenisPenyebaranCompanyPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<JenisPenyebaranCompanyActionMapper>();
    subject.csrController = getDependency<CsrController>();
  }

  // Inside this method, we register all the JenisPenyebaranCompanyPage dependencies:
  @override
  void register() {
    registerDependency<JenisPenyebaranCompanyActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return JenisPenyebaranCompanyActionMapper(store);
    });
  }
}
