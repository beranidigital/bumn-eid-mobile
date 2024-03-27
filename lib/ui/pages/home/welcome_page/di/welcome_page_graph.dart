import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/utils.dart';
import 'package:bumn_eid/ui/pages/home/welcome_page/bloc/welcome_page_action_mapper.dart';
import 'package:bumn_eid/ui/pages/home/welcome_page/bloc/welcome_page_bloc.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/pages/home/welcome_page/welcome_page.dart';
import 'package:redux/redux.dart';

class WelcomePageGraph extends Graph<WelcomePage> {

  WelcomePageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the WelcomePage dependencies from injector to the instance
  @override
  void inject(WelcomePage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.utils = getDependency<Utils>();
    subject.bloc = getDependency<WelcomePageBloc>();
  }

  // Inside this method, we register all the WelcomePage dependencies:
  @override
  void register() {
    registerDependency<WelcomePageBloc>((_) {
      final store = getDependency<Store<AppState>>();
      final actionMapper = WelcomePageActionMapper(store);
      return WelcomePageBloc(actionMapper: actionMapper);
    });
  }
}
