import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/labarugi/laba_rugi_page/laba_rugi_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/labarugi/laba_rugi_page/laba_rugi_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class LabaRugiPageGraph extends Graph<LabaRugiPage> {

  LabaRugiPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the LabaRugiPage dependencies from injector to the instance
  @override
  void inject(LabaRugiPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<LabaRugiActionMapper>();
    subject.financeController = getDependency<FinanceController>();
  }

  // Inside this method, we register all the LabaRugiPage dependencies:
  @override
  void register() {
    registerDependency<LabaRugiActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return LabaRugiActionMapper(store);
    });
  }
}
