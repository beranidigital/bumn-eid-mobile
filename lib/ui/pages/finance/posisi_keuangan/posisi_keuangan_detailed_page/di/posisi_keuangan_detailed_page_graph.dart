import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/posisi_keuangan/posisi_keuangan_detailed_page/posisi_keuangan_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/posisi_keuangan/posisi_keuangan_detailed_page/posisi_keuangan_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class PosisiKeuanganDetailedPageGraph extends Graph<PosisiKeuanganDetailedPage> {

  PosisiKeuanganDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the PosisiKeuanganDetailedPage dependencies from injector to the instance
  @override
  void inject(PosisiKeuanganDetailedPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<PosisiKeuanganDetailedActionMapper>();
    subject.financeController = getDependency<FinanceController>();
  }

  // Inside this method, we register all the PosisiKeuanganDetailedPage dependencies:
  @override
  void register() {
    registerDependency<PosisiKeuanganDetailedActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return PosisiKeuanganDetailedActionMapper(store);
    });
  }
}
