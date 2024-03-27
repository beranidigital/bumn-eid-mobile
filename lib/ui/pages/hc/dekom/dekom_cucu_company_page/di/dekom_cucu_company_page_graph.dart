import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_cucu_company_page/dekom_cucu_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_cucu_company_page/dekom_cucu_company_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class DekomCucuCompanyPageGraph extends Graph<DekomCucuCompanyPage> {

  DekomCucuCompanyPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the DekomCucuCompanyPage dependencies from injector to the instance
  @override
  void inject(DekomCucuCompanyPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<DekomCucuCompanyActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the DekomCucuCompanyPage dependencies:
  @override
  void register() {
    registerDependency<DekomCucuCompanyActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return DekomCucuCompanyActionMapper(store);
    });
  }
}
