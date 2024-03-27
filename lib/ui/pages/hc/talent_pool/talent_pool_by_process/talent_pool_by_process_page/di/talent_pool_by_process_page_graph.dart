import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_process_page/talent_pool_by_process_page.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_by_process/talent_pool_by_process_page/talent_pool_by_process_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class TalentPoolByProcessPageGraph extends Graph<TalentPoolByProcessPage> {

  TalentPoolByProcessPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the TalentPoolByProcessPage dependencies from injector to the instance
  @override
  void inject(TalentPoolByProcessPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<TalentPoolByProcessPageActionMapper>();
  }

  // Inside this method, we register all the TalentPoolByProcessPage dependencies:
  @override
  void register() {
    registerDependency<TalentPoolByProcessPageActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return TalentPoolByProcessPageActionMapper(store);
    });
  }
}
