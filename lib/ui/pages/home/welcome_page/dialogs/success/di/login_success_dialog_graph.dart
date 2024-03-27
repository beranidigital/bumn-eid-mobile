import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/home/welcome_page/dialogs/success/login_success_dialog.dart';
import 'package:injector/injector.dart';
import 'package:redux/redux.dart';

class LoginSuccessDialogGraph extends Graph<LoginSuccessDialog> {

  LoginSuccessDialogGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the LoginSuccessDialog dependencies from injector to the instance
  @override
  void inject(LoginSuccessDialog subject) {
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the LoginSuccessDialog dependencies:
  @override
  void register() {
  }
}
