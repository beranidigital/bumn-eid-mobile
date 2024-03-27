import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/loan/loan/loan_page/loan_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/loan/loan/loan_page/loan_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class LoanPageGraph extends Graph<LoanPage> {

  LoanPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the LoanPage dependencies from injector to the instance
  @override
  void inject(LoanPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.financeController = getDependency<FinanceController>();
    subject.actionMapper = getDependency<LoanActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the LoanPage dependencies:
  @override
  void register() {
    registerDependency<LoanActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return LoanActionMapper(store);
    });
  }
}