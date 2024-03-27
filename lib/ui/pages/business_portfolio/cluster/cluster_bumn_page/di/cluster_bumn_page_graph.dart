import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_page/cluster_bumn_action_mapper.dart';
import 'package:bumn_eid/ui/pages/business_portfolio/cluster/cluster_bumn_page/cluster_bumn_page.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:redux/redux.dart';

class ClusterBumnPageGraph extends Graph<ClusterBumnPage> {

  ClusterBumnPageGraph([Injector injector]) : super(injector);

  // Inside this method, we inject the ClusterBumnPage dependencies from injector to the instance
  @override
  void inject(ClusterBumnPage subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
    subject.colorPalette = getDependency<ColorPalette>();
    subject.hcController = getDependency<HcController>();
    subject.companiesController = getDependency<CompaniesController>();
    subject.actionMapper = getDependency<ClusterBumnActionMapper>();
    subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the ClusterBumnPage dependencies:
  @override
  void register() {
    registerDependency<ClusterBumnActionMapper>((injector) {
      final store = getDependency<Store<AppState>>();
      return ClusterBumnActionMapper(store);
    });
  }
}
