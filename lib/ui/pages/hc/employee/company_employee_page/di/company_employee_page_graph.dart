import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/employee/company_employee_page/company_employee_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/employee/company_employee_page/company_employee_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CompanyEmployeePageGraph extends Graph<CompanyEmployeePage> {

  CompanyEmployeePageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CompanyEmployeePage dependencies from injector to the instance
  @override
  void inject(CompanyEmployeePage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.companiesController = getDependency<CompaniesController>();
    subject.actionMapper = getDependency<CompanyEmployeeActionMapper>();
  }

  // Inside this method, we register all the CompanyEmployeePage dependencies:
  @override
  void register() {
    registerDependency<CompanyEmployeeActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CompanyEmployeeActionMapper(store);
    });
  }
}
