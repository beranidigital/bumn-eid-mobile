import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/apbn/pnbp_page/pnbp_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/apbn/pnbp_page/pnbp_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class PnbpPageGraph extends Graph<PnbpPage> {

  PnbpPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the PnbpPage dependencies from injector to the instance
  @override
  void inject(PnbpPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.financeController = getDependency<FinanceController>();
    subject.actionMapper = getDependency<PnbpActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the PnbpPage dependencies:
  @override
  void register() {
    registerDependency<PnbpActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return PnbpActionMapper(store);
    });
  }
}