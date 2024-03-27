import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_class/covid_by_class_page/covid_by_class_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_class/covid_by_class_page/covid_by_class_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CovidByClassPageGraph extends Graph<CovidByClassPage> {

  CovidByClassPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CovidByClassPage dependencies from injector to the instance
  @override
  void inject(CovidByClassPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.hcController = getDependency<HcController>();
    subject.covidController = getDependency<CovidController>();
    subject.actionMapper = getDependency<CovidByClassActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the CovidByClassPage dependencies:
  @override
  void register() {
    registerDependency<CovidByClassActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CovidByClassActionMapper(store);
    });
  }
}
