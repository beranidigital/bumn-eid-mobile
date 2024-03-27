import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_detailed_page/covid_cluster_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_detailed_page/covid_cluster_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CovidClusterDetailedPageGraph extends Graph<CovidClusterDetailedPage> {

  CovidClusterDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CovidClusterDetailedPage dependencies from injector to the instance
  @override
  void inject(CovidClusterDetailedPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<CovidClusterDetailedActionMapper>();
    subject.covidController = getDependency<CovidController>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the CovidClusterDetailedPage dependencies:
  @override
  void register() {
    registerDependency<CovidClusterDetailedActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CovidClusterDetailedActionMapper(store);
    });
  }
}
