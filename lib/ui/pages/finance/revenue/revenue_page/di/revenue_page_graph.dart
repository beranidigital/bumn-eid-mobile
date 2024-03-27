import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/revenue/revenue_page/revenue_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/revenue/revenue_page/revenue_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class RevenuePageGraph extends Graph<RevenuePage> {

  RevenuePageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the RevenuePage dependencies from injector to the instance
  @override
  void inject(RevenuePage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.financeController = getDependency<FinanceController>();
    subject.actionMapper = getDependency<RevenueActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the RevenuePage dependencies:
  @override
  void register() {
    registerDependency<RevenueActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return RevenueActionMapper(store);
    });
  }
}
