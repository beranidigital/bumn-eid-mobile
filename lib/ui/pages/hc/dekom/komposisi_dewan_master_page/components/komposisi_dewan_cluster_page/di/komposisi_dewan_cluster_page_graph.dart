import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/komposisi_dewan_cluster_page/komposisi_dewan_cluster_action_mapper.dart';
import 'package:bumn_eid/ui/pages/hc/dekom/komposisi_dewan_master_page/components/komposisi_dewan_cluster_page/komposisi_dewan_cluster_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class KomposisiDewanClusterPageGraph extends Graph<KomposisiDewanClusterPage> {

  KomposisiDewanClusterPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the KomposisiDewanClusterPage dependencies from injector to the instance
  @override
  void inject(KomposisiDewanClusterPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<KomposisiDewanClusterActionMapper>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the KomposisiDewanClusterPage dependencies:
  @override
  void register() {
    registerDependency<KomposisiDewanClusterActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return KomposisiDewanClusterActionMapper(store);
    });
  }
}
