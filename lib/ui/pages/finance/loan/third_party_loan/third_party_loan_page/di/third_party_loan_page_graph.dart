import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/loan/third_party_loan/third_party_loan_page/third_party_loan_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/loan/third_party_loan/third_party_loan_page/third_party_loan_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class ThirdPartyLoanPageGraph extends Graph<ThirdPartyLoanPage> {

  ThirdPartyLoanPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the ThirdPartyLoanPage dependencies from injector to the instance
  @override
  void inject(ThirdPartyLoanPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.financeController = getDependency<FinanceController>();
    subject.actionMapper = getDependency<ThirdPartyLoanActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the ThirdPartyLoanPage dependencies:
  @override
  void register() {
    registerDependency<ThirdPartyLoanActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return ThirdPartyLoanActionMapper(store);
    });
  }
}