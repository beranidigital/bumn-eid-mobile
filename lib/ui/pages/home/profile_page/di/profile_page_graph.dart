import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/home/profile_page/profile_page.dart';
import 'package:bumn_eid/ui/pages/home/profile_page/profile_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:redux/redux.dart';

class ProfilePageGraph extends Graph<ProfilePage> {
  ProfilePageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the ProfilePage dependencies from injector to the instance
  @override
  void inject(ProfilePage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the ProfilePage dependencies:
  @override
  void register() {
    registerDependency<ProfilePageActionMapper>((_) {
      final store = getDependency<Store<AppState>>();
      return ProfilePageActionMapper(store);
    });
  }
}
