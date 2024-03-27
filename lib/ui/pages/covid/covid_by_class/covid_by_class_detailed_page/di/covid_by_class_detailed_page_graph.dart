import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_class/covid_by_class_detailed_page/covid_by_class_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_by_class/covid_by_class_detailed_page/covid_by_class_detailed_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CovidByClassDetailedPageGraph extends Graph<CovidByClassDetailedPage> {

  CovidByClassDetailedPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CovidByClassDetailedPage dependencies from injector to the instance
  @override
  void inject(CovidByClassDetailedPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<CovidByClassDetailedActionMapper>();
    subject.companiesController = getDependency<CompaniesController>();
    subject.covidController = getDependency<CovidController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the CovidByClassDetailedPage dependencies:
  @override
  void register() {
    registerDependency<CovidByClassDetailedActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CovidByClassDetailedActionMapper(store);
    });
  }
}
