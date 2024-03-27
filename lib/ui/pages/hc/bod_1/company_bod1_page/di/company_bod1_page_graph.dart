import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/company_bod1_page/company_bod1_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/company_bod1_page/company_bod1_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CompanyBOD1PageGraph extends Graph<CompanyBOD1Page> {

  CompanyBOD1PageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CompanyBOD1Page dependencies from injector to the instance
  @override
  void inject(CompanyBOD1Page subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.companiesController = getDependency<CompaniesController>();
    subject.actionMapper = getDependency<CompanyBOD1ActionMapper>();
  }

  // Inside this method, we register all the CompanyBOD1Page dependencies:
  @override
  void register() {
    registerDependency<CompanyBOD1ActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CompanyBOD1ActionMapper(store);
    });
  }
}
