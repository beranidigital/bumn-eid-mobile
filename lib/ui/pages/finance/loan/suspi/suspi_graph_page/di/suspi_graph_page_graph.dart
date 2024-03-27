import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/loan/suspi/suspi_graph_page/suspi_graph_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/loan/suspi/suspi_graph_page/suspi_graph_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class SuspiGraphPageGraph extends Graph<SuspiGraphPage> {

  SuspiGraphPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the SuspiGraphPage dependencies from injector to the instance
  @override
  void inject(SuspiGraphPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<SuspiGraphActionMapper>();
    subject.financeController = getDependency<FinanceController>();
  }

  // Inside this method, we register all the SuspiGraphPage dependencies:
  @override
  void register() {
    registerDependency<SuspiGraphActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return SuspiGraphActionMapper(store);
    });
  }
}
