import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_by_anak_company_page/bod_by_anak_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_by_anak_company_page/bod_by_anak_company_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BODByAnakCompanyPageGraph extends Graph<BODByAnakCompanyPage> {

  BODByAnakCompanyPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BODByAnakCompanyPage dependencies from injector to the instance
  @override
  void inject(BODByAnakCompanyPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BODByAnakCompanyActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the BODByAnakCompanyPage dependencies:
  @override
  void register() {
    registerDependency<BODByAnakCompanyActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BODByAnakCompanyActionMapper(store);
    });
  }
}
