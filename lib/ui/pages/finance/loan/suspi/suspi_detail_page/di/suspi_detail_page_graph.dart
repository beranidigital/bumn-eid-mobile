import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/loan/suspi/suspi_detail_page/suspi_detail_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class SuspiDetailPageGraph extends Graph<SuspiDetailPage> {

  SuspiDetailPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the SuspiDetailPage dependencies from injector to the instance
  @override
  void inject(SuspiDetailPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.financeController = getDependency<FinanceController>();
  }

  // Inside this method, we register all the SuspiDetailPage dependencies:
  @override
  void register() {}
}
