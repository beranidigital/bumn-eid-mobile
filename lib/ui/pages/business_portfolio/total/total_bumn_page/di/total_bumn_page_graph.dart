import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/total/total_bumn_page/total_bumn_action_mapper.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/total/total_bumn_page/total_bumn_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class TotalBumnPageGraph extends Graph<TotalBumnPage> {

  TotalBumnPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the TotalBumnPage dependencies from injector to the instance
  @override
  void inject(TotalBumnPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<TotalBumnActionMapper>();
    subject.hcController = getDependency<HcController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the TotalBumnPage dependencies:
  @override
  void register() {
    registerDependency<TotalBumnActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return TotalBumnActionMapper(store);
    });
  }
}
