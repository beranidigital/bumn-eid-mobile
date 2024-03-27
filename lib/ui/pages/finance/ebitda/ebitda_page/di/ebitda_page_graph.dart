import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/ebitda/ebitda_page/ebitda_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/ebitda/ebitda_page/ebitda_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class EbitdaPageGraph extends Graph<EbitdaPage> {

  EbitdaPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the EbitdaPage dependencies from injector to the instance
  @override
  void inject(EbitdaPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.financeController = getDependency<FinanceController>();
    subject.actionMapper = getDependency<EbitdaActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the EbitdaPage dependencies:
  @override
  void register() {
    registerDependency<EbitdaActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return EbitdaActionMapper(store);
    });
  }
}