import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/finance_page/finance_page.dart';
import 'package:bumn_eid/ui/pages/finance/finance_page/finance_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:redux/redux.dart';

class FinancePageGraph extends Graph<FinancePage> {
  FinancePageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the FinancePage dependencies from injector to the instance
  @override
  void inject(FinancePage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<FinancePageActionMapper>();
    subject.financeController = getDependency<FinanceController>();
  }

  // Inside this method, we register all the FinancePage dependencies:
  @override
  void register() {
    registerDependency<FinancePageActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return FinancePageActionMapper(store);
    });
  }
}
