import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_by_company_page/bod_by_company_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_by_company_page/bod_by_company_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BODByCompanyPageGraph extends Graph<BODByCompanyPage> {

  BODByCompanyPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BODByCompanyPage dependencies from injector to the instance
  @override
  void inject(BODByCompanyPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BODByCompanyActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the BODByCompanyPage dependencies:
  @override
  void register() {
    registerDependency<BODByCompanyActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BODByCompanyActionMapper(store);
    });
  }
}
