import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_by_anak_company_page/dekom_by_anak_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_by_anak_company_page/dekom_by_anak_company_page.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_by_cucu_company_page/dekom_by_cucu_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_by_cucu_company_page/dekom_by_cucu_company_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class DekomByCucuCompanyPageGraph extends Graph<DekomByCucuCompanyPage> {

  DekomByCucuCompanyPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the DekomByCucuCompanyPage dependencies from injector to the instance
  @override
  void inject(DekomByCucuCompanyPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<DekomByCucuCompanyActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the DekomByCucuCompanyPage dependencies:
  @override
  void register() {
    registerDependency<DekomByCucuCompanyActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return DekomByCucuCompanyActionMapper(store);
    });
  }
}
