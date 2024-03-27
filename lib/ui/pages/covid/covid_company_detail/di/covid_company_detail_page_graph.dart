import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/covid_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/common/company_detail_page/company_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/common/company_detail_page/company_detail_page.dart';
import 'package:bumn_eid/ui/pages/covid/covid_company_detail/covid_company_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/covid/covid_company_detail/covid_company_detail_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CovidCompanyDetailPageGraph extends Graph<CovidCompanyDetailPage> {

  CovidCompanyDetailPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CovidCompanyDetailPage dependencies from injector to the instance
  @override
  void inject(CovidCompanyDetailPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.companiesController = getDependency<CompaniesController>();
    subject.covidController = getDependency<CovidController>();
    subject.actionMapper = getDependency<CovidCompanyDetailActionMapper>();
  }

  // Inside this method, we register all the CovidCompanyDetailPage dependencies:
  @override
  void register() {
    registerDependency<CovidCompanyDetailActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CovidCompanyDetailActionMapper(store);
    });
  }
}
