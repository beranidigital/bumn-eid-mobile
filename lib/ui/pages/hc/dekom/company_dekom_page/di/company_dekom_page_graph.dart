import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/company_dekom_page/company_dekom_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/company_dekom_page/company_dekom_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CompanyDekomPageGraph extends Graph<CompanyDekomPage> {

  CompanyDekomPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CompanyDekomPage dependencies from injector to the instance
  @override
  void inject(CompanyDekomPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.companiesController = getDependency<CompaniesController>();
    subject.actionMapper = getDependency<CompanyDekomActionMapper>();
  }

  // Inside this method, we register all the CompanyDekomPage dependencies:
  @override
  void register() {
    registerDependency<CompanyDekomActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CompanyDekomActionMapper(store);
    });
  }
}
