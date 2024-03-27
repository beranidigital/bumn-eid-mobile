import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/controllers/legal_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_detailed_page/cluster_bumn_detailed_action_mapper.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_detailed_page/cluster_bumn_detailed_page.dart';
import 'package:bumn_eid/ui/pages/legal/legal_category_page/cluster_bumn_detailed_page/legal_category_action_mapper.dart';
import 'package:bumn_eid/ui/pages/legal/legal_category_page/cluster_bumn_detailed_page/legal_category_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class LegalCategoryPageGraph extends Graph<LegalCategoryPage> {

  LegalCategoryPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the LegalCategoryPage dependencies from injector to the instance
  @override
  void inject(LegalCategoryPage subject) {
    subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.actionMapper = getDependency<LegalCategoryActionMapper>();
    subject.legalController = getDependency<LegalController>();
  }

  // Inside this method, we register all the LegalCategoryPage dependencies:
  @override
  void register() {
    registerDependency<LegalCategoryActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return LegalCategoryActionMapper(store);
    });
  }
}
