import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/loan/loan_main_page/loan_main_page.dart';
import 'package:bumn_eid/ui/pages/finance/loan/loan_main_page/loan_main_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class LoanMainPageGraph extends Graph<LoanMainPage> {

  LoanMainPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the LoanMainPage dependencies from injector to the instance
  @override
  void inject(LoanMainPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<LoanMainPageActionMapper>();
  }

  // Inside this method, we register all the LoanMainPage dependencies:
  @override
  void register() {
    registerDependency<LoanMainPageActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return LoanMainPageActionMapper(store);
    });
  }
}
