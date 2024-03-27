import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/covid/covid_page/covid_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_page/covid_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CovidPageGraph extends Graph<CovidPage> {

  CovidPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CovidPage dependencies from injector to the instance
  @override
  void inject(CovidPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<CovidActionMapper>();
    subject.covidController = getDependency<CovidController>();
  }

  // Inside this method, we register all the CovidPage dependencies:
  @override
  void register() {
    registerDependency<CovidActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CovidActionMapper(store);
    });
  }
}
