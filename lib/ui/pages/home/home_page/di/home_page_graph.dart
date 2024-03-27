import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/home/home_page/home_page.dart';
import 'package:bumn_eid/ui/pages/home/home_page/home_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:redux/redux.dart';

class HomePageGraph extends Graph<HomePage> {
  HomePageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the HomePage dependencies from injector to the instance
  @override
  void inject(HomePage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<HomePageActionMapper>();
    subject.companiesController = getDependency<CompaniesController>();
    subject.financeController = getDependency<FinanceController>();
    subject.jenisController = getDependency<JenisController>();
  }

  // Inside this method, we register all the HomePage dependencies:
  @override
  void register() {
    registerDependency<HomePageActionMapper>((_) {
      final store = getDependency<Store<AppState>>();
      return HomePageActionMapper(store);
    });
  }
}
