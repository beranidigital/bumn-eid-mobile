import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/capex/capex_detailed_page/capex_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/capex/capex_detailed_page/capex_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CapexDetailedPageGraph extends Graph<CapexDetailedPage> {

  CapexDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CapexDetailedPage dependencies from injector to the instance
  @override
  void inject(CapexDetailedPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<CapexDetailedActionMapper>();
    subject.financeController = getDependency<FinanceController>();
  }

  // Inside this method, we register all the CapexDetailedPage dependencies:
  @override
  void register() {
    registerDependency<CapexDetailedActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CapexDetailedActionMapper(store);
    });
  }
}
