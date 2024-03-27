import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/apbn/dividen_page/dividen_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/apbn/dividen_page/dividen_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class DividenPageGraph extends Graph<DividenPage> {

  DividenPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the DividenPage dependencies from injector to the instance
  @override
  void inject(DividenPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.financeController = getDependency<FinanceController>();
    subject.actionMapper = getDependency<DividenActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the DividenPage dependencies:
  @override
  void register() {
    registerDependency<DividenActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return DividenActionMapper(store);
    });
  }
}