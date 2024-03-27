import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/common/kontribusi_negara_page/kontribusi_negara_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class KontribusiNegaraPageGraph extends Graph<KontribusiNegaraPage> {

  KontribusiNegaraPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the KontribusiNegaraPage dependencies from injector to the instance
  @override
  void inject(KontribusiNegaraPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.financeController = getDependency<FinanceController>();
  }

  // Inside this method, we register all the KontribusiNegaraPage dependencies:
  @override
  void register() {}
}
