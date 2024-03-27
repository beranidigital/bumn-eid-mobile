import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/loan/suspi/suspi_page/suspi_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/loan/suspi/suspi_page/suspi_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class SuspiPageGraph extends Graph<SuspiPage> {

  SuspiPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the SuspiPage dependencies from injector to the instance
  @override
  void inject(SuspiPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.financeController = getDependency<FinanceController>();
    subject.actionMapper = getDependency<SuspiActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the SuspiPage dependencies:
  @override
  void register() {
    registerDependency<SuspiActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return SuspiActionMapper(store);
    });
  }
}