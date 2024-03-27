import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/covid/covid_company_list/covid_company_list_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_company_list/covid_company_list_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CovidCompanyListPageGraph extends Graph<CovidCompanyListPage> {

  CovidCompanyListPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CovidCompanyListPage dependencies from injector to the instance
  @override
  void inject(CovidCompanyListPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<CovidCompanyListActionMapper>();
    subject.covidController = getDependency<CovidController>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the CovidCompanyListPage dependencies:
  @override
  void register() {
    registerDependency<CovidCompanyListActionMapper>((injector) {
      final store = injector.getDependency<Store<AppState>>();
      return CovidCompanyListActionMapper(store);
    });
  }
}
