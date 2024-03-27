import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_by_anak_company_page/dekom_by_anak_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_by_anak_company_page/dekom_by_anak_company_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class DekomByAnakCompanyPageGraph extends Graph<DekomByAnakCompanyPage> {

  DekomByAnakCompanyPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the DekomByAnakCompanyPage dependencies from injector to the instance
  @override
  void inject(DekomByAnakCompanyPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<DekomByAnakCompanyActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the DekomByAnakCompanyPage dependencies:
  @override
  void register() {
    registerDependency<DekomByAnakCompanyActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return DekomByAnakCompanyActionMapper(store);
    });
  }
}
