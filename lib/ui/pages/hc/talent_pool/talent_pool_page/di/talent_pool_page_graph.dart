import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_page/talent_pool_page.dart';
import 'package:bumn_eid/ui/pages/hc/talent_pool/talent_pool_page/talent_pool_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class TalentPoolPageGraph extends Graph<TalentPoolPage> {

  TalentPoolPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the TalentPoolPage dependencies from injector to the instance
  @override
  void inject(TalentPoolPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<TalentPoolPageActionMapper>();
  }

  // Inside this method, we register all the TalentPoolPage dependencies:
  @override
  void register() {
    registerDependency<TalentPoolPageActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return TalentPoolPageActionMapper(store);
    });
  }
}
