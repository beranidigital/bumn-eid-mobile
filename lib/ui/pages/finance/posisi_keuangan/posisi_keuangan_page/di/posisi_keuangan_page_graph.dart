import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/finance/posisi_keuangan/posisi_keuangan_page/posisi_keuangan_action_mapper.dart';
import 'package:bumn_eid/ui/pages/finance/posisi_keuangan/posisi_keuangan_page/posisi_keuangan_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class PosisiKeuanganPageGraph extends Graph<PosisiKeuanganPage> {

  PosisiKeuanganPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the PosisiKeuanganPage dependencies from injector to the instance
  @override
  void inject(PosisiKeuanganPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<PosisiKeuanganActionMapper>();
    subject.financeController = getDependency<FinanceController>();
  }

  // Inside this method, we register all the PosisiKeuanganPage dependencies:
  @override
  void register() {
    registerDependency<PosisiKeuanganActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return PosisiKeuanganActionMapper(store);
    });
  }
}
