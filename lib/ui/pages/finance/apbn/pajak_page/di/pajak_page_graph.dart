import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/apbn/pajak_page/pajak_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/apbn/pajak_page/pajak_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class PajakPageGraph extends Graph<PajakPage> {

  PajakPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the PajakPage dependencies from injector to the instance
  @override
  void inject(PajakPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.financeController = getDependency<FinanceController>();
    subject.actionMapper = getDependency<PajakActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the PajakPage dependencies:
  @override
  void register() {
    registerDependency<PajakActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return PajakActionMapper(store);
    });
  }
}