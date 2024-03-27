import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/profile_bod_1_page/profile_bod1_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/profile_bod_1_page/profile_bod1_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class ProfileBOD1PageGraph extends Graph<ProfileBOD1Page> {

  ProfileBOD1PageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the ProfileBOD1Page dependencies from injector to the instance
  @override
  void inject(ProfileBOD1Page subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.hcController = getDependency<HcController>();
    subject.actionMapper = getDependency<ProfileBOD1ActionMapper>();
  }

  // Inside this method, we register all the ProfileBOD1Page dependencies:
  @override
  void register() {
    registerDependency<ProfileBOD1ActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return ProfileBOD1ActionMapper(store);
    });
  }
}
