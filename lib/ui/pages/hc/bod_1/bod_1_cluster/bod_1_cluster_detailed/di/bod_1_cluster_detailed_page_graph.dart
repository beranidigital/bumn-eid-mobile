import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_cluster/bod_1_cluster_detailed/bod_1_cluster_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_cluster/bod_1_cluster_detailed/bod_1_cluster_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BOD1ClusterDetailedPageGraph extends Graph<BOD1ClusterDetailedPage> {

  BOD1ClusterDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BOD1ClusterDetailedPage dependencies from injector to the instance
  @override
  void inject(BOD1ClusterDetailedPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BOD1ClusterDetailedActionMapper>();
    subject.hcController = getDependency<HcController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the BOD1ClusterDetailedPage dependencies:
  @override
  void register() {
    registerDependency<BOD1ClusterDetailedActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BOD1ClusterDetailedActionMapper(store);
    });
  }
}
