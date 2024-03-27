import 'package:bumn_eid/core/controllers/pmo_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/pmo/project_detail_page/project_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/pmo/project_detail_page/project_detail_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class ProjectDetailPageGraph extends Graph<ProjectDetailPage> {

  ProjectDetailPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the ProjectDetailPage dependencies from injector to the instance
  @override
  void inject(ProjectDetailPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.pmoController = getDependency<PMOController>();
    subject.actionMapper = getDependency<ProjectDetailActionMapper>();
  }

  // Inside this method, we register all the ProjectDetailPage dependencies:
  @override
  void register() {
    registerDependency<ProjectDetailActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return ProjectDetailActionMapper(store);
    });
  }
}
