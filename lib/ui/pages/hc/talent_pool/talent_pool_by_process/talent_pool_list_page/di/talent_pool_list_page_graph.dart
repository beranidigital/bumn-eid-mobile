import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_list_page/talent_pool_list_page.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_list_page/talent_pool_list_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class TalentPoolListPageGraph extends Graph<TalentPoolListPage> {

  TalentPoolListPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the TalentPoolListPage dependencies from injector to the instance
  @override
  void inject(TalentPoolListPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<TalentPoolListPageActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the TalentPoolListPage dependencies:
  @override
  void register() {
    registerDependency<TalentPoolListPageActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return TalentPoolListPageActionMapper(store);
    });
  }
}
