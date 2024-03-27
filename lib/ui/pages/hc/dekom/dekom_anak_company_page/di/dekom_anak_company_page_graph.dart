import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_anak_company_page/dekom_anak_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/dekom_anak_company_page/dekom_anak_company_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class DekomAnakCompanyPageGraph extends Graph<DekomAnakCompanyPage> {

  DekomAnakCompanyPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the DekomAnakCompanyPage dependencies from injector to the instance
  @override
  void inject(DekomAnakCompanyPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<DekomAnakCompanyActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the DekomAnakCompanyPage dependencies:
  @override
  void register() {
    registerDependency<DekomAnakCompanyActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return DekomAnakCompanyActionMapper(store);
    });
  }
}
