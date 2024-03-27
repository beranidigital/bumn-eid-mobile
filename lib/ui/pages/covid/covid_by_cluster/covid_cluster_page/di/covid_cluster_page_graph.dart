import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_page/covid_cluster_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_page/covid_cluster_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CovidClusterPageGraph extends Graph<CovidClusterPage> {

  CovidClusterPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CovidClusterPage dependencies from injector to the instance
  @override
  void inject(CovidClusterPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.hcController = getDependency<HcController>();
    subject.covidController = getDependency<CovidController>();
    subject.actionMapper = getDependency<CovidClusterActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the CovidClusterPage dependencies:
  @override
  void register() {
    registerDependency<CovidClusterActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CovidClusterActionMapper(store);
    });
  }
}
