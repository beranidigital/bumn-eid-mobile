import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_page/kelas_bumn_action_mapper.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/kelas/kelas_bumn_page/kelas_bumn_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class KelasBumnPageGraph extends Graph<KelasBumnPage> {

  KelasBumnPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the KelasBumnPage dependencies from injector to the instance
  @override
  void inject(KelasBumnPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.hcController = getDependency<HcController>();
    subject.companiesController = getDependency<CompaniesController>();
    subject.actionMapper = getDependency<KelasBumnActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the KelasBumnPage dependencies:
  @override
  void register() {
    registerDependency<KelasBumnActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return KelasBumnActionMapper(store);
    });
  }
}
