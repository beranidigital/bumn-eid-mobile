import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_cluster/bod_1_cluster_page/bod_1_cluster_page.dart';
import 'package:bumn_eid/ui/pages/hc/bod_1/bod_1_cluster/bod_1_cluster_page/bod_1_cluster_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BOD1ClusterPageGraph extends Graph<BOD1ClusterPage> {

  BOD1ClusterPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BOD1ClusterPage dependencies from injector to the instance
  @override
  void inject(BOD1ClusterPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BOD1ClusterActionMapper>();
    subject.hcController = getDependency<HcController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the BOD1ClusterPage dependencies:
  @override
  void register() {
    registerDependency<BOD1ClusterActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BOD1ClusterActionMapper(store);
    });
  }
}
