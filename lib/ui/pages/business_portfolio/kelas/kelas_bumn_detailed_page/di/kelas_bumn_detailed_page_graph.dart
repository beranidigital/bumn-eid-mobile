import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_detailed_page/kelas_bumn_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_detailed_page/kelas_bumn_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class KelasBumnDetailedPageGraph extends Graph<KelasBumnDetailedPage> {

  KelasBumnDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the KelasBumnDetailedPage dependencies from injector to the instance
  @override
  void inject(KelasBumnDetailedPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<KelasBumnDetailedActionMapper>();
    subject.companiesController = getDependency<CompaniesController>();
    subject.hcController = getDependency<HcController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the KelasBumnDetailedPage dependencies:
  @override
  void register() {
    registerDependency<KelasBumnDetailedActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return KelasBumnDetailedActionMapper(store);
    });
  }
}
