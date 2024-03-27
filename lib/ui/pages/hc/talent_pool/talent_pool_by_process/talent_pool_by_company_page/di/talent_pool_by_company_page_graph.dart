import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_company_page/talent_pool_by_company_page.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_company_page/talent_pool_by_company_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class TalentPoolByCompanyPageGraph extends Graph<TalentPoolByCompanyPage> {

  TalentPoolByCompanyPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the TalentPoolByCompanyPage dependencies from injector to the instance
  @override
  void inject(TalentPoolByCompanyPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<TalentPoolByCompanyPageActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the TalentPoolByCompanyPage dependencies:
  @override
  void register() {
    registerDependency<TalentPoolByCompanyPageActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return TalentPoolByCompanyPageActionMapper(store);
    });
  }
}
