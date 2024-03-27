import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/common/company_detail_page/company_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/common/company_detail_page/company_detail_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class CompanyDetailPageGraph extends Graph<CompanyDetailPage> {

  CompanyDetailPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the CompanyDetailPage dependencies from injector to the instance
  @override
  void inject(CompanyDetailPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.store = getDependency<Store<AppState>>();
    subject.companiesController = getDependency<CompaniesController>();
    subject.actionMapper = getDependency<CompanyDetailActionMapper>();
  }

  // Inside this method, we register all the CompanyDetailPage dependencies:
  @override
  void register() {
    registerDependency<CompanyDetailActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return CompanyDetailActionMapper(store);
    });
  }
}
