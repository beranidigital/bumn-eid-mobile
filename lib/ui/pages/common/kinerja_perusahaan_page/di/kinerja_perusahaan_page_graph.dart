import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/common/kinerja_perusahaan_page/kinerja_perusahaan_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class KinerjaPerusahaanPageGraph extends Graph<KinerjaPerusahaanPage> {

  KinerjaPerusahaanPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the KinerjaPerusahaanPage dependencies from injector to the instance
  @override
  void inject(KinerjaPerusahaanPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.financeController = getDependency<FinanceController>();
  }

  // Inside this method, we register all the KinerjaPerusahaanPage dependencies:
  @override
  void register() {}
}
