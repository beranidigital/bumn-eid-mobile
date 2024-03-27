import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/employee/employee_page/employee_page.dart';
import 'package:bumn_eid/ui/pages/hc/employee/employee_page/employee_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class EmployeePageGraph extends Graph<EmployeePage> {

  EmployeePageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the EmployeePage dependencies from injector to the instance
  @override
  void inject(EmployeePage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<EmployeePageActionMapper>();
  }

  // Inside this method, we register all the EmployeePage dependencies:
  @override
  void register() {
    registerDependency<EmployeePageActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return EmployeePageActionMapper(store);
    });
  }
}
