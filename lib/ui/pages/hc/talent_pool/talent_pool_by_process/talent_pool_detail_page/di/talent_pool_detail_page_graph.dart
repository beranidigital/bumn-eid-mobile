import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_detail_page/talent_pool_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_detail_page/talent_pool_detail_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class TalentPoolDetailPageGraph extends Graph<TalentPoolDetailPage> {

  TalentPoolDetailPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the TalentPoolDetailPage dependencies from injector to the instance
  @override
  void inject(TalentPoolDetailPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.hcController = getDependency<HcController>();
    subject.actionMapper = getDependency<TalentPoolDetailActionMapper>();
  }

  // Inside this method, we register all the TalentPoolDetailPage dependencies:
  @override
  void register() {
    registerDependency<TalentPoolDetailActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return TalentPoolDetailActionMapper(store);
    });
  }
}
