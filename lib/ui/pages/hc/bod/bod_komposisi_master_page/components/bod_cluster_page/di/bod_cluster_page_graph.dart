import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/components/bod_cluster_page/bod_cluster_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_komposisi_master_page/components/bod_cluster_page/bod_cluster_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class BODClusterPageGraph extends Graph<BODClusterPage> {

  BODClusterPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BODClusterPage dependencies from injector to the instance
  @override
  void inject(BODClusterPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BODClusterActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the BODClusterPage dependencies:
  @override
  void register() {
    registerDependency<BODClusterActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return BODClusterActionMapper(store);
    });
  }
}
