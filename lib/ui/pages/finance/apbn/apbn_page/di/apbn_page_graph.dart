import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/apbn/apbn_page/apbn_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/apbn/apbn_page/apbn_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class APBNPageGraph extends Graph<APBNPage> {

  APBNPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the APBNPage dependencies from injector to the instance
  @override
  void inject(APBNPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<APBNActionMapper>();
    subject.financeController = getDependency<FinanceController>();
  }

  // Inside this method, we register all the APBNPage dependencies:
  @override
  void register() {
    registerDependency<APBNActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return APBNActionMapper(store);
    });
  }
}
