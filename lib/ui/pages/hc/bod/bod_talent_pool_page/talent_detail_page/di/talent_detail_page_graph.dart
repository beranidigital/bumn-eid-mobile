import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_talent_pool_page/talent_detail_page/talent_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_talent_pool_page/talent_detail_page/talent_detail_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class TalentDetailPageGraph extends Graph<TalentDetailPage> {

  TalentDetailPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the TalentDetailPage dependencies from injector to the instance
  @override
  void inject(TalentDetailPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.hcController = getDependency<HcController>();
    subject.actionMapper = getDependency<TalentDetailActionMapper>();
  }

  // Inside this method, we register all the TalentDetailPage dependencies:
  @override
  void register() {
    registerDependency<TalentDetailActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return TalentDetailActionMapper(store);
    });
  }
}
