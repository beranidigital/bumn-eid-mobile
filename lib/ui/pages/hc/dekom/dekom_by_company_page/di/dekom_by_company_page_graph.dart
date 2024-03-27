import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_by_company_page/dekom_by_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_by_company_page/dekom_by_company_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class DekomByCompanyPageGraph extends Graph<DekomByCompanyPage> {

  DekomByCompanyPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the DekomByCompanyPage dependencies from injector to the instance
  @override
  void inject(DekomByCompanyPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<DekomByCompanyActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the DekomByCompanyPage dependencies:
  @override
  void register() {
    registerDependency<DekomByCompanyActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return DekomByCompanyActionMapper(store);
    });
  }
}
