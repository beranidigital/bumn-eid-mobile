import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/sector/sektor_bumn_page/sektor_bumn_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/sector/sektor_bumn_page/sektor_bumn_page.dart';
import 'package:redux/redux.dart';

class SektorBumnPageGraph extends Graph<SektorBumnPage> {

  SektorBumnPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the SektorBumnPage dependencies from injector to the instance
  @override
  void inject(SektorBumnPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.jenisController = getDependency<JenisController>();
    subject.companiesController = getDependency<CompaniesController>();
    subject.actionMapper = getDependency<SektorBumnActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the SektorBumnPage dependencies:
  @override
  void register() {
    registerDependency<SektorBumnActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return SektorBumnActionMapper(store);
    });
  }
}
