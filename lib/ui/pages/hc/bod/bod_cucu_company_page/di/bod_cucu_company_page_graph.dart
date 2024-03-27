import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_cucu_company_page/bod_cucu_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_cucu_company_page/bod_cucu_company_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BODCucuCompanyPageGraph extends Graph<BODCucuCompanyPage> {

  BODCucuCompanyPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BODCucuCompanyPage dependencies from injector to the instance
  @override
  void inject(BODCucuCompanyPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BODCucuCompanyActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the BODCucuCompanyPage dependencies:
  @override
  void register() {
    registerDependency<BODCucuCompanyActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BODCucuCompanyActionMapper(store);
    });
  }
}
