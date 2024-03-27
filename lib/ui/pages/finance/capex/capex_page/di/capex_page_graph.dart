import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/capex/capex_page/capex_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/capex/capex_page/capex_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CapexPageGraph extends Graph<CapexPage> {

  CapexPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CapexPage dependencies from injector to the instance
  @override
  void inject(CapexPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<CapexActionMapper>();
    subject.financeController = getDependency<FinanceController>();
  }

  // Inside this method, we register all the CapexPage dependencies:
  @override
  void register() {
    registerDependency<CapexActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return CapexActionMapper(store);
    });
  }
}
