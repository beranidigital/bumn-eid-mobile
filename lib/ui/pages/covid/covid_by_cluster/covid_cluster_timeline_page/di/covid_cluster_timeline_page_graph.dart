import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_timeline_page/covid_cluster_timeline_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_cluster/covid_cluster_timeline_page/covid_cluster_timeline_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CovidClusterTimelinePageGraph extends Graph<CovidClusterTimelinePage> {

  CovidClusterTimelinePageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CovidClusterTimelinePage dependencies from injector to the instance
  @override
  void inject(CovidClusterTimelinePage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<CovidClusterTimelineActionMapper>();
    subject.covidController = getDependency<CovidController>();
    subject.hcController = getDependency<HcController>();
  }

  // Inside this method, we register all the CovidClusterTimelinePage dependencies:
  @override
  void register() {
    registerDependency<CovidClusterTimelineActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CovidClusterTimelineActionMapper(store);
    });
  }
}
