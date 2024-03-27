import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/employee/profile_employee_page/profile_employee_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/employee/profile_employee_page/profile_employee_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class ProfileEmployeePageGraph extends Graph<ProfileEmployeePage> {

  ProfileEmployeePageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the ProfileEmployeePage dependencies from injector to the instance
  @override
  void inject(ProfileEmployeePage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.hcController = getDependency<HcController>();
    subject.actionMapper = getDependency<ProfileEmployeeActionMapper>();
  }

  // Inside this method, we register all the ProfileEmployeePage dependencies:
  @override
  void register() {
    registerDependency<ProfileEmployeeActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return ProfileEmployeeActionMapper(store);
    });
  }
}
