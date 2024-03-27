import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/sector/sektor_bumn_detailed_page/sektor_bumn_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/sector/sektor_bumn_detailed_page/sektor_bumn_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class SektorBumnDetailedPageGraph extends Graph<SektorBumnDetailedPage> {

  SektorBumnDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the SektorBumnDetailedPage dependencies from injector to the instance
  @override
  void inject(SektorBumnDetailedPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<SektorBumnDetailedActionMapper>();
    subject.companiesController = getDependency<CompaniesController>();
  }

  // Inside this method, we register all the SektorBumnDetailedPage dependencies:
  @override
  void register() {
    registerDependency<SektorBumnDetailedActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return SektorBumnDetailedActionMapper(store);
    });
  }
}
