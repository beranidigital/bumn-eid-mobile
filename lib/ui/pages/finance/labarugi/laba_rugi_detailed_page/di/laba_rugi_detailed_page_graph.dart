import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/labarugi/laba_rugi_detailed_page/laba_rugi_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/labarugi/laba_rugi_detailed_page/laba_rugi_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class LabaRugiDetailedPageGraph extends Graph<LabaRugiDetailedPage> {

  LabaRugiDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the LabaRugiDetailedPage dependencies from injector to the instance
  @override
  void inject(LabaRugiDetailedPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<LabaRugiDetailedActionMapper>();
    subject.financeController = getDependency<FinanceController>();
  }

  // Inside this method, we register all the LabaRugiDetailedPage dependencies:
  @override
  void register() {
    registerDependency<LabaRugiDetailedActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return LabaRugiDetailedActionMapper(store);
    });
  }
}
