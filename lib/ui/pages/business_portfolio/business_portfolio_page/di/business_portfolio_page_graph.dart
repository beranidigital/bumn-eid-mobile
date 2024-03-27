import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/business_portfolio_page/business_portfolio_action_mapper.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/business_portfolio_page/business_portfolio_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:redux/redux.dart';

class BusinessPortfolioPageGraph extends Graph<BusinessPortfolioPage> {
  BusinessPortfolioPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the BusinessPortfolioPage dependencies from injector to the instance
  @override
  void inject(BusinessPortfolioPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<BusinessPortfolioActionMapper>();
    subject.jenisController = getDependency<JenisController>();
  }

  // Inside this method, we register all the BusinessPortfolioPage dependencies:
  @override
  void register() {
    registerDependency<BusinessPortfolioActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return BusinessPortfolioActionMapper(store);
    });
  }
}
