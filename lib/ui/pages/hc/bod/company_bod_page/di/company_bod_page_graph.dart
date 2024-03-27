import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod/company_bod_page/company_bod_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/company_bod_page/company_bod_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CompanyBODPageGraph extends Graph<CompanyBODPage> {

  CompanyBODPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CompanyBODPage dependencies from injector to the instance
  @override
  void inject(CompanyBODPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.companiesController = getDependency<CompaniesController>();
    subject.actionMapper = getDependency<CompanyBODActionMapper>();
  }

  // Inside this method, we register all the CompanyBODPage dependencies:
  @override
  void register() {
    registerDependency<CompanyBODActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CompanyBODActionMapper(store);
    });
  }
}
